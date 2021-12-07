part of 'chatuser_bloc.dart';

abstract class ChatuserState extends Equatable {
  const ChatuserState();

  @override
  List<Object> get props => [];
}

class ChatuserInitial extends ChatuserState {
  const ChatuserInitial();
  @override
  List<Object> get props => [];
}

class ChatuserListSuccess extends ChatuserState {
  final List<ChatUserList> getUserList;

  const ChatuserListSuccess(this.getUserList);

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [getUserList];
}

class ChatuserListFail extends ChatuserState {
  final String error;
  ChatuserListFail(this.error);
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [error];
}
