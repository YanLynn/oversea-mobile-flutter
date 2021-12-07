import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final Map user;

  const AuthenticationAuthenticated(this.user);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class LoginPage extends AuthenticationState {}

class PasswordSettingLoading extends AuthenticationState {}
