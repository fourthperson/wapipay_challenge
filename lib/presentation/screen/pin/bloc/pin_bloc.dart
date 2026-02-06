import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    emit(state.copyWith(status: PinStatus.loading));

    try {
      // 1. Fetch the stored user locally (from repo/shared prefs via UseCase)
      final user = await _userGetUseCase.invoke();

      if (user == null) {
        emit(
          state.copyWith(
            status: PinStatus.failure,
            errorMessage: 'User profile not found. Please log in again.',
          ),
        );
        return;
      }

      // 2. Compare the entered PIN with the one from the UseCase
      if (event.enteredPin == user.pin) {
        emit(state.copyWith(status: PinStatus.success));
      } else {
        emit(
          state.copyWith(
            status: PinStatus.failure,
            errorMessage: 'The PIN you entered is incorrect.',
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
