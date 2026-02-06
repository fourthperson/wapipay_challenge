import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/repository/auth_repository.dart';

class PhoneCheckUseCase {
  final AuthRepository _authRepository;

  PhoneCheckUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  Future<AuthResult> invoke({required String phone}) async {
    final AuthResult result = await _authRepository.authenticate(phone);
    return result;
  }
}
