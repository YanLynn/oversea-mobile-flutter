// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getcity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getcity _$GetcityFromJson(Map<String, dynamic> json) {
  return Getcity(
    json['id'] as int,
    json['city_name'] as String,
    json['country_name'] as String,
    json['continent_name'] as String,
  );
}

Map<String, dynamic> _$GetcityToJson(Getcity instance) => <String, dynamic>{
      'id': instance.id,
      'city_name': instance.city_name,
      'country_name': instance.country_name,
      'continent_name': instance.continent_name,
    };
