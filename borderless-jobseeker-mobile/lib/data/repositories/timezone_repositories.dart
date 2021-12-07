import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/timezone.dart';

class TimeZoneRepository {
  final ApiService _apiService = ApiService();
  Future<List<TimeZoneModel>> getTimeZoneList() =>
      _apiService.getTimeZoneList();
}
