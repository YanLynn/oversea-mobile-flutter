import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/favouritejobs.dart';

class FavouritejobsRepositories {
  final ApiService _apiService = ApiService();
  Future<List<FavouritejobsModel>> getfavouritejobs() =>
      _apiService.getfavouritejobs();
  Future<FavouritejobsModel> removefavouritejobs(id) =>
      _apiService.removefavouritejobs(id);
}

class NetworkError extends Error {}
