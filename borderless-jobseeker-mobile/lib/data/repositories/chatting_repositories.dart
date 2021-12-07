import 'package:borderlessWorking/data/api/chattingApiServices.dart';
import 'package:borderlessWorking/data/model/chat/chatUserList.dart';

class ChatRepositories {
  final ChatApiServices chatApiServices = ChatApiServices();
  Future<List<ChatUserList>> getChatUserList() =>
      chatApiServices.getChatUserList();

  Future<List> getMessages(data, int page) =>
      chatApiServices.getMessage(data, page);

  Future me() => chatApiServices.me();

  Future sendMessage(data) => chatApiServices.sendMessage(data);

  Future sendMail(data) => chatApiServices.sendMail(data);

  Future makeAsRead(
          String type, int scoutid_or_applyid, int role_id, int jobseeker_id) =>
      chatApiServices.makeAsRead(
          type, scoutid_or_applyid, role_id, jobseeker_id);
}
