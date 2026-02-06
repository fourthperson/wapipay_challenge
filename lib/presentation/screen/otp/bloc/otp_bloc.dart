import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';
import 'package:wapipay_challenge/domain/use_case/otp_verify_use_case.dart';
import 'package:wapipay_challenge/presentation/util/config.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpVerifyUseCase _otpVerifyUseCase;
  StreamSubscription<int>? _timerSubscription;

  OtpBloc({required OtpVerifyUseCase otpVerifyUseCase})
    : _otpVerifyUseCase = otpVerifyUseCase,
      super(const OtpState()) {
    on<OtpTimerTickedEvent>(_onTimerTicked);
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
        emit(state.copyWith(status: OtpStatus.success, otpResult: result));
      } else if (result is IncorrectOtpResult) {
        emit(
          state.copyWith(
            status: OtpStatus.failure,
            errorMessage: 'Incorrect OTP',
          ),
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
