// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getcountry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getcountry _$GetcountryFromJson(Map<String, dynamic> json) {
  return Getcountry(
    json['id'] as int,
    json['city_name'] as String,
    json['country_name'] as String,
    json['continent_name'] as String,
  );
}

Map<String, dynamic> _$GetcountryToJson(Getcountry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city_name': instance.city_name,
      'country_name': instance.country_name,
      'continent_name': instance.continent_name,
    };
