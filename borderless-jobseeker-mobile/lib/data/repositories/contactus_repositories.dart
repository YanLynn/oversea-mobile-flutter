import 'package:borderlessWorking/data/api/apiServices.dart';

class ContactusRepository {
  final ApiService _apiService = ApiService();
  Future<String> contactus(
          String corporateName,
          String name,
          String furiganaName,
          String email,
          String confirmEmail,
          String inquiryDetails,
          bool policy) =>
      _apiService.contactus(corporateName, name, furiganaName, email,
          confirmEmail, inquiryDetails, policy);
}
