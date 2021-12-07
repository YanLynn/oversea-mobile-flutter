import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/career-update.dart';
import 'package:borderlessWorking/data/model/desired_condition.dart';

class DesiredConditionRepository {
  final ApiService _apiService = ApiService();
  Future<List<DesiredCondition>> getDesiredCondition() =>
      _apiService.getDesiredCondition();
  Future<String> updateDesiredCondition(
          desiredCondition, industries, occupations) =>
      _apiService.updateDesiredCondition(
          desiredCondition, industries, occupations);
  Future<List<CareerModel>> getCarrerRequiredList() =>
      _apiService.getCarrerRequiredList();
}
