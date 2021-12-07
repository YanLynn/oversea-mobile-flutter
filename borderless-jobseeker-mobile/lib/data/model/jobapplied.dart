import 'package:json_annotation/json_annotation.dart';
part 'jobapplied.g.dart';
@JsonSerializable()
class Jobapply{
  int id;
  String job_apply_status;

  Jobapply(this.id,this.job_apply_status);
  factory Jobapply.fromJson(Map<String, dynamic> json) => _$JobapplyFromJson(json);

   Map<String, dynamic> toJson() => _$JobapplyToJson(this);
   
}