import 'package:json_annotation/json_annotation.dart';
part 'position.g.dart';

@JsonSerializable()
class Position {
  int id;
  String position_name;

  Position(this.id, this.position_name);
  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Position.jsonDecode(item);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
