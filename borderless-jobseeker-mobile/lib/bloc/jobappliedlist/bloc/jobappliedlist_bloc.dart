import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/jobappliedpage.dart';
import 'package:borderlessWorking/data/repositories/jobdetails_repositories.dart';
import 'package:equatable/equatable.dart';

part 'jobappliedlist_event.dart';
part 'jobappliedlist_state.dart';

class JobappliedlistBloc
    extends Bloc<JobappliedlistEvent, JobappliedlistState> {
  GetjobdetailsRepository _getjobdetailsRepository = GetjobdetailsRepository();
  JobappliedlistBloc() : super(JobappliedlistInitial()) {
    Getjobappliedlist();
  }
  List<Jobappliedpage> jobappliedlist = [];
  int page = 0;
  bool isLoading = false;
  @override
  Stream<JobappliedlistState> mapEventToState(
    JobappliedlistEvent event,
  ) async* {
    if (event is Getjobappliedlist) {
      if (!isLoading) {
        isLoading = true;
        try {
          // yield JobappliedlistInitial();
          page++;
          List<Jobappliedpage> joblist =
              await _getjobdetailsRepository.getjobappliedpage(page);
          if (joblist.isEmpty) {
            page--;
          }
          print('jlist $joblist');
          jobappliedlist.addAll(joblist);
          yield JoblistLoading();
          yield Jobgetsuccess(joblist: jobappliedlist);
        } catch (error) {
          page--;
          yield Jobgetfail(error);
        }
      }
      isLoading = false;
    }
    if (event is Getjobstatus) {
      if (!isLoading) {
        isLoading = true;
        try {
          yield ChangestatusInitial();
          page = 1;
          List<Jobappliedpage> joblist = await _getjobdetailsRepository
              .getchangestatus(event.applyid, page);
          print('mmm $joblist');
          if (joblist.isEmpty) {
            page--;
          }
          jobappliedlist = [];
          jobappliedlist.addAll(joblist);
          yield JoblistLoading();
          yield Jobgetsuccess(joblist: joblist);
        } catch (error) {
          page--;
          yield Jobgetfail(error);
        }
      }
      isLoading = false;
    }
  }
}
