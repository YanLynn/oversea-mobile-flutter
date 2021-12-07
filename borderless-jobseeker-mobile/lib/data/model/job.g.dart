// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    job_post_date: json['job_post_date'] as String,
    logo: json['logo'] as String,
    title: json['title'] as String,
    occupation_description: json['occupation_description'] as String,
    job_description: json['job_description'] as String,
    job_id: json['job_id'] as int,
    country_name: json['country_name'] as String,
    job_location: json['job_location'] as String,
    other_keywords: json['other_keywords'] as List,
    fav: json['fav'] as String,
    job_expired_date: json['job_expired_date'] as String,
    logo_url: json['logo_url'] as String,
  );
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'job_post_date': instance.job_post_date,
      'logo': instance.logo,
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
    };
