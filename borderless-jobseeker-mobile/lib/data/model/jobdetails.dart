import 'package:json_annotation/json_annotation.dart';
part 'jobdetails.g.dart';

@JsonSerializable()
class Jobdetails {
  String job_post_date;
  String logo;
  String job_number;
  String title;
  String occupation_description;
  String job_description;
  int job_id;
  String country_name;
  String job_location;
  List other_keywords;
  String fav;
  String job_expired_date;
  String logo_url;
  String employment_types;
  String qualification;
  String allowance;
  String job_start_date;
  String message;

  String recruiter_number;
  String recruiter_name;
  String establishment_date;
  String representative_name;
  String business_description;
  String company_pr;
  String video;
  String num_of_employees;
  String incharge_photo_url;
  String updated;

  Jobdetails({
    this.job_post_date,
    this.logo,
    this.title,
    this.job_number,
    this.occupation_description,
    this.job_description,
    this.job_id,
    this.country_name,
    this.job_location,
    this.other_keywords,
    this.fav,
    this.job_expired_date,
    this.logo_url,
    this.employment_types,
    this.qualification,
    this.allowance,
    this.job_start_date,
    this.message,
    this.recruiter_number,
    this.recruiter_name,
    this.establishment_date,
    this.representative_name,
    this.business_description,
    this.company_pr,
    this.video,
    this.num_of_employees,
    this.incharge_photo_url,
    this.updated,
  });

  factory Jobdetails.fromJson(Map<String, dynamic> json) =>
      _$JobdetailsFromJson(json);

  Map<String, dynamic> toJson() => _$JobdetailsToJson(this);
}
