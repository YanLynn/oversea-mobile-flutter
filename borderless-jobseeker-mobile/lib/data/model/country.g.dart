// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    json['completed'] as bool,
    json['checkcount'] as String,
    json['id'] as int,
    json['country_name'] as String,
    json['continent_name'] as String,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'checkcount': instance.checkcount,
      'id': instance.id,
      'country_name': instance.country_name,
      'continent_name': instance.continent_name,
      'error': instance.error,
    };
