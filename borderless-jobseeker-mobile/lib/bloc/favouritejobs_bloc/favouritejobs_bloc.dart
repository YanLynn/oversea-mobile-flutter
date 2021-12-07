import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/favouritejobs.dart';
import 'package:borderlessWorking/data/repositories/favouritejobs_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'favouritejobs_event.dart';
part 'favouritejobs_state.dart';

class FavouritejobsBloc extends Bloc<FavouritejobsEvent, FavouritejobsState> {
  FavouritejobsRepositories favouritejobsRepositories =
      FavouritejobsRepositories();
  FavouritejobsBloc() : super(FavouritejobsInitial()) {
    // GetFavList();
  }

  @override
  Stream<FavouritejobsState> mapEventToState(
    FavouritejobsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetFavList) {
      try {
        yield FavouritejobsInitial();
        final mList = await favouritejobsRepositories.getfavouritejobs();
        print(mList);
        yield FavouritejobsSuccess(mList);
      } on NetworkError {
        yield FavouritejobsFail("Failed to fetch data, is your device online?");
      }
    }
    if (event is RemoveFavList) {
      try {
        yield RemoveFavouritejobsLoading();

        await favouritejobsRepositories.removefavouritejobs(event.id);
        final mList = await favouritejobsRepositories.getfavouritejobs();

        yield FavouritejobsSuccess(mList);
      } on NetworkError {
        yield FavouritejobsFail("Failed to fetch data, is your device online?");
      }
    }
  }
}
