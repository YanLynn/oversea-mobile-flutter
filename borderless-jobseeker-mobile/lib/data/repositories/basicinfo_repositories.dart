import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/basicinfo.dart';
import 'package:borderlessWorking/data/model/basicinfo_lang.dart';

class Getjobseekerdetails {
  final ApiService _apiService = ApiService();
  Future<List<Basicinfo>> basicinfo() => _apiService.getbasicinfo();
  Future<List<Infolang>> getlanglist() => _apiService.getlanglist();
  // Future<List<Basicinfo>> countrylistbsinfo() => _apiService.countrylistbsinfo();

  Future<Map<String, dynamic>> updatebasicinfo(
    String jobseeker_name,
    String jobseeker_furigana_name,
    String jobseeker_furigana_name_status,
    String gender,
    String gender_status,
    String dob,
    String dob_status,
    String current_address_status,
    String address,
    String email,
    String phone,
    String skype_account,
    String final_education,
    String current_situation,
    String city_name,
    String country_name,
    String language_id,
  ) =>
      _apiService.updatebasicinfo(
        jobseeker_name,
        jobseeker_furigana_name,
        jobseeker_furigana_name_status,
        gender,
        gender_status,
        dob,
        dob_status,
        current_address_status,
        address,
        email,
        phone,
        skype_account,
        final_education,
        current_situation,
        city_name,
        country_name,
        language_id,
      );
}
