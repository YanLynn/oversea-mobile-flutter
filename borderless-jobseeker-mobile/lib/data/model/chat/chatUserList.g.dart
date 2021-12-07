// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatUserList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserList _$ChatUserListFromJson(Map<String, dynamic> json) {
  return ChatUserList(
    json['allowance'] as String,
    json['application_address'] as String,
    json['country_id'] as int,
    json['created_at'] as String,
    json['email'] as String,
    json['employment_types'] as String,
    json['id'] as int,
    json['incharge_name'] as String,
    json['job_apply_status_replace'] as String,
    json['job_description'] as String,
    json['job_location'] as String,
    json['job_number'] as String,
    json['job_post_date'] == null
        ? null
        : DateTime.parse(json['job_post_date'] as String),
    json['job_post_status'] as String,
    json['job_start_date'] as String,
    json['job_update_date'] == null
        ? null
        : DateTime.parse(json['job_update_date'] as String),
    json['jobseeker_id'] as int,
    json['last_chat_time'] as String,
    json['management_number'] as String,
    json['message'] as String,
    json['o_created_at'] == null
        ? null
        : DateTime.parse(json['o_created_at'] as String),
    json['occupation_description'] as String,
    json['occupation_id'] as int,
    json['other_keywords'] as String,
    json['qualification'] as String,
    json['record_status'] as int,
    json['recruiter_id'] as int,
    json['recruiter_name'] as String,
    json['recruiter_show_name'] as String,
    json['recruitment_position'] as String,
    json['scoutid_or_applyid'] as int,
    json['status'] as String,
    json['title'] as String,
    json['type'] as String,
    json['unread'] as int,
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['user_id'] as int,
  );
}

Map<String, dynamic> _$ChatUserListToJson(ChatUserList instance) =>
    <String, dynamic>{
      'allowance': instance.allowance,
      'application_address': instance.application_address,
      'country_id': instance.country_id,
      'created_at': instance.created_at,
      'email': instance.email,
      'employment_types': instance.employment_types,
      'id': instance.id,
      'incharge_name': instance.incharge_name,
      'job_apply_status_replace': instance.job_apply_status_replace,
      'job_description': instance.job_description,
      'job_location': instance.job_location,
      'job_number': instance.job_number,
      'job_post_date': instance.job_post_date?.toIso8601String(),
      'job_post_status': instance.job_post_status,
      'job_start_date': instance.job_start_date,
      'job_update_date': instance.job_update_date?.toIso8601String(),
      'jobseeker_id': instance.jobseeker_id,
      'last_chat_time': instance.last_chat_time,
      'management_number': instance.management_number,
      'message': instance.message,
      'o_created_at': instance.o_created_at?.toIso8601String(),
      'occupation_description': instance.occupation_description,
      'occupation_id': instance.occupation_id,
      'other_keywords': instance.other_keywords,
      'qualification': instance.qualification,
      'record_status': instance.record_status,
      'recruiter_id': instance.recruiter_id,
      'recruiter_name': instance.recruiter_name,
      'recruiter_show_name': instance.recruiter_show_name,
      'recruitment_position': instance.recruitment_position,
      'scoutid_or_applyid': instance.scoutid_or_applyid,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'unread': instance.unread,
      'updated_at': instance.updated_at?.toIso8601String(),
      'user_id': instance.user_id,
    };
