import 'package:wapipay_challenge/domain/entity/user.dart';

abstract class UserRepository {
  Future<User?> getUser();

  Future<void> setUser(User user);

  Future<void> clearUser();
}
