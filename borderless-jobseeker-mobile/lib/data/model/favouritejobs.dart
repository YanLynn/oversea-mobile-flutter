import 'package:json_annotation/json_annotation.dart';
part 'favouritejobs.g.dart';

@JsonSerializable()
class FavouritejobsModel {
  int jobseeker_id;
  String job_post_date;
  String logo;
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
  String error;

  FavouritejobsModel(
      this.job_post_date,
      this.logo,
      this.title,
      this.occupation_description,
      this.job_description,
      this.country_name,
      this.job_location,
      this.other_keywords,
      this.fav,
      this.job_expired_date,
      this.logo_url,
      this.error,
      {this.job_id,
      this.jobseeker_id});

  factory FavouritejobsModel.fromJson(Map<String, dynamic> json) =>
      _$FavouritejobsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavouritejobsModelToJson(this);
}
