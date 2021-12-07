part of 'exp_qualifications_bloc.dart';

abstract class ExpQualificationsEvent extends Equatable {
  const ExpQualificationsEvent();

  @override
  List<Object> get props => [];
}

class GetExpQualification extends ExpQualificationsEvent {
  @override
  List<Object> get props => null;
}

class UpdateButtonPressed extends ExpQualificationsEvent {
  final Object industryHistory;
  final Object deleteIndustryHistoryId;

  final Object studyAbroad;
  final Object deleteStudyAbroad;

  final Object workingAbroad;
  final Object deleteWorkingAbroad;

  final Object workVisa;
  final Object otherQua;

  final Object langLevel;
  final Object deleteLangLevel;

  const UpdateButtonPressed({
    @required this.industryHistory,
    @required this.deleteIndustryHistoryId,
    @required this.studyAbroad,
    @required this.deleteStudyAbroad,
    @required this.workingAbroad,
    @required this.deleteWorkingAbroad,
    @required this.workVisa,
    @required this.langLevel,
    @required this.deleteLangLevel,
    @required this.otherQua,
  });

  @override
  List<Object> get props => [industryHistory, deleteIndustryHistoryId, studyAbroad, deleteStudyAbroad, workingAbroad, deleteWorkingAbroad, workVisa, langLevel, deleteLangLevel, otherQua];
}