import 'package:json_annotation/json_annotation.dart';
part 'basicinfo.g.dart';
@JsonSerializable()
class Basicinfo{

  int only_country;
  int jobseeker_furigana_name_status;
  int gender_status;
  int dob_status;
  int current_address_status;
  String jobseeker_number;
  String last_annual_income;
  String last_currency;
  String other_certificate;
  int num_of_experienced_companies;
  int id;//countries.id
  int country_id;
  String final_education;
  String address;
  String jobseeker_name;
  String gender;
  String dob;
  String phone;
  String email;
  String skype_account;
  String current_situation;
  String jobseeker_furigana_name;
  String country_name;
  String city_name;
  String language_id;
  String language_name;
  String language_level;


  Basicinfo(
    this.only_country,
    this.jobseeker_furigana_name,
    this.gender_status,
    this.dob_status,
    this.current_address_status,
    this.jobseeker_number,
    this.last_annual_income,
    this.last_currency,
    this.other_certificate,
    this.num_of_experienced_companies,
    this.id,
    this.country_id,
    this.final_education,
    this.address,
    this.jobseeker_name,
    this.gender,
    this.dob,
    this.phone,
    this.email,
    this.skype_account,
    this.current_situation,
    this.country_name,
    this.city_name,
    this.language_id,
    this.language_name,
    this.language_level
    );
  factory Basicinfo.fromJson(Map<String, dynamic> json) => _$BasicinfoFromJson(json);

   Map<String, dynamic> toJson() => _$BasicinfoToJson(this);
   
}