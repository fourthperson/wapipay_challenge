import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/domain/repository/country_repository.dart';

class CountryGetUseCase {
  final CountryRepository _countryRepository;

  CountryGetUseCase({required CountryRepository countryRepository})
    : _countryRepository = countryRepository;

  Future<List<Country>?> invoke() async {
    final List<Country>? list = await _countryRepository.getCountries();
    return list;
  }
}
