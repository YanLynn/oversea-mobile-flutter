import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/jobseeker.dart';
import 'package:borderlessWorking/data/model/language.dart';
import 'package:borderlessWorking/data/model/languagelevel.dart';
import 'package:borderlessWorking/data/model/selfintro_details.dart';
import 'package:borderlessWorking/data/repositories/jobseeker_profile_repositories.dart';
// import 'package:borderlessWorking/screens/jobseeker_profile/self_intro_details.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
part 'jobseeker_profile_event.dart';
part 'jobseeker_profile_state.dart';

class JobseekerProfileBloc
    extends Bloc<JobseekerProfileEvent, JobseekerProfileState> {
  final JobseekerProfileRepository jobseekerProfileRepository =
      JobseekerProfileRepository();
  JobseekerProfileBloc() : super(JobseekerProfileInitial());

  @override
  Stream<JobseekerProfileState> mapEventToState(
    JobseekerProfileEvent event,
  ) async* {
    if (event is UpdateSelfIntroButtonPressed) {
      yield JobseekerProfileLoading();
      try {
        final data = await jobseekerProfileRepository.updateSelfIntro(
          event.video,
          event.selfpr,
          event.faceimageprivatestatus,
          event.deletefacimage,
          event.faceimage,
          event.deleterelatedimages,
          event.relatedimages,
        );
        final datas = data;
        yield UpdateSelfIntroSuccess();
      } catch (error) {
        yield JobseekerProfileFailure(error: error.toString());
      }
    }
    if (event is GetSelfIntroList) {
      try {
        yield JobseekerProfileInitial();
        final selfintrodetails =
            await jobseekerProfileRepository.getSelfIntroDetails();

        final language_level =
            await jobseekerProfileRepository.getForeignlanguage();

        final languages = await jobseekerProfileRepository.getLanguage();

        yield GetSelfIntroSuccess(selfintrodetails, language_level, languages);
      } on NetworkError {
        yield JobseekerProfileFailure(error: 'サーバとの通信に失敗しました');
      }
    }

    if (event is InitialState) {
      yield JobseekerProfileInitial();
    }
  }
}
