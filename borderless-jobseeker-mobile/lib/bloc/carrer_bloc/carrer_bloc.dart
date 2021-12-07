import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/career-update.dart';
import 'package:borderlessWorking/data/model/carrer_details.dart';
import 'package:borderlessWorking/data/model/education.dart';
import 'package:borderlessWorking/data/repositories/carrer_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'carrer_event.dart';
part 'carrer_state.dart';

class CarrerBloc extends Bloc<CarrerEvent, CarrerState> {
  final CarrerRepository carrerRepository = CarrerRepository();
  CarrerBloc() : super(CarrerInitial());

  @override
  Stream<CarrerState> mapEventToState(
    CarrerEvent event,
  ) async* {
    if (event is UpdateCarrerButtenPressed) {
      yield CarrerLoading();
      try {
        final data = await carrerRepository.updateCarrer(
            event.educations, event.experiences, event.carrers);
        yield UpdateCarrerSuccess();
      } catch (error) {
        yield CarrerFail(error.toString());
      }
    }
    if (event is GetCarrerList) {
      try {
        yield CarrerInitial();
        final mList = await carrerRepository.getCarrerList();
        yield GetCarrerSuccess(mList);
      } on NetworkError {
        yield CarrerFail("Failed to fetch data. is your device online?");
      }
    }
    if (event is InitialState) {
      yield CarrerInitial();
    }
  }
}
