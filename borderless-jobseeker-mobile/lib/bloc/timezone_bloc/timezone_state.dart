part of 'timezone_bloc.dart';

abstract class TimezoneState extends Equatable {
  const TimezoneState();
  
  @override
  List<Object> get props => [];
}

class TimezoneInitial extends TimezoneState {}

class TimezoneLoading extends TimezoneState {}

class GetUserTimeZoneSuccess extends TimezoneState {
  final List<TimeZoneSettingModel> usertimezoneList;

  const GetUserTimeZoneSuccess(this.usertimezoneList);

  @override
  List<Object> get props => [usertimezoneList];
}
class TimeZoneChangedSuccess extends TimezoneState {
  final List<TimeZoneSettingModel> usertimezoneList;

  const TimeZoneChangedSuccess(this.usertimezoneList);

  @override
  List<Object> get props => [usertimezoneList];
}

class TimezoneFailure extends TimezoneState {
  final String error;

  TimezoneFailure(this.error);
  @override
  List<Object> get props => [error];
}