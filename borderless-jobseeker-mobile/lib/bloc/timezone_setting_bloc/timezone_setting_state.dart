part of 'timezone_setting_bloc.dart';

abstract class TimezoneSettingState extends Equatable {
  const TimezoneSettingState();
  
  @override
  List<Object> get props => [];
}

class TimezoneSettingInitial extends TimezoneSettingState {}

class TimezoneSettingLoading extends TimezoneSettingState {}

class TimezoneSettingSuccess extends TimezoneSettingState {
  final List<TimeZoneModel> timezoneList;

  const TimezoneSettingSuccess(this.timezoneList);

  @override
  List<Object> get props => [timezoneList];
}

class TimezoneSettingFailure extends TimezoneSettingState {
  final String error;

  TimezoneSettingFailure(this.error);
  @override
  List<Object> get props => [error];
}
