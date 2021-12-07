part of 'forget_password_bloc.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String success;

  const ForgetPasswordSuccess(this.success);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [success];
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String error;

  const ForgetPasswordFailure({@required this.error});

  // @override
  // List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
