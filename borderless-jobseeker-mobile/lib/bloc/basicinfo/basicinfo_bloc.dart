import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/basicinfo.dart';
import 'package:borderlessWorking/data/repositories/basicinfo_repositories.dart';
import 'package:borderlessWorking/data/repositories/carrer_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'basicinfo_event.dart';
part 'basicinfo_state.dart';

class BasicinfoBloc extends Bloc<BasicinfoEvent, BasicinfoState> {
  final Getjobseekerdetails _getjobseekerdetails = Getjobseekerdetails();
  BasicinfoBloc() : super(BasicinfoInitial());

  @override
  Stream<BasicinfoState> mapEventToState(
    BasicinfoEvent event,
  ) async* {
    if (event is Getbasicinfolist) {
      try {
        yield Basicinfoloading();
        final mList = await _getjobseekerdetails.basicinfo();
        yield BasicinfoSuccess(mList);
      } on NetworkError {
        yield BasicinfoFail("Failed to fetch data. is your device online?");
      }
    }
    //update
    if (event is UpdateButtonPressed) {
      yield UpdateLoading();
      try {
        final data = await _getjobseekerdetails.updatebasicinfo(
          event.jobseeker_name,
          event.jobseeker_furigana_name,
          event.jobseeker_furigana_name_status,
          event.gender,
          event.gender_status,
          event.dob,
          event.dob_status,
          event.current_address_status,
          event.address,
          event.phone,
          event.email,
          event.skype_account,
          event.final_education,
          event.current_situation,
          event.city_name,
          event.country_name,
          event.language_id,
        );
        yield UpdateSuccessful();
      } catch (error) {
        yield UpdateFailure(error: error.toString());
      }
    }
    if (event is InitialState) {
      yield BasicinfoInitial();
    }
  }
}
