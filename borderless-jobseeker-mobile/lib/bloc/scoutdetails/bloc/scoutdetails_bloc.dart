import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:borderlessWorking/data/repositories/scout_details_repositories.dart';
import 'package:equatable/equatable.dart';

part 'scoutdetails_event.dart';
part 'scoutdetails_state.dart';

class ScoutdetailsBloc extends Bloc<ScoutdetailsEvent, ScoutdetailsState> {
  Getscoutdetailsrepo _getscoutdetailsrepo = Getscoutdetailsrepo();
  ScoutdetailsBloc() : super(ScoutdetailsInitial());
  // {
  //   Getscoutdetails();
  // }
  List<Scout> scoutList = [];
  @override
  Stream<ScoutdetailsState> mapEventToState(
    ScoutdetailsEvent event,
  ) async* {
    if (event is Getscoutdetails) {
      try {
        yield ScoutdetailsInitial();
        final scoutlist =
            await _getscoutdetailsrepo.getscoutdetails(event.scoutid);
        print('getscoutlist $scoutlist');
        yield Getscoutdetailssuccess(scoutlist);
      } on NetworkError {
        yield Getscoutdetailsfails(
            "Failed to fetch data. is your device online?");
      }
    }
    if (event is ActiondetailsScout) {
      yield Scoutdetailsloading();
      try {
        final changedScout = await _getscoutdetailsrepo.actionScout(
            event.id, event.madeAction, 1);
        print('scout decline $changedScout');
        if (event.madeAction == 'delete') {
          yield Scoutremovesuccess(changedScout);
        }
        else if (event.madeAction == 'favourite') {
          yield Scoutsuccess(changedScout);
        }  
        // else {
        //   yield Getscoutdetailssuccess(changedScout);
        // }
      } catch (error) {
        yield Getscoutdetailsfails(error);
      }
    }
    // if (event is ActiondetailsScout) {
    //   yield Scoutdetailsloading();
    //   try {
    //     final changedScout = await _getscoutdetailsrepo.actionScout(
    //         event.id, event.madeAction, 1);
    //     print('scout decline $changedScout');
    //     scoutList = [];
    //     scoutList.addAll(changedScout);
    //     yield Scoutdetailsloading();
    //     yield Scoutsuccess(changedScout);
    //   } catch (error) {
    //     yield Getscoutdetailsfails(error);
    //   }
    // }
  }
}
