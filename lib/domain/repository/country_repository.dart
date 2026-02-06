import 'package:wapipay_challenge/domain/entity/country.dart';

abstract class CountryRepository {
  Future<List<Country>?> getCountries();
}
