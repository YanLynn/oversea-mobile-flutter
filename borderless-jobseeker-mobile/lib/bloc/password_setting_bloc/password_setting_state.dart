part of 'password_setting_bloc.dart';

abstract class PasswordSettingState extends Equatable {
  const PasswordSettingState();
  
  @override
  List<Object> get props => [];
}

class PasswordSettingInitial extends PasswordSettingState {}

class PasswordSettingLoading extends PasswordSettingState {}

class PasswordSettingSuccess extends PasswordSettingState {
  final String msg;

  PasswordSettingSuccess(this.msg);
  @override
  List<Object> get props => [msg];
}

class PasswordChangedSuccess extends PasswordSettingState {
  final String msg;

  PasswordChangedSuccess(this.msg);
  @override
  List<Object> get props => [msg];
}

class PasswordSettingFailure extends PasswordSettingState {
  final String error;

  const PasswordSettingFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'password change { error: $error }'; 
}
