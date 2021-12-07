part of 'favouritejobs_bloc.dart';

abstract class FavouritejobsState extends Equatable {
  const FavouritejobsState();

  @override
  List<Object> get props => [];
}

class FavouritejobsInitial extends FavouritejobsState {
  const FavouritejobsInitial();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FavouritejobsSuccess extends FavouritejobsState {
  final List<FavouritejobsModel> favouritejobs;
  const FavouritejobsSuccess(this.favouritejobs);

  @override
  //TODO: implement props
  List<Object> get props => [favouritejobs];
}

class FavouritejobsFail extends FavouritejobsState {
  final String error;
  FavouritejobsFail(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class RemoveFavouritejobsLoading extends FavouritejobsState {}

class RemoveFavouritejobsSuccess extends FavouritejobsState {}
