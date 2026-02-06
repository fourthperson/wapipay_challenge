import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';
import 'package:wapipay_challenge/domain/use_case/otp_verify_use_case.dart';
import 'package:wapipay_challenge/domain/use_case/user_set_use_case.dart';
import 'package:wapipay_challenge/presentation/util/config.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpVerifyUseCase _otpVerifyUseCase;
  final UserSetUseCase _userSetUseCase;
  StreamSubscription<int>? _timerSubscription;

  OtpBloc({
    required OtpVerifyUseCase otpVerifyUseCase,
    required UserSetUseCase userSetUseCase,
  }) : _otpVerifyUseCase = otpVerifyUseCase,
       _userSetUseCase = userSetUseCase,
       super(const OtpState()) {
    on<OtpTimerTickedEvent>(_onTimerTicked);
    on<OtpInputChangedEvent>(_onInputChanged);
    on<OtpVerifySubmittedEvent>(_onVerifySubmitted);
    on<OtpResendRequestedEvent>(_onResendRequested);

    _startTimer();
  }

  void _startTimer() {
    final int seconds = Config.otpTimeMinutes * 60;
    _timerSubscription?.cancel();
    _timerSubscription =
        Stream.periodic(
              const Duration(seconds: 1),
              (int x) => (seconds - 1) - x,
            )
            .take(seconds)
            .listen((int remaining) => add(OtpTimerTickedEvent(remaining)));
  }

  void _onTimerTicked(OtpTimerTickedEvent event, Emitter<OtpState> emit) {
    emit(
      state.copyWith(
        remainingTime: event.duration,
        canResend: event.duration == 0,
      ),
    );
  }

  void _onInputChanged(OtpInputChangedEvent event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpResult: () => null, status: OtpStatus.initial));
  }

  Future<void> _onVerifySubmitted(
    OtpVerifySubmittedEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.loading));

    try {
      final OtpResult result = await _otpVerifyUseCase.invoke(
        phone: event.phone,
        otp: event.otp,
      );

      if (result is SuccessfulOtpResult) {
        await _userSetUseCase.invoke(user: result.user);
        emit(
          state.copyWith(status: OtpStatus.success, otpResult: () => result),
        );
      } else if (result is IncorrectOtpResult) {
        emit(
          state.copyWith(status: OtpStatus.success, otpResult: () => result),
        );
      } else {
        emit(
          state.copyWith(
            status: OtpStatus.failure,
            errorMessage: 'Verification failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: OtpStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onResendRequested(
    OtpResendRequestedEvent event,
    Emitter<OtpState> emit,
  ) async {
    emit(state.copyWith(status: OtpStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: OtpStatus.initial));
    _startTimer();
  }

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }
}
