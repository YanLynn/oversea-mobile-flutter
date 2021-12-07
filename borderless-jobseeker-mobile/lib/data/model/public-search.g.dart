// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public-search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicSearch _$PublicSearchFromJson(Map<String, dynamic> json) {
  return PublicSearch(
    (json['country'] as List)
        ?.map((e) =>
            e == null ? null : CountryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['popular_country'] as List)
        ?.map((e) => e == null
            ? null
            : PopularCountryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['occupation'] as List)
        ?.map((e) => e == null
            ? null
            : OccupationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['continent'] as List)
        ?.map((e) => e == null
            ? null
            : ContinentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..error = json['error'] as String;
}

Map<String, dynamic> _$PublicSearchToJson(PublicSearch instance) =>
    <String, dynamic>{
      'country': instance.country?.map((e) => e?.toJson())?.toList(),
      'popular_country':
          instance.popular_country?.map((e) => e?.toJson())?.toList(),
      'occupation': instance.occupation?.map((e) => e?.toJson())?.toList(),
      'continent': instance.continent?.map((e) => e?.toJson())?.toList(),
      'error': instance.error,
    };
