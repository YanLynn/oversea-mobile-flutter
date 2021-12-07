import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/job.dart';

class JobRepositories {
  final ApiService _apiService = ApiService();

  Future<List<Job>> getJobLists(int page) => _apiService.getJobLists(page);
}

class NetworkError extends Error {}
