// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchfav.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getsearchword _$GetsearchwordFromJson(Map<String, dynamic> json) {
  return Getsearchword(
    json['search_status'] as int,
    search_word: json['search_word'] as String,
    job_post_date: json['job_post_date'] as String,
    logo: json['logo'] as String,
    title: json['title'] as String,
    occupation_description: json['occupation_description'] as String,
    job_description: json['job_description'] as String,
    country_name: json['country_name'] as String,
    job_location: json['job_location'] as String,
    other_keywords:
        (json['other_keywords'] as List)?.map((e) => e as String)?.toList(),
    job_expired_date: json['job_expired_date'] as String,
    logo_url: json['logo_url'] as String,
    job_id: json['job_id'] as int,
    jobseeker_id: json['jobseeker_id'] as int,
  );
}

Map<String, dynamic> _$GetsearchwordToJson(Getsearchword instance) =>
    <String, dynamic>{
      'search_status': instance.search_status,
      'search_word': instance.search_word,
      'jobseeker_id': instance.jobseeker_id,
      'job_post_date': instance.job_post_date,
      'logo': instance.logo,
      'title': instance.title,
      'occupation_description': instance.occupation_description,
      'job_description': instance.job_description,
      'job_id': instance.job_id,
      'country_name': instance.country_name,
      'job_location': instance.job_location,
      'other_keywords': instance.other_keywords,
      'job_expired_date': instance.job_expired_date,
      'logo_url': instance.logo_url,
    };
