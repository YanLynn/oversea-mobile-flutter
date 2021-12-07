import 'package:json_annotation/json_annotation.dart';
part 'searchfav.g.dart';

@JsonSerializable()
class Getsearchword {
  int search_status;
  String search_word;
  int jobseeker_id;
  String job_post_date;
  String logo;
  String title;
  String occupation_description;
  String job_description;
  int job_id;
  String country_name;
  String job_location;
  List<String> other_keywords;
  String job_expired_date;
  String logo_url;

  Getsearchword(this.search_status,
      {this.search_word,
      this.job_post_date,
      this.logo,
      this.title,
      this.occupation_description,
      this.job_description,
      this.country_name,
      this.job_location,
      this.other_keywords,
      this.job_expired_date,
      this.logo_url,
      this.job_id,
      this.jobseeker_id});
  factory Getsearchword.fromJson(Map<String, dynamic> json) =>
      _$GetsearchwordFromJson(json);

  // Getsearchword.jsonDecode(item);

  Map<String, dynamic> toJson() => _$GetsearchwordToJson(this);
}
