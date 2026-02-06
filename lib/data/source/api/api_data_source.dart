import 'package:wapipay_challenge/data/entity/country/country_api_model.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';

abstract class ApiDataSource {
  Future<List<CountryApiModel>?> getCountries();

  Future<AuthResult> authenticate(String phone);

  Future<OtpResult> verifyOtp(String phone, String otp);
}
