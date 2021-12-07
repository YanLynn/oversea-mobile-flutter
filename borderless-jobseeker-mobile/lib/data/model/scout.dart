import 'package:json_annotation/json_annotation.dart';
part 'scout.g.dart';

@JsonSerializable()
class Scout {
  int id,
      recruiter_id,
      jobseeker_id,
      job_id,
      record_status,
      read_job,
      send_noti;
  String management_number,
      scout_status,
      occupation_description,
      employment_types,
      job_location,
      incharge_photo,
      incharge_photo_url,
      logo,
      recruiter_name,
      recruiter_nick_name,
      recruiter_show_name,
      title;
  // String scouted_date, created_at, updated_at, user_scouted_date;
  String scouted_date, created_at, updated_at, user_scouted_date;

  Scout(
      this.id,
      this.recruiter_id,
      this.jobseeker_id,
      this.job_id,
      this.record_status,
      this.management_number,
      this.scout_status,
      this.occupation_description,
      this.employment_types,
      this.job_location,
      this.incharge_photo,
      this.incharge_photo_url,
      this.logo,
      this.read_job,
      this.recruiter_name,
      this.recruiter_nick_name,
      this.recruiter_show_name,
      this.send_noti,
      this.title,
      this.scouted_date,
      this.user_scouted_date,
      this.created_at,
      this.updated_at);

  factory Scout.fromJson(Map<String, dynamic> json) => _$ScoutFromJson(json);

  Map<String, dynamic> toJson() => _$ScoutToJson(this);
}
