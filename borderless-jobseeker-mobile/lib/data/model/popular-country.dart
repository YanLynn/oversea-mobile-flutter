import 'package:json_annotation/json_annotation.dart';
part 'popular-country.g.dart';

@JsonSerializable()
class PopularCountryModel {
  int field_id;
  bool completed;
  String country_name;
  String continent_name;
  String error;

  PopularCountryModel(
      this.field_id, this.completed, this.country_name, this.continent_name);

  PopularCountryModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory PopularCountryModel.fromJson(Map<String, dynamic> json) =>
      _$PopularCountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PopularCountryModelToJson(this);
}
