part of 'pin_bloc.dart';

enum PinStatus { initial, loading, success, failure }

class PinState extends Equatable {
  final PinStatus status;
  final String? errorMessage;

  const PinState({this.status = PinStatus.initial, this.errorMessage});

  PinState copyWith({PinStatus? status, String? errorMessage}) {
    return PinState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
