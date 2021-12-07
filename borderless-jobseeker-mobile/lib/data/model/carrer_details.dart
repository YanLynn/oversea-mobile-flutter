import 'package:borderlessWorking/data/model/employment_type.dart';
import 'package:borderlessWorking/data/model/jobseeker.dart';
import 'package:borderlessWorking/data/model/position.dart';
import 'package:json_annotation/json_annotation.dart';
part 'carrer_details.g.dart';

@JsonSerializable(explicitToJson: true)
class CarrerDetail {
  Object carrers;
  List educations;
  List experiences;

  String error;

  CarrerDetail(this.carrers, this.educations, this.experiences);

  CarrerDetail.withError(String errorMessage) {
    error = errorMessage;
  }

  factory CarrerDetail.fromJson(Map<Object, dynamic> json) =>
      _$CarrerDetailFromJson(json);

  Map<Object, dynamic> toJson() => _$CarrerDetailToJson(this);
}
