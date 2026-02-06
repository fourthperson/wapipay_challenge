import 'package:wapipay_challenge/domain/entity/user.dart';
import 'package:wapipay_challenge/domain/repository/user_repository.dart';

class UserSetUseCase {
  final UserRepository _userRepository;

  UserSetUseCase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<void> invoke({required User user}) async {
    await _userRepository.setUser(user);
  }
}
