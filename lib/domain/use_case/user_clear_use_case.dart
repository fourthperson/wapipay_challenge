import 'package:wapipay_challenge/domain/repository/user_repository.dart';

class UserClearUseCase {
  final UserRepository _userRepository;

  UserClearUseCase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<void> invoke() async {
    await _userRepository.clearUser();
  }
}
