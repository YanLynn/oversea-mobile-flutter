part of 'carrer_bloc.dart';

abstract class CarrerState extends Equatable {
  const CarrerState();

  @override
  List<Object> get props => [];
}

class CarrerInitial extends CarrerState {
  const CarrerInitial();
  @override
  List<Object> get props => [];
}

class UpdateCarrerSuccess extends CarrerState {}

class GetCarrerSuccess extends CarrerState {
  final List<CarrerDetail> carrers;

  const GetCarrerSuccess(this.carrers);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [carrers];
}

class CarrerFail extends CarrerState {
  final String error;
  CarrerFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

class CarrerLoading extends CarrerState {}
