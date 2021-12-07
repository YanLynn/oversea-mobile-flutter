import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/desired_condition.dart';
import 'package:borderlessWorking/data/repositories/desired_condition_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'desired_condition_event.dart';
part 'desired_condition_state.dart';

class DesiredConditionBloc
    extends Bloc<DesiredConditionEvent, DesiredConditionState> {
  final DesiredConditionRepository _desiredConditionRepository =
      DesiredConditionRepository();
  DesiredConditionBloc() : super(DesiredConditionInitial());

  @override
  Stream<DesiredConditionState> mapEventToState(
    DesiredConditionEvent event,
  ) async* {
    if (event is GetDesiredCondition) {
      yield DesiredConditionLoading();
      try {
        final desiredCondition =
            await _desiredConditionRepository.getDesiredCondition();
        print(desiredCondition);
        yield DesiredConditionSuccess(desiredCondition);
      } catch (error) {
        yield DesiredConditionFailure("サーバとの通信に失敗しました");
      }
    }

    if (event is UpdateButtonPressed) {
      yield DesiredConditionLoading();
      try {
        final desiredCondition =
            await _desiredConditionRepository.updateDesiredCondition(
                event.desiredCondition, event.industries, event.occupations);
        print(desiredCondition);
        yield UpdateSuccess();
      } catch (error) {
        yield DesiredConditionFailure("サーバとの通信に失敗しました");
      }
    }
  }
}
