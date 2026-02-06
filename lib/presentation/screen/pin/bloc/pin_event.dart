part of 'pin_bloc.dart';

sealed class PinEvent extends Equatable {
  const PinEvent();
  @override
  List<Object?> get props => [];
}

class PinSubmittedEvent extends PinEvent {
  final String enteredPin;
  const PinSubmittedEvent(this.enteredPin);

  @override
  List<Object?> get props => [enteredPin];
}
