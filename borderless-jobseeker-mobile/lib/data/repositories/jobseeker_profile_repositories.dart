import 'dart:io';

import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/language.dart';
import 'package:borderlessWorking/data/model/languagelevel.dart';
import 'package:borderlessWorking/data/model/selfintro_details.dart';

class JobseekerProfileRepository {
  final ApiService _apiService = ApiService();

  Future updateSelfIntro(
    String video,
    String selfpr,
    String faceimageprivatestatus,
    bool deletefacimage,
    File faceimage,
    List<String> deleterelatedimages,
    List relatedimages,
  ) =>
      _apiService.updateSelfIntro(
        video,
        selfpr,
        faceimageprivatestatus,
        deletefacimage,
        faceimage,
        deleterelatedimages,
        relatedimages,
      );

  Future<List<SelfIntroDetail>> getSelfIntroDetails() =>
      _apiService.getSelfIntroDetails();

  Future<List<LanguageLevel>> getForeignlanguage() =>
      _apiService.getForeignlanguage();

  Future<List<Language>> getLanguage() => _apiService.getLanguage();
}

class NetworkError extends Error {}
