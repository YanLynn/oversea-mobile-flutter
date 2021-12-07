// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languagelevel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageLevel _$LanguageLevelFromJson(Map<String, dynamic> json) {
  return LanguageLevel(
    id: json['id'] as int,
    language_id: json['language_id'] as String,
    language_level: json['language_level'] as String,
  );
}

Map<String, dynamic> _$LanguageLevelToJson(LanguageLevel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language_id': instance.language_id,
      'language_level': instance.language_level,
    };
