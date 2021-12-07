// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favouritejobs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritejobsModel _$FavouritejobsModelFromJson(Map<String, dynamic> json) {
  return FavouritejobsModel(
    json['job_post_date'] as String,
    json['logo'] as String,
    json['title'] as String,
    json['occupation_description'] as String,
    json['job_description'] as String,
    json['country_name'] as String,
    json['job_location'] as String,
    json['other_keywords'] as List,
    json['fav'] as String,
    json['job_expired_date'] as String,
    json['logo_url'] as String,
    json['error'] as String,
    job_id: json['job_id'] as int,
    jobseeker_id: json['jobseeker_id'] as int,
  );
}

Map<String, dynamic> _$FavouritejobsModelToJson(FavouritejobsModel instance) =>
    <String, dynamic>{
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
      'fav': instance.fav,
      'job_expired_date': instance.job_expired_date,
      'logo_url': instance.logo_url,
      'error': instance.error,
    };
