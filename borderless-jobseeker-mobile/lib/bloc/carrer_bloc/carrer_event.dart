part of 'carrer_bloc.dart';

abstract class CarrerEvent extends Equatable {
  const CarrerEvent();

  @override
  List<Object> get props => [];
}

class GetCarrerList extends CarrerEvent {
  @override
  List<Object> get props => null;
}

class InitialState extends CarrerEvent {
  @override
  List<Object> get props => [];
}

class UpdateCarrerButtenPressed extends CarrerEvent {
  final Object educations;
  final Object experiences;
  final Object carrers;

  const UpdateCarrerButtenPressed({
    @required this.educations,
    @required this.experiences,
    @required this.carrers,
  });

  @override
  List<Object> get props => [educations, experiences, carrers];

  @override
  String toString() =>
      'UpdateCarrerButtenPressed {educations: $educations ,experiencs;$experiences,carrers,$carrers}';
  // String toString() =>
  //     'UpdateCarrerButtenPressed {school_name: $school_name, subject: $subject,degree: $degree,from_year: $from_year,from_month: $from_month,to_year: $to_year, to_month: $to_month, status: $status }';
}
