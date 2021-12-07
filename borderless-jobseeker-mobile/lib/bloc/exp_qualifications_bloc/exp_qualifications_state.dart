part of 'exp_qualifications_bloc.dart';

abstract class ExpQualificationsState extends Equatable {
  const ExpQualificationsState();
  
  @override
  List<Object> get props => [];
}

class ExpQualificationsInitial extends ExpQualificationsState {}

class ExpQualificationsLoading extends ExpQualificationsState {}

class ExpQualificationsSuccess extends ExpQualificationsState {
  final List<ExpQualification> expQua;

  ExpQualificationsSuccess(this.expQua);
  @override
  List<Object> get props => [expQua];
}

class ExpQualificationsFailure extends ExpQualificationsState {
  final String error;

  ExpQualificationsFailure(this.error);
  @override
  List<Object> get props => [error];
}

class UpdateSuccess extends ExpQualificationsState {}
