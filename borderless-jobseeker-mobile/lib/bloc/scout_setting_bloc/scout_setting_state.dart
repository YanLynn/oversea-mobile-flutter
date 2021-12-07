part of 'scout_setting_bloc.dart';

abstract class ScoutSettingState extends Equatable {
  const ScoutSettingState();
  
  @override
  List<Object> get props => [];
}

class ScoutSettingInitial extends ScoutSettingState {}

class ScoutSettingLoading extends ScoutSettingState {}

class ScoutSettingSuccess extends ScoutSettingState {
  final dynamic status;

  ScoutSettingSuccess(this.status);
  @override
  List<Object> get props => [status];
}

class ScoutSettingFailure extends ScoutSettingState {
  final String error;

  ScoutSettingFailure(this.error);
  @override
  List<Object> get props => [error];
}
