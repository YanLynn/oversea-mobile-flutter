import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/model/jobapplied.dart';
import 'package:borderlessWorking/data/model/jobappliedpage.dart';
import 'package:borderlessWorking/data/model/jobdata.dart';
import 'package:borderlessWorking/data/model/scoutstatus.dart';

class GetjobdetailsRepository {
  String jobID;
  final ApiService _apiService = ApiService();

  Future<JobDataModel> getJobData(jobID) => _apiService.getJobData(jobID);
  //jobapplied
  Future<Map> getUserData() => _apiService.getUserData();
  Future<String> jobapplied(jobID) => _apiService.jobapplied(jobID);
  //jobapplied-status
  Future<List<Jobapply>> getjobappliedlist(jobID) =>
      _apiService.getjobappliedlist(jobID);
  //scout_status
  Future<List<Scoutstatus>> getscoutstatus(jobID) =>
      _apiService.getscoutstatus(jobID);
  //jobappliedlistpage
  Future<List<Jobappliedpage>> getjobappliedpage(int page) =>
      _apiService.getjobappliedpage(page);
  //change_status
  Future<List<Jobappliedpage>> getchangestatus(applyid, int page) =>
      _apiService.getchangestatus(applyid, page);
}

class NetworkError extends Error {}
