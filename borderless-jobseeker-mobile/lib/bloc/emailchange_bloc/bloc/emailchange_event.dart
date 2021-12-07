part of 'emailchange_bloc.dart';

abstract class EmailchangeEvent extends Equatable {
  const EmailchangeEvent();

  @override
  List<Object> get props => [];
}

// class CheckEmailButtonPressed extends EmailchangeEvent 
// {
//   final String email;

//   CheckEmailButtonPressed(this.email);

//   @override
//   List<Object> get props => [email];

//   @override
//   String toString() => 'CheckEmailButtonPressed { password: $email }';
// }

class ChangeEmailButtonPressed extends EmailchangeEvent 
{
  // final String password;
  final String email;

  ChangeEmailButtonPressed(this.email);

  @override
  List<Object> get props => [email];
}
class Checkpassword extends EmailchangeEvent 
{
  final String password;

  Checkpassword(this.password);

  @override
  List<Object> get props => [password];
}
class InitialState extends EmailchangeEvent {
  @override
  List<Object> get props => [];
}
