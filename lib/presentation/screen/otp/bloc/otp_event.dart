part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class OtpTimerTickedEvent extends OtpEvent {
  final int duration;

  const OtpTimerTickedEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

class OtpVerifySubmittedEvent extends OtpEvent {
  final String phone;
  final String otp;

  const OtpVerifySubmittedEvent({required this.phone, required this.otp});

  @override
  List<Object?> get props => [phone, otp];
}

class OtpResendRequestedEvent extends OtpEvent {
  final String phone;

  const OtpResendRequestedEvent({required this.phone});

  @override
  List<Object?> get props => [phone];
}
