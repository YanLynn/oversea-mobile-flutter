import 'package:borderlessWorking/data/api/apiServices.dart';

class RegisterRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> register(
          String jobseeker_name,
          String jobseeker_furigana_name,
          String dob,
          String country_name,
          String country_id,
          String phone,
          String email,
          String password) =>
      _apiService.register(jobseeker_name, jobseeker_furigana_name, dob,
          country_name, country_id, phone, email, password);
  Future<String> mailcheck1(String email) => _apiService.mailcheck1(email);
}

class NetworkError extends Error {}
