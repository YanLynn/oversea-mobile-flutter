import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/timezone.dart';
import 'package:borderlessWorking/data/repositories/timezone_repositories.dart';
import 'package:equatable/equatable.dart';

part 'timezone_setting_event.dart';
part 'timezone_setting_state.dart';

class TimezoneSettingBloc
    extends Bloc<TimezoneSettingEvent, TimezoneSettingState> {
  final TimeZoneRepository _timeZoneRepository = TimeZoneRepository();
  TimezoneSettingBloc() : super(TimezoneSettingInitial());

  @override
  Stream<TimezoneSettingState> mapEventToState(
    TimezoneSettingEvent event,
  ) async* {
    if (event is GetTimeZoneList) {
      yield TimezoneSettingLoading();
      try {
        final timezonelist = await _timeZoneRepository.getTimeZoneList();
        yield TimezoneSettingSuccess(timezonelist);
      } catch (error) {
        yield TimezoneSettingFailure(error.toString());
      }
    }
  }
}
