import 'package:json_annotation/json_annotation.dart';
part 'employment_type.g.dart';

@JsonSerializable()
class EmploymentType {
  int id;
  String employment_type_name;

  EmploymentType(this.id, this.employment_type_name);
  factory EmploymentType.fromJson(Map<String, dynamic> json) =>
      _$EmploymentTypeFromJson(json);

  EmploymentType.jsonDecode(item);

  Map<String, dynamic> toJson() => _$EmploymentTypeToJson(this);
}
