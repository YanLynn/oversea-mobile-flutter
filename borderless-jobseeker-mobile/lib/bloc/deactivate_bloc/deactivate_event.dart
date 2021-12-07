part of 'deactivate_bloc.dart';

abstract class DeactivateEvent extends Equatable {
  const DeactivateEvent();

}


class DeactivateButtonPressed extends DeactivateEvent {
  final String password;

  const DeactivateButtonPressed({
    @required this.password,
  });

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'DeactivateButtonPressed { password: $password }';
}


