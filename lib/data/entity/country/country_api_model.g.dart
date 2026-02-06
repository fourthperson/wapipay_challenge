// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CountryApiModel _$CountryApiModelFromJson(Map<String, dynamic> json) =>
    _CountryApiModel(
      name: json['name'] as String?,
      code: json['code'] as String?,
      isoCode: json['isoCode'] as String?,
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CountryApiModelToJson(_CountryApiModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'isoCode': instance.isoCode,
      'flag': instance.flag,
    };
