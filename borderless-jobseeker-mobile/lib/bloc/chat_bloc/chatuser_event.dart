part of 'chatuser_bloc.dart';

abstract class ChatuserEvent extends Equatable {
  const ChatuserEvent();

  @override
  List<Object> get props => [];
}

class GetChatUserList extends ChatuserEvent {}

class SearchChatUser extends ChatuserEvent {
  final String fliterTxt;
  const SearchChatUser({@required this.fliterTxt});

  @override
  List<Object> get props => [fliterTxt];
  @override
  String toString() => 'fliterTxt { fliterTxt: $fliterTxt }';
}

class UserListLoading extends ChatuserEvent {}
