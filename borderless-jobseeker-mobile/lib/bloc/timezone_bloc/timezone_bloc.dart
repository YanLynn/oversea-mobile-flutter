import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/timezonesetting.dart';
import 'package:borderlessWorking/data/repositories/timezone_setting_repositories.dart';
import 'package:equatable/equatable.dart';

part 'timezone_event.dart';
part 'timezone_state.dart';

class TimezoneBloc extends Bloc<TimezoneEvent, TimezoneState> {
  final _timeZoneSettingRepository = TimeZoneSettingRepository();
  TimezoneBloc() : super(TimezoneInitial());

  @override
  Stream<TimezoneState> mapEventToState(
    TimezoneEvent event,
  ) async* {
    if (event is GetUserTimeZone) {
      yield TimezoneLoading();
      try {
        final usertimezone = await _timeZoneSettingRepository.getUserTimeZone();
        print("user time zone $usertimezone");
        yield GetUserTimeZoneSuccess(usertimezone);
      } catch (error) {
        yield TimezoneFailure("サーバとの通信に失敗しました");
      }
    }
    if (event is ChangeTimezoneButtonPressed) {
      yield TimezoneLoading();
      try {
        final changedTimezone = await _timeZoneSettingRepository
            .changedTimeZone(event.changeTimezone, event.changeOffset);
        yield TimeZoneChangedSuccess(changedTimezone);
        // yield GetUserTimeZoneSuccess(changedTimezone);
      } catch (error) {
        yield TimezoneFailure("サーバとの通信に失敗しました");
      }
    }
  }
}
