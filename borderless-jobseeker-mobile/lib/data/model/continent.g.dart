// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'continent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContinentModel _$ContinentModelFromJson(Map<String, dynamic> json) {
  return ContinentModel(
    json['completed'] as bool,
    json['checkcount'] as String,
    json['id'] as int,
    json['country_name'] as String,
    json['continent_name'] as String,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$ContinentModelToJson(ContinentModel instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'checkcount': instance.checkcount,
      'id': instance.id,
      'country_name': instance.country_name,
      'continent_name': instance.continent_name,
      'error': instance.error,
    };
