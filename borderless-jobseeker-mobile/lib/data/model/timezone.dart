import 'package:json_annotation/json_annotation.dart';
part 'timezone.g.dart';

@JsonSerializable()
class TimeZoneModel {
  String Country_Code;
  String Country_Name;
  String Time_Zone;
  String GMT_Offset;

  TimeZoneModel(this.Country_Code, this.Country_Name, this.Time_Zone, this.GMT_Offset);

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) =>
      _$TimeZoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeZoneModelToJson(this);
}