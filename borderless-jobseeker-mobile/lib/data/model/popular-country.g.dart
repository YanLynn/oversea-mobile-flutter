// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular-country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularCountryModel _$PopularCountryModelFromJson(Map<String, dynamic> json) {
  return PopularCountryModel(
    json['field_id'] as int,
    json['completed'] as bool,
    json['country_name'] as String,
    json['continent_name'] as String,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$PopularCountryModelToJson(
        PopularCountryModel instance) =>
    <String, dynamic>{
      'field_id': instance.field_id,
      'completed': instance.completed,
      'country_name': instance.country_name,
      'continent_name': instance.continent_name,
      'error': instance.error,
    };
