part of 'timezone_setting_bloc.dart';

abstract class TimezoneSettingEvent extends Equatable {
  const TimezoneSettingEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends TimezoneSettingEvent {
  @override
  List<Object> get props => [];
}

class GetTimeZoneList extends TimezoneSettingEvent 
{
  @override
  List<Object> get props => [];
}