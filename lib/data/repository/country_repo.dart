import 'package:wapipay_challenge/data/entity/country/country_api_model.dart';
import 'package:wapipay_challenge/data/source/api/api_data_source.dart';

import 'package:wapipay_challenge/domain/entity/country.dart';
import 'package:wapipay_challenge/domain/repository/country_repository.dart';

class CountryRepoImpl extends CountryRepository {
  final ApiDataSource _apiDataSource;

  CountryRepoImpl({required ApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  @override
  Future<List<Country>?> getCountries() async {
    final List<CountryApiModel>? apiList = await _apiDataSource.getCountries();
    if (apiList == null) return null;
    final List<Country> list = [];
    for (int i = 0; i < apiList.length; i++) {
      list.add(apiList[i].toDomain());
    }
    return list;
  }
}
