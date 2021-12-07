import 'package:borderlessWorking/data/model/employment_type.dart';
import 'package:borderlessWorking/data/model/jobseeker.dart';
import 'package:borderlessWorking/data/model/position.dart';
import 'package:json_annotation/json_annotation.dart';
part 'career-update.g.dart';

@JsonSerializable(explicitToJson: true)
class CareerModel {
  List<Position> positions;
  List<EmploymentType> employment_types;
  List iso_list;

  String error;

  CareerModel(this.positions, this.employment_types, this.iso_list);

  CareerModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory CareerModel.fromJson(Map<String, dynamic> json) =>
      _$CareerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CareerModelToJson(this);
}
