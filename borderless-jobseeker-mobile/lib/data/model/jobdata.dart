import 'package:borderlessWorking/data/model/jobdetails.dart';
import 'package:borderlessWorking/data/model/upload_files.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class JobDataModel {
  Jobdetails detail;
  List<Getupload> related_files;
  //String error;

  JobDataModel({this.detail, this.related_files});

  // JobDataModel.withError(String errorMessage) {
  //   error = errorMessage;
  // }

  JobDataModel.fromJson(Map<String, dynamic> json) {
    detail = json['details'] != null
        ? new Jobdetails.fromJson(json['details'])
        : null;
    related_files = (json["related_files"] as List)
        .map((i) => new Getupload.fromJson(i))
        .toList();
  }
}
