part of 'public_search_bloc.dart';

abstract class PublicSearchState extends Equatable {
  const PublicSearchState();

  @override
  List<Object> get props => [];
}

class PublicSearchInitial extends PublicSearchState {}

class PublicSearchSuccess extends PublicSearchState {
  final List<PublicSearch> data;

  const PublicSearchSuccess(this.data);

  List<Object> get props => [data];
}

class PublicSearchFail extends PublicSearchState {
  final String error;
  PublicSearchFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}

class PublicSearchLoading extends PublicSearchState {}
