import 'package:json_annotation/json_annotation.dart';
part 'basicinfo_lang.g.dart';
@JsonSerializable()
class Infolang{
  int id;
  String language_name;

  Infolang(this.id,this.language_name);
  factory Infolang.fromJson(Map<String, dynamic> json) => _$InfolangFromJson(json);

   Map<String, dynamic> toJson() =>_$InfolangToJson(this);
   
}