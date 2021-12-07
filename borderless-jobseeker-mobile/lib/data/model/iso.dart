import 'package:json_annotation/json_annotation.dart';
part 'iso.g.dart';

@JsonSerializable()
class Iso {
  Iso();
  factory Iso.fromJson(Map<String, dynamic> json) => _$IsoFromJson(json);

  Iso.jsonDecode(item);

  Map<String, dynamic> toJson() => _$IsoToJson(this);
}
