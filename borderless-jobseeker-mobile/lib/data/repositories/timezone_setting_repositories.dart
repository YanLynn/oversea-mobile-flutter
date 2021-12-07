import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/timezonesetting.dart';

class TimeZoneSettingRepository {
  final ApiService _apiService = ApiService();
  Future<List<TimeZoneSettingModel>> getUserTimeZone() =>
      _apiService.getUserTimeZone();
  Future<List<TimeZoneSettingModel>> changedTimeZone(
          changedTimezone, changedOffset) =>
      _apiService.changedTimeZone(changedTimezone, changedOffset);
}
