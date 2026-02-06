import 'package:wapipay_challenge/data/entity/user/user_api_model.dart';
import 'package:wapipay_challenge/data/source/local/local_data_source.dart';
import 'package:wapipay_challenge/domain/entity/user.dart';
import 'package:wapipay_challenge/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final LocalDataSource _localDataSource;

  UserRepositoryImpl({required LocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<void> clearUser() async {
    return await _localDataSource.clearUser();
  }

  @override
  Future<User?> getUser() async {
    final userApiModel = await _localDataSource.getUser();
    return userApiModel?.toDomain();
  }

  @override
  Future<void> setUser(User user) {
    return _localDataSource.setUser(UserApiModel.fromDomain(user));
  }
}
