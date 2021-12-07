import 'package:json_annotation/json_annotation.dart';
part 'jobseeker.g.dart';

@JsonSerializable()
class JobseekerModel {
  int user_id;
  List<String> language_level;
  List<String> occupation_name;
  String jobseeker_number;
  String desired_occupation;
  String face_image_blur;
  BigInt country_id;
  int only_country;
  String jobseeker_name;
  String jobseeker_furigana_name;
  String jobseeker_nick_name;
  String face_image;
  int face_image_private_status;
  String dob;
  String address;
  String phone;
  String email;
  String gender;
  String skype_account;
  String video;
  String final_education;
  String current_situation;
  double num_of_experienced_companies;
  String last_currency;
  String last_annual_income;
  String self_pr;
  String job_change_reason;
  String job_search_activity;
  String main_fact_when_change;
  String desired_change_period;
  String desired_location_1;
  String desired_location_2;
  String desired_location_3;
  int desired_industry_status;
  int desired_industry_id;
  int desired_occupation_status;
  int desired_occupation_id;
  int desired_salary_status;
  String desired_currency;
  String desired_min_annual_income;
  String desired_max_annual_income;
  int scout_setting_status;
  int visa_status;
  String visa_country;
  String toeic_score;
  String other_language_certificate;
  String other_certificate;
  String favourite_job_ids;
  String recently_job_ids;
  int record_status;
  DateTime created_at;
  DateTime updated_at;
  int jobseeker_furigana_name_status;
  int gender_status;
  int dob_status;
  int current_address_status;
  String error;

  JobseekerModel(
      this.user_id,
      this.language_level,
      this.occupation_name,
      this.jobseeker_number,
      this.desired_occupation,
      this.face_image_blur,
      this.country_id,
      this.only_country,
      this.jobseeker_name,
      this.jobseeker_furigana_name,
      this.jobseeker_nick_name,
      this.face_image,
      this.face_image_private_status,
      this.dob,
      this.address,
      this.phone,
      this.email,
      this.gender,
      this.skype_account,
      this.video,
      this.final_education,
      this.current_situation,
      this.num_of_experienced_companies,
      this.last_currency,
      this.last_annual_income,
      this.self_pr,
      this.job_change_reason,
      this.job_search_activity,
      this.main_fact_when_change,
      this.desired_change_period,
      this.desired_location_1,
      this.desired_location_2,
      this.desired_location_3,
      this.desired_industry_status,
      this.desired_industry_id,
      this.desired_occupation_status,
      this.desired_occupation_id,
      this.desired_salary_status,
      this.desired_currency,
      this.desired_min_annual_income,
      this.desired_max_annual_income,
      this.scout_setting_status,
      this.visa_status,
      this.visa_country,
      this.toeic_score,
      this.other_language_certificate,
      this.other_certificate,
      this.favourite_job_ids,
      this.recently_job_ids,
      this.record_status,
      this.created_at,
      this.updated_at,
      this.jobseeker_furigana_name_status,
      this.gender_status,
      this.dob_status,
      this.current_address_status);

  JobseekerModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory JobseekerModel.fromJson(Map<String, dynamic> json) =>
      _$JobseekerModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobseekerModelToJson(this);
}
