import 'package:wapipay_challenge/data/entity/user/user_api_model.dart';

abstract class LocalDataSource {
  Future<UserApiModel?> getUser();

  Future<void> setUser(UserApiModel user);

  Future<void> clearUser();
}
