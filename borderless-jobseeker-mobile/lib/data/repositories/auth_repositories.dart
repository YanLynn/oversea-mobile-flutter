import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> hasToken() => _apiService.hasToken();

  Future<String> getToken() => _apiService.getToken();

  Future<void> persistToken(String token) => _apiService.persistToken(token);
  Future<dynamic> persistUserData(userData) =>
      _apiService.persistUserData(userData);

  Future<Map> getUserData() => _apiService.getUserData();

  Future<void> deleteToken() => _apiService.deleteToken();

  Future<Map<String, dynamic>> login(String email, String password) =>
      _apiService.login(email, password);

  Future<String> forgetPassword(String email, String routeName) =>
      _apiService.forgetPassword(email, routeName);

  Future<Map<String, dynamic>> deactivate(String password) =>
      _apiService.deactivate(password);

  Future info() => _apiService.info();
}
