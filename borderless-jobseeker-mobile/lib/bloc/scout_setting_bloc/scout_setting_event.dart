part of 'scout_setting_bloc.dart';

abstract class ScoutSettingEvent extends Equatable {
  const ScoutSettingEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends ScoutSettingEvent {
  @override
  List<Object> get props => [];
}

class GetScoutSetting extends ScoutSettingEvent 
{
  @override
  List<Object> get props => [];
}

class ScoutSettingChanged extends ScoutSettingEvent 
{
  final int scout_setting_status;

  ScoutSettingChanged(this.scout_setting_status);

  @override
  List<Object> get props => [scout_setting_status];
}

