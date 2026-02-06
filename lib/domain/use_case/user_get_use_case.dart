import 'package:wapipay_challenge/domain/entity/user.dart';
import 'package:wapipay_challenge/domain/repository/user_repository.dart';

class UserGetUseCase {
  final UserRepository _userRepository;

  UserGetUseCase({required UserRepository userRepository})
    : _userRepository = userRepository;

  Future<User?> invoke() async {
    final User? user = await _userRepository.getUser();
    return user;
  }
}
