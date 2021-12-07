// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfintro_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfIntroDetail _$SelfIntroDetailFromJson(Map<String, dynamic> json) {
  return SelfIntroDetail(
    json['selfIntro'],
    json['selfIntroDetails'] == null
        ? null
        : JobseekerModel.fromJson(
            json['selfIntroDetails'] as Map<String, dynamic>),
    (json['hashedFile'] as List)?.map((e) => e as String)?.toList(),
    (json['language'] as List)
        ?.map((e) => e == null
            ? null
            : LanguageLevel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..error = json['error'] as String;
}

Map<String, dynamic> _$SelfIntroDetailToJson(SelfIntroDetail instance) =>
    <String, dynamic>{
      'selfIntro': instance.selfIntro,
      'selfIntroDetails': instance.selfIntroDetails?.toJson(),
      'hashedFile': instance.hashedFile,
      'language': instance.language?.map((e) => e?.toJson())?.toList(),
      'error': instance.error,
    };
