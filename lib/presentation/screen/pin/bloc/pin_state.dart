part of 'pin_bloc.dart';

enum PinStatus {
  initial,
  loading,
  success,
  incorrect,
  temporarilyLocked,
  failure,
}

class PinState extends Equatable {
  final PinStatus status;
  final String? errorMessage;
  final int attempts;

  const PinState({
    this.status = PinStatus.initial,
    this.errorMessage,
    this.attempts = 0,
  });

  PinState copyWith({PinStatus? status, String? errorMessage, int? attempts}) {
    return PinState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      attempts: attempts ?? this.attempts,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, attempts];
}
