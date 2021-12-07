part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgetButtonPressed extends ForgetPasswordEvent {
  final String email, routeName;

  const ForgetButtonPressed({@required this.email, this.routeName});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoginButtonPressed { email: $email }';
}
