import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/model/public-search.dart';

class PublicSearchRepository {
  final ApiService _apiService = ApiService();

  Future<List<PublicSearch>> getJobseekerInit() =>
      _apiService.getJobseekerInit();

  Future<List<Job>> getJobs(page, searchData) =>
      _apiService.getJobs(page, searchData);

  Future addAndRemoveFavJob(int jobId, String type) =>
      _apiService.addAndRemoveFavJob(jobId, type);
}

class NetworkError extends Error {}
