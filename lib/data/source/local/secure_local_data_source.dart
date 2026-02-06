import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:wapipay_challenge/data/entity/user/user_api_model.dart';
import 'package:wapipay_challenge/data/source/local/local_data_source.dart';

class SecureLocalDataSource extends LocalDataSource {
  final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
  );
  final Logger? _logger;

  final String _userKey = 'user';

  SecureLocalDataSource({required Logger? logger}) : _logger = logger;

  @override
  Future<void> clearUser() async {
    await _storage.delete(key: _userKey);
  }

  @override
  Future<UserApiModel?> getUser() async {
    try {
      final String? json = await _storage.read(key: _userKey);
      final Map<String, dynamic> map =
          jsonDecode(json!) as Map<String, dynamic>;
      return UserApiModel.fromJson(map);
    } catch (e) {
      _logger?.e(e);
    }
    return null;
  }

  @override
  Future<void> setUser(UserApiModel user) async {
    try {
      final String json = jsonEncode(user.toJson());
      await _storage.write(key: _userKey, value: json);
    } catch (e) {
      _logger?.e(e);
    }
  }
}
