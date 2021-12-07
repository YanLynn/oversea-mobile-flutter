// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobdetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Jobdetails _$JobdetailsFromJson(Map<String, dynamic> json) {
  return Jobdetails(
    job_post_date: json['job_post_date'] as String,
    logo: json['logo'] as String,
    title: json['title'] as String,
    job_number: json['job_number'] as String,
    occupation_description: json['occupation_description'] as String,
    job_description: json['job_description'] as String,
    job_id: json['job_id'] as int,
    country_name: json['country_name'] as String,
    job_location: json['job_location'] as String,
    other_keywords: json['other_keywords'] as List,
    fav: json['fav'] as String,
    job_expired_date: json['job_expired_date'] as String,
    logo_url: json['logo_url'] as String,
    employment_types: json['employment_types'] as String,
    qualification: json['qualification'] as String,
    allowance: json['allowance'] as String,
    job_start_date: json['job_start_date'] as String,
    message: json['message'] as String,
    recruiter_number: json['recruiter_number'] as String,
    recruiter_name: json['recruiter_name'] as String,
    establishment_date: json['establishment_date'] as String,
    representative_name: json['representative_name'] as String,
    business_description: json['business_description'] as String,
    company_pr: json['company_pr'] as String,
    video: json['video'] as String,
    num_of_employees: json['num_of_employees'] as String,
    incharge_photo_url: json['incharge_photo_url'] as String,
    updated: json['updated'] as String,
  );
}

Map<String, dynamic> _$JobdetailsToJson(Jobdetails instance) =>
    <String, dynamic>{
      'job_post_date': instance.job_post_date,
      'logo': instance.logo,
      'job_number': instance.job_number,
      'title': instance.title,
      'occupation_description': instance.occupation_description,
      'job_description': instance.job_description,
      'job_id': instance.job_id,
      'country_name': instance.country_name,
      'job_location': instance.job_location,
      'other_keywords': instance.other_keywords,
      'fav': instance.fav,
      'job_expired_date': instance.job_expired_date,
      'logo_url': instance.logo_url,
      'employment_types': instance.employment_types,
      'qualification': instance.qualification,
      'allowance': instance.allowance,
      'job_start_date': instance.job_start_date,
      'message': instance.message,
      'recruiter_number': instance.recruiter_number,
      'recruiter_name': instance.recruiter_name,
      'establishment_date': instance.establishment_date,
      'representative_name': instance.representative_name,
      'business_description': instance.business_description,
      'company_pr': instance.company_pr,
      'video': instance.video,
      'num_of_employees': instance.num_of_employees,
      'incharge_photo_url': instance.incharge_photo_url,
      'updated': instance.updated,
    };
