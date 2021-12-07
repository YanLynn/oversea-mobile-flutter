import 'package:json_annotation/json_annotation.dart';
part 'language.g.dart';

@JsonSerializable()
class Language {
  int id;
  String language_name;

  Language({
    this.id,
    this.language_name,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
