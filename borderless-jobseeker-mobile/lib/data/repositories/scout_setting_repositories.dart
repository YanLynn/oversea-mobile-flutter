import 'package:borderlessWorking/data/api/apiServices.dart';
// import 'package:borderlessWorking/data/model/jobseeker.dart';

class ScoutSettingRepository {
  final ApiService _apiService = ApiService();
  Future<String> updateScoutSetting(status) =>
      _apiService.updateScoutSetting(status);

  Future<int> getScoutSetting() => _apiService.getScoutSetting();
}
