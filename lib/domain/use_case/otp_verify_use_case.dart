import 'package:wapipay_challenge/domain/entity/otp_result.dart';
import 'package:wapipay_challenge/domain/repository/auth_repository.dart';

class OtpVerifyUseCase {
  final AuthRepository _authRepository;

  OtpVerifyUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<OtpResult> invoke({required String phone, required String otp}) async {
    final OtpResult result = await _authRepository.verifyOtp(phone, otp);
    return result;
  }
}
