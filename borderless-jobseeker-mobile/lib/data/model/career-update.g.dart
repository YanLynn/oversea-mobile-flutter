// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'career-update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CareerModel _$CareerModelFromJson(Map<String, dynamic> json) {
  return CareerModel(
    (json['positions'] as List)
        ?.map((e) =>
            e == null ? null : Position.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['employment_types'] as List)
        ?.map((e) => e == null
            ? null
            : EmploymentType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['iso_list'] as List,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$CareerModelToJson(CareerModel instance) =>
    <String, dynamic>{
      'positions': instance.positions?.map((e) => e?.toJson())?.toList(),
      'employment_types':
          instance.employment_types?.map((e) => e?.toJson())?.toList(),
      'iso_list': instance.iso_list,
      'error': instance.error,
    };
