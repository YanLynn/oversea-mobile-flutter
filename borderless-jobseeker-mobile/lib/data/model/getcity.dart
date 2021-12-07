import 'package:json_annotation/json_annotation.dart';
part 'getcity.g.dart';
@JsonSerializable()
class Getcity{
  int id;
  String city_name;
  String country_name;
  String continent_name;

  Getcity(this.id,this.city_name,this.country_name,this.continent_name);
  factory Getcity.fromJson(Map<String, dynamic> json) => _$GetcityFromJson(json);

  Getcity.jsonDecode(item);

   Map<String, dynamic> toJson() => _$GetcityToJson(this);
   
}