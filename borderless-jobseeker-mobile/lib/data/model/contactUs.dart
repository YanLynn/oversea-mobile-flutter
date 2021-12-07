import 'package:json_annotation/json_annotation.dart';
part 'contactUs.g.dart';

@JsonSerializable()
class ContactUsModel {
  String error;
  int id;
  String corporateName;
  String name;
  String furiganaName;
  String emai;
  String confirmEmail;
  String inquiryDetails;
  bool policy;

  ContactUsModel(this.corporateName, this.name, this.furiganaName, this.emai,
      this.confirmEmail, this.inquiryDetails, this.policy,
      {this.id});
  ContactUsModel.withError(String errorMessage) {
    error = errorMessage;
  }
  factory ContactUsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUsModelToJson(this);
}
