import 'package:json_annotation/json_annotation.dart';
part 'upload_files.g.dart';
@JsonSerializable()
class Getupload{
  int id;
  String url;
  int record_status;

  Getupload(this.id,this.url,this.record_status);
  factory Getupload.fromJson(Map<String, dynamic> json) =>_$GetuploadFromJson(json);

   Map<String, dynamic> toJson() => _$GetuploadToJson(this);
   
}