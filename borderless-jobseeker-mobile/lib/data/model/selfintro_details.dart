import 'package:borderlessWorking/data/model/employment_type.dart';
import 'package:borderlessWorking/data/model/jobseeker.dart';
import 'package:borderlessWorking/data/model/language.dart';
import 'package:borderlessWorking/data/model/languagelevel.dart';
import 'package:borderlessWorking/data/model/position.dart';
import 'package:json_annotation/json_annotation.dart';
part 'selfintro_details.g.dart';

@JsonSerializable(explicitToJson: true)
class SelfIntroDetail {
  Object selfIntro;
  JobseekerModel selfIntroDetails;
  List<String> hashedFile;
  List<LanguageLevel> language;

  String error;

  SelfIntroDetail(
      this.selfIntro, this.selfIntroDetails, this.hashedFile, this.language);

  SelfIntroDetail.withError(String errorMessage) {
    error = errorMessage;
  }

  factory SelfIntroDetail.fromJson(Map<Object, dynamic> json) =>
      _$SelfIntroDetailFromJson(json);

  Map<Object, dynamic> toJson() => _$SelfIntroDetailToJson(this);
}
