// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scout _$ScoutFromJson(Map<String, dynamic> json) {
  return Scout(
    json['id'] as int,
    json['recruiter_id'] as int,
    json['jobseeker_id'] as int,
    json['job_id'] as int,
    json['record_status'] as int,
    json['management_number'] as String,
    json['scout_status'] as String,
    json['occupation_description'] as String,
    json['employment_types'] as String,
    json['job_location'] as String,
    json['incharge_photo'] as String,
    json['incharge_photo_url'] as String,
    json['logo'] as String,
    json['read_job'] as int,
    json['recruiter_name'] as String,
    json['recruiter_nick_name'] as String,
    json['recruiter_show_name'] as String,
    json['send_noti'] as int,
    json['title'] as String,
    json['scouted_date'] as String,
    json['user_scouted_date'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
  );
}

Map<String, dynamic> _$ScoutToJson(Scout instance) => <String, dynamic>{
      'id': instance.id,
      'recruiter_id': instance.recruiter_id,
      'jobseeker_id': instance.jobseeker_id,
      'job_id': instance.job_id,
      'record_status': instance.record_status,
      'read_job': instance.read_job,
      'send_noti': instance.send_noti,
      'management_number': instance.management_number,
      'scout_status': instance.scout_status,
      'occupation_description': instance.occupation_description,
      'employment_types': instance.employment_types,
      'job_location': instance.job_location,
      'incharge_photo': instance.incharge_photo,
      'incharge_photo_url': instance.incharge_photo_url,
      'logo': instance.logo,
      'recruiter_name': instance.recruiter_name,
      'recruiter_nick_name': instance.recruiter_nick_name,
      'recruiter_show_name': instance.recruiter_show_name,
      'title': instance.title,
      'scouted_date': instance.scouted_date,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'user_scouted_date': instance.user_scouted_date,
    };
