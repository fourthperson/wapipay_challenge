import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wapipay_challenge/domain/entity/country.dart';

part 'country_api_model.freezed.dart';

part 'country_api_model.g.dart';

@freezed
abstract class CountryApiModel with _$CountryApiModel {
  const CountryApiModel._();

  const factory CountryApiModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'code') String? code,
    @JsonKey(name: 'isoCode') String? isoCode,
    @JsonKey(name: 'flag') String? flag,
  }) = _CountryApiModel;

  factory CountryApiModel.fromJson(Map<String, Object?> json) =>
      _$CountryApiModelFromJson(json);

  Country toDomain() {
    return Country(
      iso: isoCode ?? '',
      flag: flag ?? '',
      code: code ?? '',
      name: name ?? '',
    );
  }
}
