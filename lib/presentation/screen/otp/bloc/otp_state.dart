part of 'otp_bloc.dart';

enum OtpStatus { initial, loading, success, failure }

class OtpState extends Equatable {
  final OtpStatus status;
  final int remainingTime;
  final bool canResend;
  final String? errorMessage;
  final OtpResult? otpResult;

  const OtpState({
    this.status = OtpStatus.initial,
    this.remainingTime = 60,
    this.canResend = false,
    this.errorMessage,
    this.otpResult,
  });

  OtpState copyWith({
    OtpStatus? status,
    int? remainingTime,
    bool? canResend,
    String? errorMessage,
    OtpResult? Function()? otpResult,
  }) {
    return OtpState(
      status: status ?? this.status,
      remainingTime: remainingTime ?? this.remainingTime,
      canResend: canResend ?? this.canResend,
      errorMessage: errorMessage ?? this.errorMessage,
      otpResult: otpResult != null ? otpResult() : this.otpResult,
    );
  }

  @override
  List<Object?> get props => [
    status,
    remainingTime,
    canResend,
    errorMessage,
    otpResult,
  ];
}
