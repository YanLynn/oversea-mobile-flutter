part of 'favouritejobs_bloc.dart';

abstract class FavouritejobsEvent extends Equatable {
  const FavouritejobsEvent();

  @override
  List<Object> get props => [];
}

class GetFavList extends FavouritejobsEvent {
  @override
  List<Object> get props => null;
}

class RemoveFavList extends FavouritejobsEvent {
  final int id;

  const RemoveFavList({@required this.id});
  @override
  List<Object> get props => [id];
  @override
  String toString() => 'RemoveFavList { id: $id}';
}
