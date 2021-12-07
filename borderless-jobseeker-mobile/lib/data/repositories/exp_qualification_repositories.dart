import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/exp_qualification.dart';

class ExpQualificationRepository {
  final ApiService _apiService = ApiService();
  Future<List<ExpQualification>> getExpQualification() =>
      _apiService.getExpQualification();
  Future<String> updateExpQualification(
          industryHistory,
          deleteIndustryHistoryId,
          studyAbroad,
          deleteStudyAbroad,
          workingAbroad,
          deleteWorkingAbroad,
          workVisa,
          langLevel,
          deleteLangLevel,
          otherQua) =>
      _apiService.updateExpQualification(
          industryHistory,
          deleteIndustryHistoryId,
          studyAbroad,
          deleteStudyAbroad,
          workingAbroad,
          deleteWorkingAbroad,
          workVisa,
          langLevel,
          deleteLangLevel,
          otherQua);
}
