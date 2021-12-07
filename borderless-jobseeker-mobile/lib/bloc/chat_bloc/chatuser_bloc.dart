import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/model/chat/chatUserList.dart';
import 'package:borderlessWorking/data/repositories/chatting_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'chatuser_event.dart';
part 'chatuser_state.dart';

class ChatuserBloc extends Bloc<ChatuserEvent, ChatuserState> {
  ChatRepositories _chatRepositories = ChatRepositories();
  ChatuserBloc() : super(ChatuserInitial());

  @override
  Stream<ChatuserState> mapEventToState(
    ChatuserEvent event,
  ) async* {
    if (event is GetChatUserList) {
      try {
        final getUser = await _chatRepositories.getChatUserList();

        yield ChatuserListSuccess(getUser);
      } catch (e) {
        print(e);
      }
    }
  }
}
