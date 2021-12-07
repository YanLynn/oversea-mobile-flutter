import 'package:borderlessWorking/data/model/chat/chatUserList.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Apis with ChangeNotifier {
  // chatting
  static IO.Socket socket = IO.io(
      // "https://test.borderless-working.jp:4005",
      "https://testoverseas-jobs.management-partners.co.jp:4001",
      <String, dynamic>{
        "transports": ["websocket", 'polling'],
        "autoConnect": false,
        "secure": true,
        "reconnect": true,
        "rejectUnauthorized": false,
      });

  static ValueNotifier<List> onlineUsers = ValueNotifier([]);
  static String profileImg;
  static String userName;
  static List<dynamic> occupationList = [];
  static List<dynamic> countryList = [];
  static String token = '';
  static Map userData = <String, dynamic>{};
  static var favCount;
  static String loginPageType = 'home';
  static ValueNotifier<int> notiCountforHomeIcon = ValueNotifier(0);
  static List<ChatUserList> userList = [];
  // constructor
  Apis() {
    socket.connect();
    print("socket connect => ${socket.connected}");

    socket.on(
        "logout-user",
        (data) => {
              if (userData.isNotEmpty)
                {
                  onlineUsers.value
                      .removeWhere((element) => element == userData["id"]),
                  // onlineUsers.removeAt(Apis.onlineUsers.indexOf(userData["id"]))
                  print("disconnect ${onlineUsers.value}"),
                  socket.emit('usernames', onlineUsers.value),
                  socket.disconnect(),
                  // _updateOnlineUsers(),
                }
              else
                {
                  // _updateOnlineUsers(),
                  socket.emit('usernames', onlineUsers.value),
                  socket.disconnect(),
                }
            });

    socket.on(
        'join',
        (data) => {
              print("join"),
              if (onlineUsers.value.indexOf(data) != -1)
                {
                  _updateOnlineUsers(),
                }
              else
                {
                  onlineUsers.value.add(data),
                  _updateOnlineUsers(),
                },
              print(data),
            });

    socket.on(
        "usernames",
        (data) => {
              onlineUsers.value = data,
              print("online user value"),
              print(onlineUsers.value),
            });
  }

  // add or remove active user
  _updateOnlineUsers() {
    socket.emit('usernames', onlineUsers.value);
  }

  static ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  // static const mailURL = "https://test.borderless-working.jp/api/v1";
  static const mailURL = "https://testoverseas-jobs.management-partners.co.jp/api/v1";
  // static const mailURL = "http://192.168.8.104:9000/api/v1";
  static const siteUrl = 'https://testoverseas-jobs.management-partners.co.jp';
  static const login = '/auth/jobseeker/login';
  static const contact = '/contact_list';
  static const carrer = '/jobseeker/required-list';
  static const updateCarrer = '/jobseeker/profile/carrer';
  static const getCarrer = '/jobseeker/profile/carrerinfo';
  static const publicSearch = '/country_occupation_list/jobseeker';
  static const scoutSetting = '/jobseeker/scout-setting/update';
  static const jobseekerInfo = '/jobseeker/info';
  static const jobSearch = '/jobseeker-search/scroll';
  static const register = '/jobseeker/register';
  static const country_list = '/jobseeker/country-list';
  static const city_list = '/jobseeker/city-list/';
  static const selfIntro = '/jobseeker/profile/selfintro';
  static const selfIntroRelateImage = '/jobseeker/profile/selfintroRelateImage';
  static const foreignlanguage =
      '/jobseeker/profile/experiences-qualifications';
  static const language = '/jobseeker/profile/basicinfo';
  static const contactUs = '/query';
  static const forgetPassword = '/auth/forgot-password';
  static const checkPassword = '/jobseeker/password-check';
  static const changePassword = '/jobseeker/password-change';
  static const deactivate = '/jobseeker/deactivate';
  static const favouriteJobs = '/jobseeker/favourite-jobs';
  static const timezoneList = '/time-zone-list';
  static const userTimeZone = '/user-time-zone';
  static const changedTimeZone = '/time-zone';
  static const actionScout = '/jobseeker/scouts/make-action';
  static const job_details = '/jobs/';
  static const mailunique = '/jobseeker/mail-unity';
  static const jobapplied = '/jobseeker/job-applied/';
  static const jobappliedlist = '/jobseeker/jopappliedlist/';
  static const jobappliedlistpage = '/jobseeker/applied-list';
  static const removefavouriteJobs = '/jobseeker/favourite-job/{job_id}/remove';
  static const seachfavouriteJobs =
      '/jobseeker/favourite-jobs?page=search&search_word=&search_status=1';
  static const passwordCheck = '/check-password';
  static const desiredCondition = '/jobseeker/profile/desired-condition';
  static const scoutdetails = '/jobseeker/scouts/';
  static const updateDesiredCondition = '/jobseeker/profile/desired-condition';
  static const updateExpQua =
      '/jobseeker/profile/experiences-qualifications/update';
  static const emailchange = '/change-email';
  static const basicinfo = "/jobseeker/profile/basicinfo";
  static const expQua = '/jobseeker/profile/experiences-qualifications';
  static const jobseekerFavCount = '/jobseeker-fav-count';
}

// Dio getDio() {
//   Dio dio = Dio();
//   dio.transformer = FlutterTransformer();
//   dio.options.headers["content-type"] = "application/json";
//   dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer " + Apis.token;
//   dio.interceptors
//       .addAll([LogInterceptor(requestBody: true, responseBody: true)]);
//   dio.interceptors
//       .add(DioCacheManager(CacheConfig(baseUrl: Apis.mailURL)).interceptor);
//   return dio;
// }

getDio() {
  Dio dio = Dio(BaseOptions(
    followRedirects: false,
    // validateStatus: (status) => true, // debug error fase
    baseUrl: Apis.mailURL,
    headers: getHeaders(),
  ));
  dio.interceptors
      .addAll([LogInterceptor(requestBody: true, responseBody: true)]);
  return dio;
}

getHeaders() {
  return {
    'Accept': 'application/json, text/plain, */*',
    // 'Content-Type': 'application/json;charset=UTF-8',
    'Connection': 'keep-alive',
    'content-type': 'application/json, image/*',
    'Charset': 'utf-8',
    'Authorization': "Bearer " + Apis.token,
    'User-Aagent': "4.1.0;android;6.0.1;default;A001",
    "HZUID": "2",
  };
}
