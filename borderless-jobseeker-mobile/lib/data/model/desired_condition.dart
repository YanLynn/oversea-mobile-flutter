import 'package:json_annotation/json_annotation.dart';
part 'desired_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class DesiredCondition {
  Object desired_condition;
  List city_list;
  List industry_list;
  List occupation_list;
  List date_list;
  List industries;
  List occupations;
  String error;

  DesiredCondition(this.city_list, this.date_list, this.desired_condition, this.industries, this.industry_list, this.occupation_list, this.occupations);
  DesiredCondition.withError(String errorMessage) {
    error = errorMessage;
  }

  factory DesiredCondition.fromJson(Map<Object, dynamic> json) =>
      _$DesiredConditionFromJson(json);

  Map<Object, dynamic> toJson() => _$DesiredConditionToJson(this);
}