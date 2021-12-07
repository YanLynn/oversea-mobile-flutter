// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccupationModel _$OccupationModelFromJson(Map<String, dynamic> json) {
  return OccupationModel(
    json['id'] as int,
    json['completed'] as bool,
    json['occupation_name'] as String,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$OccupationModelToJson(OccupationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'completed': instance.completed,
      'occupation_name': instance.occupation_name,
      'error': instance.error,
    };
