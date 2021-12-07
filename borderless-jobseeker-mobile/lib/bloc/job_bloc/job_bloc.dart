import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/repositories/job_repositories.dart';
import 'package:equatable/equatable.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobRepositories jobRepositories = JobRepositories();
  JobBloc() : super(JobInitial());
  List<Job> jobList = [];
  int page = 0;
  bool isLoading = false;

  @override
  Stream<JobState> mapEventToState(
    JobEvent event,
  ) async* {
    if (event is GetJobList) {
      if (!isLoading) {
        isLoading = true;
        try {
          page++;
          List<Job> jobs = await jobRepositories.getJobLists(page);
          if (jobs.isEmpty) {
            page--;
            //yield JobFail("Failed to fetch data. is your device online?");
          }
          jobList.addAll(jobs);
          yield JobLoading();
          yield JobSuccess(jobs: jobList);
        } on NetworkError catch (e) {
          page--;
          yield JobFail("Failed to fetch data. is your device online?");
        }
      }
      isLoading = false;
    }
  }
}
