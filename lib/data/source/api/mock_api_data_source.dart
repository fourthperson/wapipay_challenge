import 'dart:math';

import 'package:logger/logger.dart';
import 'package:wapipay_challenge/data/entity/country/country_api_model.dart';
import 'package:wapipay_challenge/data/entity/user/user_api_model.dart';
import 'package:wapipay_challenge/data/source/api/api_data_source.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';

class MockApiDataSource extends ApiDataSource {
  final Random _random;
  final Logger? _logger;

  MockApiDataSource({required Random random, Logger? logger})
    : _random = random,
      _logger = logger;

  int get _delay => _random.nextInt(1001) + 2000;

  @override
  Future<List<CountryApiModel>?> getCountries() async {
    try {
      await Future.delayed(Duration(milliseconds: _delay));
      final List<CountryApiModel> list = [];
      for (int i = 0; i < _countries.length; i++) {
        final Map<String, String> item = _countries[i];
        list.add(CountryApiModel.fromJson(item));
      }
      return list;
    } catch (e) {
      _logger?.e(e);
    }
    return null;
  }

  @override
  Future<AuthResult> authenticate(String phone) async {
    try {
      await Future.delayed(Duration(milliseconds: _delay));

      phone = phone.replaceAll('+', '');

      // test number to simulate an error
      if (phone == '254722000000') {
        return FailedAuthResult();
      }

      Map<String, dynamic>? foundUser;

      for (final Map<String, dynamic> user in _mockUsers) {
        if (user['phone'] == phone) {
          foundUser = user;
          break;
        }
      }

      if (foundUser != null) {
        final UserApiModel apiUser = UserApiModel.fromJson(foundUser);
        return SuccessLoginResult(user: apiUser.toDomain());
      } else {
        return UnregisteredLoginResult(phone: phone);
      }
    } catch (e) {
      _logger?.e(e);
    }
    return FailedAuthResult();
  }

  @override
  Future<OtpResult> verifyOtp(String phone, String otp) async {
    try {
      await Future.delayed(Duration(milliseconds: _delay));

      phone = phone.replaceAll('+', '');

      final List<UserApiModel> users = [];
      for (int i = 0; i < _mockUsers.length; i++) {
        final Map<String, dynamic> user = _mockUsers[i];
        users.add(UserApiModel.fromJson(user));
      }

      for (int i = 0; i < users.length; i++) {
        final UserApiModel user = users[i];
        if (user.phone == phone && user.otp == otp) {
          return SuccessfulOtpResult(user: user.toDomain());
        }
      }
      return IncorrectOtpResult();
    } catch (e) {
      _logger?.e(e);
    }
    return FailedOtpResult();
  }

  static final List<Map<String, String>> _countries = [
    {
      'name': 'Kenya',
      'code': '+254',
      'isoCode': 'KE',
      'flag': 'https://flagcdn.com/w320/ke.png',
    },
    {
      'name': 'Nigeria',
      'code': '+234',
      'isoCode': 'NG',
      'flag': 'https://flagcdn.com/w320/ng.png',
    },
    {
      'name': 'Tanzania',
      'code': '+255',
      'isoCode': 'TZ',
      'flag': 'https://flagcdn.com/w320/tz.png',
    },
    {
      'name': 'Uganda',
      'code': '+256',
      'isoCode': 'UG',
      'flag': 'https://flagcdn.com/w320/ug.png',
    },
    {
      'name': 'Ghana',
      'code': '+233',
      'isoCode': 'GH',
      'flag': 'https://flagcdn.com/w320/gh.png',
    },
    {
      'name': 'South Africa',
      'code': '+27',
      'isoCode': 'ZA',
      'flag': 'https://flagcdn.com/w320/za.png',
    },
    {
      'name': 'Ethiopia',
      'code': '+251',
      'isoCode': 'ET',
      'flag': 'https://flagcdn.com/w320/et.png',
    },
    {
      'name': 'Egypt',
      'code': '+20',
      'isoCode': 'EG',
      'flag': 'https://flagcdn.com/w320/eg.png',
    },
    {
      'name': 'India',
      'code': '+91',
      'isoCode': 'IN',
      'flag': 'https://flagcdn.com/w320/in.png',
    },
    {
      'name': 'China',
      'code': '+86',
      'isoCode': 'CN',
      'flag': 'https://flagcdn.com/w320/cn.png',
    },
    {
      'name': 'Singapore',
      'code': '+65',
      'isoCode': 'SG',
      'flag': 'https://flagcdn.com/w320/sg.png',
    },
    {
      'name': 'United Arab Emirates',
      'code': '+971',
      'isoCode': 'AE',
      'flag': 'https://flagcdn.com/w320/ae.png',
    },
    {
      'name': 'Japan',
      'code': '+81',
      'isoCode': 'JP',
      'flag': 'https://flagcdn.com/w320/jp.png',
    },
    {
      'name': 'Pakistan',
      'code': '+92',
      'isoCode': 'PK',
      'flag': 'https://flagcdn.com/w320/pk.png',
    },
    {
      'name': 'Indonesia',
      'code': '+62',
      'isoCode': 'ID',
      'flag': 'https://flagcdn.com/w320/id.png',
    },
    {
      'name': 'Malaysia',
      'code': '+60',
      'isoCode': 'MY',
      'flag': 'https://flagcdn.com/w320/my.png',
    },
  ];

  static final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': 'f47ac10b-58cc-4372-a567-0e02b2c3d479',
      'phone': '254700111222',
      'fullName': 'Test Kenyan',
      'otp': '123456',
      'pin': '1111',
    },
    {
      'id': '550e8400-e29b-41d4-a716-446655440000',
      'phone': '254701512131',
      'fullName': 'Ian Kariithi',
      'otp': '654321',
      'pin': '2222',
    },
    {
      'id': '67c3c572-132d-4533-80e2-632b49c0d383',
      'phone': '2348031234567',
      'fullName': 'Chidi Okoro',
      'otp': '111222',
      'pin': '3333',
    },
    {
      'id': 'a1b2c3d4-e5f6-4a5b-8c9d-0e1f2a3b4c5d',
      'phone': '2349015556677',
      'fullName': 'Nigerian Prince',
      'otp': '333444',
      'pin': '4444',
    },
    {
      'id': '7b9e1c2d-3f4a-5b6c-7d8e-9f0a1b2c3d4e',
      'phone': '8613912345678',
      'fullName': 'Wei Chen',
      'otp': '888999',
      'pin': '5555',
    },
    {
      'id': '123e4567-e89b-12d3-a456-426614174000',
      'phone': '8615098765432',
      'fullName': 'Test Chinese',
      'otp': '000000',
      'pin': '6666',
    },
  ];
}
