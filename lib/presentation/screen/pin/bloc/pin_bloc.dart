import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wapipay_challenge/domain/entity/user.dart';
import 'package:wapipay_challenge/domain/use_case/user_get_use_case.dart';

part 'pin_event.dart';

part 'pin_state.dart';

class PinBloc extends Bloc<PinEvent, PinState> {
  final UserGetUseCase _userGetUseCase;

  PinBloc({required UserGetUseCase userGetUseCase})
    : _userGetUseCase = userGetUseCase,
      super(const PinState()) {
    on<PinSubmittedEvent>(_onPinSubmitted);
  }

  Future<void> _onPinSubmitted(
    PinSubmittedEvent event,
    Emitter<PinState> emit,
  ) async {
    if (state.status == PinStatus.temporarilyLocked) return;

    emit(state.copyWith(status: PinStatus.loading));

    await Future.delayed(const Duration(seconds: 1));

    try {
      final User? user = await _userGetUseCase.invoke();

      if (user == null) {
        emit(
          state.copyWith(
            status: PinStatus.failure,
            errorMessage: 'User profile not found. Please log in again.',
          ),
        );
        return;
      }

      if (event.enteredPin == user.pin) {
        emit(state.copyWith(status: PinStatus.success, attempts: 0));
      } else {
        final int attempts = state.attempts + 1;
        if (attempts >= 3) {
          emit(
            state.copyWith(
              status: PinStatus.temporarilyLocked,
              attempts: attempts,
              errorMessage: 'Too many failed attempts.',
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            status: PinStatus.incorrect,
            attempts: attempts,
            errorMessage: 'Incorrect PIN. ${3 - attempts} attempts remaining',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PinStatus.failure,
          errorMessage: 'An error occurred. Please try again.',
        ),
      );
    }
  }
}
