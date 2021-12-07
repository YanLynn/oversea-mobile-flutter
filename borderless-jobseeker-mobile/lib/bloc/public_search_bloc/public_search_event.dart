part of 'public_search_bloc.dart';

abstract class PublicSearchEvent extends Equatable {
  const PublicSearchEvent();

  @override
  List<Object> get props => [];
}

class InitialState extends PublicSearchEvent {
  @override
  List<Object> get props => [];
}

class GetCountryList extends PublicSearchEvent {
  @override
  List<Object> get props => [];
}
