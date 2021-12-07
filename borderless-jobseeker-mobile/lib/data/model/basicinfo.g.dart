// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basicinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Basicinfo _$BasicinfoFromJson(Map<String, dynamic> json) {
  return Basicinfo(
    json['only_country'] as int,
    json['jobseeker_furigana_name'] as String,
    json['gender_status'] as int,
    json['dob_status'] as int,
    json['current_address_status'] as int,
    json['jobseeker_number'] as String,
    json['last_annual_income'] as String,
    json['last_currency'] as String,
    json['other_certificate'] as String,
    json['num_of_experienced_companies'] as int,
    json['id'] as int,
    json['country_id'] as int,
    json['final_education'] as String,
    json['address'] as String,
    json['jobseeker_name'] as String,
    json['gender'] as String,
    json['dob'] as String,
    json['phone'] as String,
    json['email'] as String,
    json['skype_account'] as String,
    json['current_situation'] as String,
    json['country_name'] as String,
    json['city_name'] as String,
    json['language_id'] as String,
    json['language_name'] as String,
    json['language_level'] as String,
  )..jobseeker_furigana_name_status =
      json['jobseeker_furigana_name_status'] as int;
}

Map<String, dynamic> _$BasicinfoToJson(Basicinfo instance) => <String, dynamic>{
      'only_country': instance.only_country,
      'jobseeker_furigana_name_status': instance.jobseeker_furigana_name_status,
      'gender_status': instance.gender_status,
      'dob_status': instance.dob_status,
      'current_address_status': instance.current_address_status,
      'jobseeker_number': instance.jobseeker_number,
      'last_annual_income': instance.last_annual_income,
      'last_currency': instance.last_currency,
      'other_certificate': instance.other_certificate,
      'num_of_experienced_companies': instance.num_of_experienced_companies,
      'id': instance.id,
      'country_id': instance.country_id,
      'final_education': instance.final_education,
      'address': instance.address,
      'jobseeker_name': instance.jobseeker_name,
      'gender': instance.gender,
      'dob': instance.dob,
      'phone': instance.phone,
      'email': instance.email,
      'skype_account': instance.skype_account,
      'current_situation': instance.current_situation,
      'jobseeker_furigana_name': instance.jobseeker_furigana_name,
      'country_name': instance.country_name,
      'city_name': instance.city_name,
      'language_id': instance.language_id,
      'language_name': instance.language_name,
      'language_level': instance.language_level,
    };
