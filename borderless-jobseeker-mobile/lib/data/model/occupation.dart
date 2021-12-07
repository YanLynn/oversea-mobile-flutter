import 'package:json_annotation/json_annotation.dart';
part 'occupation.g.dart';

@JsonSerializable()
class OccupationModel {
  int id;
  bool completed;
  String occupation_name;
  String error;

  OccupationModel(this.id, this.completed, this.occupation_name);

  OccupationModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory OccupationModel.fromJson(Map<String, dynamic> json) =>
      _$OccupationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccupationModelToJson(this);
}
