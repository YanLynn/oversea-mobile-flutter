import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/scout_setting_repositories.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'scout_setting_event.dart';
part 'scout_setting_state.dart';

class ScoutSettingBloc extends Bloc<ScoutSettingEvent, ScoutSettingState> {
  final ScoutSettingRepository _scoutSettingRepository =
      ScoutSettingRepository();
  ScoutSettingBloc() : super(ScoutSettingInitial());

  @override
  Stream<ScoutSettingState> mapEventToState(
    ScoutSettingEvent event,
  ) async* {
    if (event is GetScoutSetting) {
      yield ScoutSettingLoading();
      try {
        // var storage = FlutterSecureStorage();
        // var value = await storage.read(key: "token");
        // event.jsId (if event has props)
        final data = await _scoutSettingRepository.getScoutSetting();
        yield ScoutSettingSuccess(data);
      } catch (error) {
        yield ScoutSettingFailure(error.toString());
      }
    }

    if (event is ScoutSettingChanged) {
      yield ScoutSettingLoading();
      try {
        final data = await _scoutSettingRepository
            .updateScoutSetting(event.scout_setting_status);
        yield ScoutSettingSuccess(data);
      } catch (error) {
        yield ScoutSettingFailure(error.toString());
      }
    }
  }
}
