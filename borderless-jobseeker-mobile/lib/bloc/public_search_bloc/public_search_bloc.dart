import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/public-search.dart';
import 'package:borderlessWorking/data/repositories/public_search_repositories.dart';
import 'package:equatable/equatable.dart';

part 'public_search_event.dart';
part 'public_search_state.dart';

class PublicSearchBloc extends Bloc<PublicSearchEvent, PublicSearchState> {
  final PublicSearchRepository publicSearchRepository =
      PublicSearchRepository();
  PublicSearchBloc() : super(PublicSearchInitial());

  @override
  Stream<PublicSearchState> mapEventToState(
    PublicSearchEvent event,
  ) async* {
    if (event is GetCountryList) {
      try {
        yield PublicSearchInitial();
        final mList = await publicSearchRepository.getJobseekerInit();
        yield PublicSearchSuccess(mList);
      } on NetworkError {
        yield PublicSearchFail("Failed to fetch data. is your device online?");
      }
    }
  }
}
