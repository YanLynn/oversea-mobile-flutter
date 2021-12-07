import 'package:json_annotation/json_annotation.dart';
part 'getcountry.g.dart';
@JsonSerializable()
class Getcountry{
  int id;
  String city_name;
  String country_name;
  String continent_name;

  Getcountry(this.id,this.city_name,this.country_name,this.continent_name);
  factory Getcountry.fromJson(Map<String, dynamic> json) => _$GetcountryFromJson(json);

   Map<String, dynamic> toJson() => _$GetcountryToJson(this);
   
}