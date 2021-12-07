// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmploymentType _$EmploymentTypeFromJson(Map<String, dynamic> json) {
  return EmploymentType(
    json['id'] as int,
    json['employment_type_name'] as String,
  );
}

Map<String, dynamic> _$EmploymentTypeToJson(EmploymentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employment_type_name': instance.employment_type_name,
    };
