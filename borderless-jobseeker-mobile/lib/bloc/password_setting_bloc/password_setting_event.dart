part of 'password_setting_bloc.dart';

abstract class PasswordSettingEvent extends Equatable {
  const PasswordSettingEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends PasswordSettingEvent {
  @override
  List<Object> get props => [];
}

class CancelChangePassword extends PasswordSettingEvent {
  @override
  List<Object> get props => [];
}

class CheckPasswordButtonPressed extends PasswordSettingEvent 
{
  final String password;

  CheckPasswordButtonPressed(this.password);

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'CheckPasswordButtonPressed { password: $password }';
}

class ChangePasswordButtonPressed extends PasswordSettingEvent 
{
  final String password;

  ChangePasswordButtonPressed(this.password);

  @override
  List<Object> get props => [password];
}