import 'package:wapipay_challenge/domain/entity/country.dart';

class Config {
  static Country defaultCountry = const Country(
    iso: 'KE',
    flag: 'https://flagcdn.com/w320/ke.png',
    code: '+254',
    name: 'Kenya',
  );

  static int otpTimeMinutes = 1;

  static String privacyPolicyUrl = 'https://wapipay.com/privacy_policy';
  static String termsOfServiceUrl = 'https://wapipay.com/terms_of_service';
}
