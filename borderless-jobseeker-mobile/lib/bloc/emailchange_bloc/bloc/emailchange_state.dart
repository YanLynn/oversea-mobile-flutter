part of 'emailchange_bloc.dart';

abstract class EmailchangeState extends Equatable {
  const EmailchangeState();
  
  @override
  List<Object> get props => [];
}

class EmailchangeInitial extends EmailchangeState {}

class EmailSettingLoading extends EmailchangeState {}

class EmailChangedSuccess extends EmailchangeState {
  final String msg;

  EmailChangedSuccess(this.msg);
  @override
  List<Object> get props => [msg];
}

class EmailchangeFailure extends EmailchangeState {
  final String error;

  const EmailchangeFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Email change { error: $error }'; 
}
class PasswordcheckFailure extends EmailchangeState {
  final String passworderror;

  const PasswordcheckFailure({this.passworderror});

  @override
  List<Object> get props => [passworderror];

  @override
  String toString() => 'password error { error: $passworderror }'; 
}


class PasswordcheckSuccess extends EmailchangeState {
  final String pswsuccess;

  PasswordcheckSuccess(this.pswsuccess);
  @override
  List<Object> get props => [pswsuccess];
}
