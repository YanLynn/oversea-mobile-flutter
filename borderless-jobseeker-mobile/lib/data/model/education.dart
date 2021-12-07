import 'package:json_annotation/json_annotation.dart';
part 'education.g.dart';

@JsonSerializable()
class EducationModel {
  int id;
  int jobseeker_id;
  String school_name;
  String subject;
  String degree;
  int from_year;
  int from_month;
  int to_year;
  int to_month;
  String education_status;

  String error;

  EducationModel(
      this.id,
      this.jobseeker_id,
      this.school_name,
      this.subject,
      this.degree,
      this.from_year,
      this.from_month,
      this.to_year,
      this.to_month,
      this.education_status);

  EducationModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);
}
