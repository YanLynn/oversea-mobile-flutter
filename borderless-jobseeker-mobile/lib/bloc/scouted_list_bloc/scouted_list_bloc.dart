import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:borderlessWorking/data/repositories/scout_repositories.dart';
import 'package:equatable/equatable.dart';

part 'scouted_list_event.dart';
part 'scouted_list_state.dart';

class ScoutedListBloc extends Bloc<ScoutedListEvent, ScoutedListState> {
  final ScoutRepository _scoutRepository = ScoutRepository();
  ScoutedListBloc() : super(ScoutedListInitial());
  List<Scout> scoutList = [];
  int page = 0;
  bool isLoading = false;

  @override
  Stream<ScoutedListState> mapEventToState(
    ScoutedListEvent event,
  ) async* {
    if (event is GetList) {
      if (!isLoading) {
        isLoading = true;

        try {
          page++;
          final scoutedList = await _scoutRepository.getScoutedList(page);
          if (scoutedList.isEmpty) {
            page--;
          }
          scoutList.addAll(scoutedList);
          yield ScoutedListLoading(); // for infinite scroll load
          yield ScoutedListSuccess(scoutList);
        } catch (error) {
          page--;
          yield ScoutedListFailure(error);
        }
      }
      isLoading = false;
    }

    if (event is ActionScout) {
      yield ActionLoading();
      try {
        page = 1;
        final changedScout = await _scoutRepository.actionScout(
            event.id, event.madeAction, page);
        print('scout decline $changedScout');
        if (changedScout.isEmpty) {
          page--;
        }
        scoutList = [];
        scoutList.addAll(changedScout);
        yield ScoutedListLoading();
        yield ScoutedListSuccess(changedScout);
      } catch (error) {
        yield ScoutedListFailure(error);
      }
    }
  }
}
