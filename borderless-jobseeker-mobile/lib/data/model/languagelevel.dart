import 'package:json_annotation/json_annotation.dart';
part 'languagelevel.g.dart';

@JsonSerializable()
class LanguageLevel {
  int id;
  String language_id;
  String language_level;

  LanguageLevel({
    this.id,
    this.language_id,
    this.language_level,
  });

  factory LanguageLevel.fromJson(Map<String, dynamic> json) =>
      _$LanguageLevelFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageLevelToJson(this);
}
