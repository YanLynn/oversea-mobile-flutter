import 'package:json_annotation/json_annotation.dart';
part 'chatUserList.g.dart';

@JsonSerializable()
class ChatUserList {
  String allowance;
  String application_address;
  int country_id;
  String created_at;
  String email;
  String employment_types;
  int id;
  String incharge_name;
  String job_apply_status_replace;
  String job_description;
  String job_location;
  String job_number;
  DateTime job_post_date;
  String job_post_status;
  String job_start_date;
  DateTime job_update_date;
  int jobseeker_id;
  String last_chat_time;
  String management_number;
  String message;
  DateTime o_created_at;
  String occupation_description;
  int occupation_id;
  String other_keywords;
  String qualification;
  int record_status;
  int recruiter_id;
  String recruiter_name;
  String recruiter_show_name;
  String recruitment_position;
  int scoutid_or_applyid;
  String status;
  String title;
  String type;
  int unread;
  DateTime updated_at;
  int user_id;

  ChatUserList(
      this.allowance,
      this.application_address,
      this.country_id,
      this.created_at,
      this.email,
      this.employment_types,
      this.id,
      this.incharge_name,
      this.job_apply_status_replace,
      this.job_description,
      this.job_location,
      this.job_number,
      this.job_post_date,
      this.job_post_status,
      this.job_start_date,
      this.job_update_date,
      this.jobseeker_id,
      this.last_chat_time,
      this.management_number,
      this.message,
      this.o_created_at,
      this.occupation_description,
      this.occupation_id,
      this.other_keywords,
      this.qualification,
      this.record_status,
      this.recruiter_id,
      this.recruiter_name,
      this.recruiter_show_name,
      this.recruitment_position,
      this.scoutid_or_applyid,
      this.status,
      this.title,
      this.type,
      this.unread,
      this.updated_at,
      this.user_id);

  factory ChatUserList.fromJson(Map<String, dynamic> json) =>
      _$ChatUserListFromJson(json);
}
