import 'package:wapipay_challenge/domain/entity/user.dart';

sealed class OtpResult {}

class SuccessfulOtpResult extends OtpResult {
  final User user;

  SuccessfulOtpResult({required this.user});
}

class IncorrectOtpResult extends OtpResult {}

class FailedOtpResult extends OtpResult {}
