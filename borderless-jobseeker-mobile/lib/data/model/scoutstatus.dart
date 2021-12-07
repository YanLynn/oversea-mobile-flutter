import 'package:json_annotation/json_annotation.dart';
part 'scoutstatus.g.dart';
@JsonSerializable()
class Scoutstatus{
  int id;
  String scout_status;

  Scoutstatus(this.id,this.scout_status);
  factory Scoutstatus.fromJson(Map<String, dynamic> json) => _$ScoutstatusFromJson(json);

   Map<String, dynamic> toJson() => _$ScoutstatusToJson(this);
   
}