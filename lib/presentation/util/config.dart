import 'package:wapipay_challenge/domain/entity/country.dart';

class Config {
  static Country defaultCountry = const Country(
    iso: 'KE',
    flag: 'https://flagcdn.com/w320/ke.png',
    code: '+254',
    name: 'Kenya',
  );

  static int otpTimeMinutes = 1;
}
