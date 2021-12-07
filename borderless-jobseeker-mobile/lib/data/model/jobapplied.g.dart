// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobapplied.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobapply _$JobapplyFromJson(Map<String, dynamic> json) {
  return Jobapply(
    json['id'] as int,
    json['job_apply_status'] as String,
  );
}

Map<String, dynamic> _$JobapplyToJson(Jobapply instance) => <String, dynamic>{
      'id': instance.id,
      'job_apply_status': instance.job_apply_status,
    };
