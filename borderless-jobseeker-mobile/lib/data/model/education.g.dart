// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) {
  return EducationModel(
    json['id'] as int,
    json['jobseeker_id'] as int,
    json['school_name'] as String,
    json['subject'] as String,
    json['degree'] as String,
    json['from_year'] as int,
    json['from_month'] as int,
    json['to_year'] as int,
    json['to_month'] as int,
    json['education_status'] as String,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobseeker_id': instance.jobseeker_id,
      'school_name': instance.school_name,
      'subject': instance.subject,
      'degree': instance.degree,
      'from_year': instance.from_year,
      'from_month': instance.from_month,
      'to_year': instance.to_year,
      'to_month': instance.to_month,
      'education_status': instance.education_status,
      'error': instance.error,
    };
