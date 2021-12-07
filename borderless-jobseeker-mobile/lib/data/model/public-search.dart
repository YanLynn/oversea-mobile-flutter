import 'package:borderlessWorking/data/model/continent.dart';
import 'package:borderlessWorking/data/model/country.dart';
import 'package:borderlessWorking/data/model/occupation.dart';
import 'package:borderlessWorking/data/model/popular-country.dart';
import 'package:json_annotation/json_annotation.dart';
part 'public-search.g.dart';

@JsonSerializable(explicitToJson: true)
class PublicSearch {
  List<CountryModel> country;
  List<PopularCountryModel> popular_country;
  List<OccupationModel> occupation;
  List<ContinentModel> continent;

  String error;

  PublicSearch(
      this.country, this.popular_country, this.occupation, this.continent);

  PublicSearch.withError(String errorMessage) {
    error = errorMessage;
  }

  factory PublicSearch.fromJson(Map<Object, dynamic> json) =>
      _$PublicSearchFromJson(json);

  Map<Object, dynamic> toJson() => _$PublicSearchToJson(this);
}
