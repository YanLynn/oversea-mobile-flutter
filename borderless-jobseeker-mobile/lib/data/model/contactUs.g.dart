// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contactUs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsModel _$ContactUsModelFromJson(Map<String, dynamic> json) {
  return ContactUsModel(
    json['corporateName'] as String,
    json['name'] as String,
    json['furiganaName'] as String,
    json['emai'] as String,
    json['confirmEmail'] as String,
    json['inquiryDetails'] as String,
    json['policy'] as bool,
    id: json['id'] as int,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$ContactUsModelToJson(ContactUsModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'id': instance.id,
      'corporateName': instance.corporateName,
      'name': instance.name,
      'furiganaName': instance.furiganaName,
      'emai': instance.emai,
      'confirmEmail': instance.confirmEmail,
      'inquiryDetails': instance.inquiryDetails,
      'policy': instance.policy,
    };
