// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobappliedpage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobappliedpage _$JobappliedpageFromJson(Map<String, dynamic> json) {
  return Jobappliedpage(
    job_apply_id: json['job_apply_id'] as int,
    job_apply_status: json['job_apply_status'] as String,
    job_id: json['job_id'] as int,
    job_description: json['job_description'] as String,
    title: json['title'] as String,
    job_location: json['job_location'] as String,
    country_name: json['country_name'] as String,
    other_keywords: json['other_keywords'] as List,
    occupation_description: json['occupation_description'] as String,
    recruiter_id: json['recruiter_id'] as int,
    jobseeker_id: json['jobseeker_id'] as int,
    job_post_date: json['job_post_date'] as String,
    logo_url: json['logo_url'] as String,
  )..logo = json['logo'] as String;
}

Map<String, dynamic> _$JobappliedpageToJson(Jobappliedpage instance) =>
    <String, dynamic>{
      'logo': instance.logo,
      'job_apply_id': instance.job_apply_id,
      'job_apply_status': instance.job_apply_status,
      'job_id': instance.job_id,
      'job_description': instance.job_description,
      'title': instance.title,
      'job_location': instance.job_location,
      'country_name': instance.country_name,
      'other_keywords': instance.other_keywords,
      'occupation_description': instance.occupation_description,
      'recruiter_id': instance.recruiter_id,
      'jobseeker_id': instance.jobseeker_id,
      'job_post_date': instance.job_post_date,
      'logo_url': instance.logo_url,
    };
