import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/career-update.dart';
import 'package:borderlessWorking/data/model/carrer_details.dart';

class CarrerRepository {
  final ApiService _apiService = ApiService();

  Future<List<CarrerDetail>> getCarrerList() => _apiService.getCarrerList();

  Future<List<CareerModel>> getCarrerRequiredList() =>
      _apiService.getCarrerRequiredList();

  // Future<List<String>> getIsoList() => _apiService.GetIsoList();

  // Future<List<Position>> getPosition() => _apiService.GetPositon();

  // Future<List<EmploymentType>> getEmploymentType() =>
  //     _apiService.GetEmployment();

  Future<String> updateCarrer(
          Object educations, Object experiences, Object carrers) =>
      _apiService.updateCarrer(educations, experiences, carrers);
}

class NetworkError extends Error {}
