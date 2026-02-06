import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';

abstract class AuthRepository {
  Future<AuthResult> authenticate(String phone);

  Future<OtpResult> verifyOtp(String phone, String otp);
}
