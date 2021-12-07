part of 'desired_condition_bloc.dart';

abstract class DesiredConditionState extends Equatable {
  const DesiredConditionState();
  
  @override
  List<Object> get props => [];
}

class DesiredConditionInitial extends DesiredConditionState {}

class DesiredConditionLoading extends DesiredConditionState {}

class UpdateSuccess extends DesiredConditionState {}

class DesiredConditionSuccess extends DesiredConditionState {
  final List<DesiredCondition> desiredCondition;

  DesiredConditionSuccess(this.desiredCondition);
  @override
  List<Object> get props => [desiredCondition];
}

class DesiredConditionFailure extends DesiredConditionState {
  final String error;

  DesiredConditionFailure(this.error);
  @override
  List<Object> get props => [error];
}
