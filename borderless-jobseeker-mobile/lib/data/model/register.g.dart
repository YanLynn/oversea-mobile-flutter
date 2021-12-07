// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(
    json['jobseeker_name'] as String,
    json['jobseeker_furigana_name'] as String,
    json['dob'] as String,
    json['phone'] as String,
    json['email'] as String,
    json['password'] as String,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'id': instance.id,
      'jobseeker_name': instance.jobseeker_name,
      'jobseeker_furigana_name': instance.jobseeker_furigana_name,
      'dob': instance.dob,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
    };
