import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/chat/chatUserList.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'apiServices.dart';

class ChatApiServices {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final AuthRepository _authRepository = AuthRepository();
  static String mainUrl = Apis.mailURL;
  final _dio = getDio();

  Future<List<ChatUserList>> getChatUserList() async {
    var token = await ApiService().getToken();
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    final loginUser = await _authRepository.getUserData();
    final roleId = loginUser['role_id'];

    final urlList = [
      mainUrl + '/chattables/' + jsonEncode(roleId) + '/scout?q=',
      mainUrl + '/chattables/' + jsonEncode(roleId) + '/job-apply?q='
    ];

    final res = await Future.wait(urlList.map((String url) {
      return _dio.get(url);
    }));
    var scoutRes = res[0];
    var jobApplyRes = res[1];
    List<ChatUserList> _userList = [];
    var itemList = scoutRes.data['data'] + jobApplyRes.data['data'];
    for (var item in itemList) {
      ChatUserList data = new ChatUserList.fromJson(item);
      _userList.add(data);
    }
    _userList.sort((a, b) {
      var adate = a.o_created_at;
      var bdate = b.o_created_at;
      //null error
      if (adate == null || bdate == null) {
        adate = DateTime.utc(2000);
        bdate = DateTime.utc(2000);
      }
      return bdate.compareTo(adate);
    });
    return _userList;
  }

  Future<List> getMessage(data, int page) async {
    final msgAndMetaURL = [
      mainUrl +
          '/messages/' +
          data.type +
          '/' +
          jsonEncode(data.scoutid_or_applyid) +
          '?page=' +
          '$page',
      mainUrl +
          '/messages/meta/' +
          data.type +
          '/' +
          jsonEncode(data.scoutid_or_applyid),
    ];
    final res = await Future.wait(msgAndMetaURL.map((String url) {
      return _dio.get(url);
    }));
    return res;
  }

  Future me() async {
    Response res = await _dio.get(mainUrl + '/me');
    return res.data['data'];
  }

  Future sendMessage(data) async {
    FormData formData = FormData.fromMap({
      "recruiter_id": data['recruiter_id'],
      "jobseeker_id": data['jobseeker_id'],
      "speaker_id": data['speaker_id'],
      "speaker_role_id": data['speaker_role_id'],
      "scoutid_or_applyid": data['scoutid_or_applyid'],
      "type": data['type'],
      "message": data['message'],
      "created_at": data['created_at'],
      "message_type": data['message_type'],
      "file_expired": data['file_expired'],
      "file": data['file']
    });
    Response res = await _dio.post(mainUrl + '/messages', data: formData);
    return res.data['data'];
  }

  Future<void> sendMail(data) async {
    await _dio.post(mainUrl + '/messages/send-mail', data: data);
  }

  Future makeAsRead(String type, int scoutid_or_applyid, int role_id,
      int jobseeker_id) async {
    Response res = await _dio.post(Apis.mailURL +
        '/messages/read' +
        '/$type' +
        '/$scoutid_or_applyid' +
        '/$role_id' +
        '/$jobseeker_id');
    return res.data['data'];
  }
}
