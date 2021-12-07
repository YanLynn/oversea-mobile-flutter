import 'package:json_annotation/json_annotation.dart';
part 'register.g.dart';
@JsonSerializable()
class Register{
  int id;
  String jobseeker_name;
  String jobseeker_furigana_name;
  String dob;
  String phone;
  String email;
  String password;

  Register(this.jobseeker_name,this.jobseeker_furigana_name,this.dob,this.phone,this.email,this.password);
  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);

   Map<String, dynamic> toJson() => _$RegisterToJson(this);
   
}