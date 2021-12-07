import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/scout.dart';
// import 'package:borderlessWorking/data/model/scoutdetails.dart';

class Getscoutdetailsrepo {
  final ApiService _apiService = ApiService();
  //scoutdetails
  Future<List<Scout>> getscoutdetails(scoutid) =>
      _apiService.getscoutdetails(scoutid);
  //delete socuts
  Future<List<Scout>> actionScout(scoutId, madeAction, page) =>
      _apiService.actionScout(scoutId, madeAction, page);
}

class NetworkError extends Error {}
