import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/exp_qualification.dart';
import 'package:borderlessWorking/data/repositories/exp_qualification_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'exp_qualifications_event.dart';
part 'exp_qualifications_state.dart';

class ExpQualificationsBloc
    extends Bloc<ExpQualificationsEvent, ExpQualificationsState> {
  final ExpQualificationRepository _expQualificationRepository =
      ExpQualificationRepository();
  ExpQualificationsBloc() : super(ExpQualificationsInitial());

  @override
  Stream<ExpQualificationsState> mapEventToState(
    ExpQualificationsEvent event,
  ) async* {
    if (event is GetExpQualification) {
      yield ExpQualificationsLoading();
      try {
        final expQua = await _expQualificationRepository.getExpQualification();
        print(expQua);
        yield ExpQualificationsSuccess(expQua);
      } catch (error) {
        yield ExpQualificationsFailure("サーバとの通信に失敗しました");
      }
    }

    if (event is UpdateButtonPressed) {
      yield ExpQualificationsLoading();
      try {
        final desiredCondition =
            await _expQualificationRepository.updateExpQualification(
          event.industryHistory,
          event.deleteIndustryHistoryId,
          event.studyAbroad,
          event.deleteStudyAbroad,
          event.workingAbroad,
          event.deleteWorkingAbroad,
          event.workVisa,
          event.langLevel,
          event.deleteLangLevel,
          event.otherQua,
        );
        print(desiredCondition);
        yield UpdateSuccess();
      } catch (error) {
        yield ExpQualificationsFailure("サーバとの通信に失敗しました");
      }
    }
  }
}
