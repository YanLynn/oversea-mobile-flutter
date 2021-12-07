// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exp_qualification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpQualification _$ExpQualificationFromJson(Map<String, dynamic> json) {
  return ExpQualification(
    json['countries'] as List,
    json['education_overseas'] as List,
    json['industry_histories'] as List,
    json['industries'] as List,
    json['jobseeker_detail'],
    json['languages_levels'] as List,
    json['languages'] as List,
    json['occupations'] as List,
    json['positions'] as List,
    json['working_overseas'] as List,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$ExpQualificationToJson(ExpQualification instance) =>
    <String, dynamic>{
      'jobseeker_detail': instance.jobseeker_detail,
      'countries': instance.countries,
      'industries': instance.industries,
      'education_overseas': instance.education_overseas,
      'industry_histories': instance.industry_histories,
      'languages_levels': instance.languages_levels,
      'languages': instance.languages,
      'occupations': instance.occupations,
      'positions': instance.positions,
      'working_overseas': instance.working_overseas,
      'error': instance.error,
    };
