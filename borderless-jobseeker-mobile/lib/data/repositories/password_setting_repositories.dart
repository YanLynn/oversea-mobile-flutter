import 'package:borderlessWorking/data/api/apiServices.dart';

class PasswordSettingRepository {
  final ApiService _apiService = ApiService();

  Future<String> checkPassword(pass) => _apiService.checkPassword(pass);
  Future<String> changePassword(pass) => _apiService.changePassword(pass);
}
