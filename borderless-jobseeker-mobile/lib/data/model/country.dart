import 'package:json_annotation/json_annotation.dart';
part 'country.g.dart';

@JsonSerializable()
class CountryModel {
  bool completed;
  String checkcount;
  int id;
  String country_name;
  String continent_name;
  String error;

  CountryModel(this.completed, this.checkcount, this.id, this.country_name,
      this.continent_name);

  CountryModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
