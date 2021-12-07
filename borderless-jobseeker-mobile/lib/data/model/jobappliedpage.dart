import 'package:json_annotation/json_annotation.dart';
part 'jobappliedpage.g.dart';
@JsonSerializable()
class Jobappliedpage{
String logo;
int job_apply_id;
String job_apply_status;
int job_id;
String job_description;
String title;
String job_location;
String country_name;
List other_keywords;
String occupation_description;
int recruiter_id;
int jobseeker_id;
String job_post_date;
String logo_url;
  Jobappliedpage(
      {
        this.job_apply_id,
        this.job_apply_status,
        this.job_id,
        this.job_description,
        this.title,
        this.job_location,
        this.country_name,
        this.other_keywords,
        this.occupation_description,
        this.recruiter_id,
        this.jobseeker_id,
        this.job_post_date,
        this.logo_url,
      });
  factory Jobappliedpage.fromJson(Map<String, dynamic> json) =>_$JobappliedpageFromJson(json);
   Map<String, dynamic> toJson() => _$JobappliedpageToJson(this);
}