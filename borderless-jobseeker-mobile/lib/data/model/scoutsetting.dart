
import 'package:json_annotation/json_annotation.dart';
part 'scoutsetting.g.dart';

@JsonSerializable()
class ScoutSetting {
  int scout_setting_status;
  ScoutSetting(this.scout_setting_status);

  Map<String, dynamic> toJson() => _$ScoutSettingToJson(this);
}
