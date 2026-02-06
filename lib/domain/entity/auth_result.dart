import 'package:wapipay_challenge/domain/entity/user.dart';

sealed class AuthResult {}

class SuccessLoginResult extends AuthResult {
  final User user;

  SuccessLoginResult({required this.user});
}

class UnregisteredLoginResult extends AuthResult {
  final String phone;

  UnregisteredLoginResult({required this.phone});
}

class FailedAuthResult extends AuthResult {}
