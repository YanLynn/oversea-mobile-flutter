import 'package:borderlessWorking/data/api/apiServices.dart';

class EmailchangeRepository {
  final ApiService _apiService = ApiService();
  Future<Map> getUserData() => _apiService.getUserData();
  Future<String> checkPassword2(pass) => _apiService.checkPassword(pass);
  Future<String> changeemail(email) => _apiService.emailchange(email);
}
