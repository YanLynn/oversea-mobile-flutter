part of 'basicinfo_bloc.dart';

abstract class BasicinfoState extends Equatable {
  const BasicinfoState();

  @override
  List<Object> get props => [];
}

class BasicinfoInitial extends BasicinfoState {
  const BasicinfoInitial();
  @override
  List<Object> get props => [];
}

class Basicinfoloading extends BasicinfoState {}

class BasicinfoSuccess extends BasicinfoState {
  final List<Basicinfo> info;

  const BasicinfoSuccess(this.info);

  @override
  List<Object> get props => [info];
}

class BasicinfoFail extends BasicinfoState {
  final String error;
  BasicinfoFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

//jobseekerprofile_update
class UpdateLoading extends BasicinfoState {}

class UpdateSuccessful extends BasicinfoState{}

class UpdateFailure extends BasicinfoState {
  final String error;

  const UpdateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}

