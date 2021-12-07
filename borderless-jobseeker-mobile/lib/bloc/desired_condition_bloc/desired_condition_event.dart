part of 'desired_condition_bloc.dart';

abstract class DesiredConditionEvent extends Equatable {
  const DesiredConditionEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends DesiredConditionEvent {
  @override
  List<Object> get props => [];
}

class GetDesiredCondition extends DesiredConditionEvent {
  @override
  List<Object> get props => null;
}

class UpdateButtonPressed extends DesiredConditionEvent {
  final Object desiredCondition;
  final Object industries;
  final Object occupations;

  const UpdateButtonPressed({
    @required this.desiredCondition,
    @required this.industries,
    @required this.occupations,
  });

  @override
  List<Object> get props => [desiredCondition, industries, occupations];
}