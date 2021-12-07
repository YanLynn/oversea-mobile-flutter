import 'package:json_annotation/json_annotation.dart';
part 'continent.g.dart';

@JsonSerializable()
class ContinentModel {
  bool completed;
  String checkcount;
  int id;
  String country_name;
  String continent_name;
  String error;

  ContinentModel(this.completed, this.checkcount, this.id, this.country_name,
      this.continent_name);

  ContinentModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory ContinentModel.fromJson(Map<String, dynamic> json) =>
      _$ContinentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContinentModelToJson(this);
}
