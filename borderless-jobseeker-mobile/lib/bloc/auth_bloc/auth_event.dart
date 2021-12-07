import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoginFormReturn extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthenticationEvent {}



class PasswordCheckButtonPressed extends AuthenticationEvent {
  final String password;

  const PasswordCheckButtonPressed({
    @required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'LoginButtonPressed { password: $password }';
}