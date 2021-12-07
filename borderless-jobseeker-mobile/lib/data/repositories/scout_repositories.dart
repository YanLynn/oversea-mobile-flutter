import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/scout.dart';

class ScoutRepository {
  final ApiService _apiService = ApiService();

  Future<List<Scout>> getScoutedList(page) => _apiService.getScoutedList(page);
  Future<List> getScoutedListTotal() => _apiService.getScoutedListTotal();

  Future<List<Scout>> actionScout(scoutId, madeAction, page) =>
      _apiService.actionScout(scoutId, madeAction, page);
}
