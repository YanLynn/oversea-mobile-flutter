part of 'deactivate_bloc.dart';


abstract class DeactivateState extends Equatable {
  const DeactivateState();

  @override
  List<Object> get props => [];
}

class DeactivateInitial extends DeactivateState {}

class DeactivateLoading extends DeactivateState {}

class DeactivateFailure extends DeactivateState {
  final String error;

  const DeactivateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class DeactivateSuccess extends DeactivateState{}