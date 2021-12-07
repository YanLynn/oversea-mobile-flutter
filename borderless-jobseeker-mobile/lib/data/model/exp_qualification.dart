import 'package:json_annotation/json_annotation.dart';
part 'exp_qualification.g.dart';

@JsonSerializable(explicitToJson: true)
class ExpQualification {
  Object jobseeker_detail;
  List countries;
  List industries;
  List education_overseas;
  List industry_histories;
  List languages_levels;
  List languages;
  List occupations;
  List positions;
  List working_overseas;
  String error;

  ExpQualification(this.countries, this.education_overseas, this.industry_histories, this.industries, this.jobseeker_detail, this.languages_levels, this.languages, this.occupations, this.positions, this.working_overseas);
  
  ExpQualification.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ExpQualification.fromJson(Map<Object, dynamic> json) =>
      _$ExpQualificationFromJson(json);

  Map<Object, dynamic> toJson() => _$ExpQualificationToJson(this);
}