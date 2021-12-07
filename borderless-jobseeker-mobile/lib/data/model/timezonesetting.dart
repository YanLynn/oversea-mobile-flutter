import 'package:json_annotation/json_annotation.dart';
part 'timezonesetting.g.dart';

@JsonSerializable()
class TimeZoneSettingModel {
  String timezone;
  String offset;

  TimeZoneSettingModel(this.timezone, this.offset);

  factory TimeZoneSettingModel.fromJson(Map<String, dynamic> json) =>
      _$TimeZoneSettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeZoneSettingModelToJson(this);
}