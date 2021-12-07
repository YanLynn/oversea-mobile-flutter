import 'dart:convert';
import 'dart:io';
// import 'package:borderlessWorking/bloc/carrer_bloc/carrer_bloc.dart';
// import 'dart:math';

import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/basicinfo.dart';
import 'package:borderlessWorking/data/model/basicinfo_lang.dart';
import 'package:borderlessWorking/data/model/career-update.dart';
import 'package:borderlessWorking/data/model/carrer_details.dart';

import 'package:borderlessWorking/data/model/desired_condition.dart';
import 'package:borderlessWorking/data/model/exp_qualification.dart';
// import 'package:borderlessWorking/data/model/education.dart';
// import 'package:borderlessWorking/data/model/employment_type.dart';
import 'package:borderlessWorking/data/model/favouritejobs.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
// import 'package:borderlessWorking/data/model/iso.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/model/jobapplied.dart';
import 'package:borderlessWorking/data/model/jobappliedpage.dart';
import 'package:borderlessWorking/data/model/jobdata.dart';
// import 'package:borderlessWorking/data/model/jobseeker.dart';
import 'package:borderlessWorking/data/model/language.dart';
import 'package:borderlessWorking/data/model/languagelevel.dart';
import 'package:borderlessWorking/data/model/public-search.dart';
// import 'package:borderlessWorking/data/model/position.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:borderlessWorking/data/model/scoutstatus.dart';
import 'package:borderlessWorking/data/model/selfintro_details.dart';
import 'package:borderlessWorking/data/model/timezone.dart';
import 'package:borderlessWorking/data/model/timezonesetting.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'apis.dart';
import 'package:dio/dio.dart';
// import 'package:borderlessWorking/data/model/scoutsetting.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String mainUrl = Apis.mailURL;
  var loginUrl = mainUrl + Apis.login;
  var contactUrl = mainUrl + Apis.contact;
  var carrerUrl = mainUrl + Apis.carrer;
  var getCarrerUrl = mainUrl + Apis.getCarrer;
  var updateCarrerUrl = mainUrl + Apis.updateCarrer;
  var selfIntroUrl = mainUrl + Apis.selfIntro;
  var publicSearch = mainUrl + Apis.publicSearch;
  var foreignLanguageUrl = mainUrl + Apis.foreignlanguage;
  var languageUrl = mainUrl + Apis.language;
  var scoutSettingUrl = mainUrl + Apis.scoutSetting;
  var jobseekerInfoUrl = mainUrl + Apis.jobseekerInfo;
  var jobListURL = mainUrl + Apis.jobSearch;
  var registerUrl = mainUrl + Apis.register;
  var getcountryUrl = mainUrl + Apis.country_list;
  var getcityUrl = mainUrl + Apis.city_list;
  var contactUsUrl = mainUrl + Apis.contactUs;
  var checkPasswordUrl = mainUrl + Apis.checkPassword;
  var changePasswordUrl = mainUrl + Apis.changePassword;
  var favouriteJobUrl = mainUrl + Apis.favouriteJobs;
  var timeZoneListUrl = mainUrl + Apis.timezoneList;
  var userTimeZoneUrl = mainUrl + Apis.userTimeZone;
  var changedTimeZoneUrl = mainUrl + Apis.changedTimeZone;
  var actionScoutUrl = mainUrl + Apis.actionScout;
  var jobdetailsUrl = mainUrl + Apis.job_details;
  var mailunique = mainUrl + Apis.mailunique;
  var jobapply = mainUrl + Apis.jobapplied;
  var jobappliedlist = mainUrl + Apis.jobappliedlist;
  var joblistpage = mainUrl + Apis.jobappliedlistpage;
  var removefavouriteJobUrl = mainUrl + Apis.removefavouriteJobs;
  var searchfavouriteJobUrl = mainUrl + Apis.seachfavouriteJobs;
  var getDesiredConditionUrl = mainUrl + Apis.desiredCondition;
  var scoutdetails = mainUrl + Apis.scoutdetails;
  var updateDesiredConditionUrl = mainUrl + Apis.updateDesiredCondition;
  var updateExpQuaUrl = mainUrl + Apis.updateExpQua;
  var emailupdate = mainUrl + Apis.emailchange;
  var getExpQuaUrl = mainUrl + Apis.expQua;
  var basicinfo = mainUrl + Apis.basicinfo;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  static String addToken = '';

  final _dio = getDio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    var token = await storage.read(key: 'token');
    if (token != null) {
      addToken = token;

      return token;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future persistUserData(Map userData) async {
    final value = json.encode(userData);
    await storage.write(key: 'user', value: value);
  }

  Future<Map> getUserData() async {
    final value = await storage.read(key: 'user');
    return value == null ? null : Map.from(json.decode(value));
  }

  // get user info using HTTP
  // DIO response type error
  Future info() async {
    var token = await this.getToken();
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    try {
      final res = await http.get(mainUrl + '/user-info', headers: headers);
      List resBody = jsonDecode(res.body);
      return resBody[0];
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.delete(key: 'user');
    storage.deleteAll();
  }

  //login
  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    Map<String, dynamic> _dataList = response.data;
    return _dataList;
  }

  //jobList
  Future<List<Job>> getJobLists(int page) async {
    var searchData = {
      "keyword": "",
      "country": [],
      "historyCountry": [],
      "occupation": []
    };

    List<Job> _dataList = [];
    Response response = await _dio
        .get(jobListURL + "?page=${page}&searchData=" + jsonEncode(searchData));
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        for (var item in body['data']) {
          Job data = new Job.fromJson(item);
          _dataList.add(data);
        }
        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //  return ContactModel.withError('asdfasdfasdfasdf');

    }
  }

  // getScoutSetting
  Future<int> getScoutSetting() async {
    Map usr = await this.getUserData();
    Response response =
        await _dio.post(jobseekerInfoUrl, data: {'id': usr["id"]});
    try {
      print("response is : $response");
      if (response.statusCode == 200) {
        var status = response.data['scout_setting_status'];
        return status;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // scout setting
  Future<String> updateScoutSetting(int status) async {
    Response response = await _dio
        .post(scoutSettingUrl, data: {'scout_setting_status': status});
    if (response.statusCode == 200) {
      return response.data;
    }
    return response.data;
  }

  //Register
  Future<Map<String, dynamic>> register(
    String jobseeker_name,
    String jobseeker_furigana_name,
    String dob,
    String country_name,
    String country_id,
    String phone,
    String email,
    String password,
  ) async {
    Response response = await _dio.post(registerUrl, data: {
      "name": jobseeker_name,
      "jobseeker_furigana_name": jobseeker_furigana_name,
      "dob": dob,
      "country_name": country_name,
      "country_id": country_id,
      "phone": phone,
      "email": email,
      "password": password,
    });
    return response.data;
  }
  //Register

  //Getcountry
  Future<List<Getcountry>> getcountry() async {
    List<Getcountry> _countrylist = [];
    Response response = await _dio.get(getcountryUrl);
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        for (var item in body) {
          Getcountry data = new Getcountry.fromJson(item);
          _countrylist.add(data);
        }
        return _countrylist;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
  //Getcountry

  //citylist
  Future<List<Getcity>> getcity(String idProvince) async {
    List<Getcity> _citylist = [];
    Response response = await _dio.get(getcityUrl + '$idProvince');
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        for (var item in body) {
          Getcity data = new Getcity.fromJson(item);
          _citylist.add(data);
        }
        return _citylist;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
  //citylist

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  Future updateSelfIntro(
    String video,
    String selfpr,
    String faceimageprivatestatus,
    bool deletefacimage,
    File faceimage,
    List<String> deleterelatedimages,
    List relatedimages,
  ) async {
    String fileName;
    var image;
    if (faceimage != null) {
      fileName = faceimage.path.split('/').last;
      image = await MultipartFile.fromFile(faceimage.path, filename: fileName);
    }

    FormData formData = FormData.fromMap({
      "video": video,
      "self_pr": selfpr,
      "face_image_private_status": faceimageprivatestatus,
      "delete_fac_image": deletefacimage,
      "face_image": image,
      "related_images": '',
      "delete_related_images": deleterelatedimages,
    });

    Response response = await _dio.post(selfIntroUrl, data: formData);

    if (relatedimages.length != 0) {
      for (var multiFile in relatedimages) {
        FormData formData = FormData.fromMap({
          "related_images": multiFile,
        });
        Response res = await _dio.post(mainUrl + Apis.selfIntroRelateImage,
            data: formData);
      }
    }
    // if (response.statusCode == 200) return "success";
  }

  //getselfintrodetails
  Future<List<SelfIntroDetail>> getSelfIntroDetails() async {
    List<SelfIntroDetail> _dataList = [];
    Response response = await _dio.get(selfIntroUrl);
    var body = (response.data['data']);
    var selfintrodetails = body['selfIntroDetails'];

    if (selfintrodetails['occupation_name'] != null) {
      selfintrodetails['occupation_name'] =
          selfintrodetails['occupation_name'].split(',');
    } else {
      selfintrodetails['occupation_name'] = [];
    }

    var lang = body['language'];
    for (var lan in lang) {
      if (lan['language_level'] != null) {
        var split_arr = lan['language_level'].split(',');
        selfintrodetails['language_level'] = split_arr;
      } else {
        selfintrodetails['language_level'] = [];
      }
    }

    try {
      if (response.statusCode == 200) {
        SelfIntroDetail data = new SelfIntroDetail.fromJson(body);
        _dataList.add(data);

        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // //getselfintrodetails
  // Future<List<JobseekerModel>> getSelfIntroDetails() async {
  //   List<JobseekerModel> _dataList = [];
  //   Response response = await _dio.get(selfIntroUrl);
  //   var body = (response.data['data']);
  //   var selfintrodetails = body['selfIntroDetails'];

  //   if (selfintrodetails['occupation_name'] != null) {
  //     selfintrodetails['occupation_name'] =
  //         selfintrodetails['occupation_name'].split(',');
  //   } else {
  //     selfintrodetails['occupation_name'] = [];
  //   }

  //   var lang = body['language'];
  //   for (var lan in lang) {
  //     if (lan['language_level'] != null) {
  //       var split_arr = lan['language_level'].split(',');
  //       selfintrodetails['language_level'] = split_arr;
  //     } else {
  //       selfintrodetails['language_level'] = [];
  //     }
  //   }

  //   var related_images = body['selfIntro'];

  //   try {
  //     if (response.statusCode == 200) {
  //       JobseekerModel data = new JobseekerModel.fromJson(selfintrodetails);
  //       _dataList.add(data);

  //       return _dataList;
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //   }
  // }

  //getForeignlanguage
  Future<List<LanguageLevel>> getForeignlanguage() async {
    Map usr = await this.getUserData();
    List<LanguageLevel> _dataList = [];
    Response response = await _dio.post(foreignLanguageUrl);
    var language_level = response.data['data']['languages_levels'];

    try {
      if (response.statusCode == 200) {
        for (var lang in language_level) {
          LanguageLevel data = new LanguageLevel.fromJson(lang);
          _dataList.add(data);
        }

        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //getLanguage
  Future<List<Language>> getLanguage() async {
    List<Language> _dataList = [];
    Response response = await _dio.get(languageUrl);
    // var body = (response.data['data']);
    var languages = response.data['data']['languages'];

    try {
      if (response.statusCode == 200) {
        for (var lang in languages) {
          Language data = new Language.fromJson(lang);
          _dataList.add(data);
        }

        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //getcarrerlist
  Future<List<CarrerDetail>> getCarrerList() async {
    List<CarrerDetail> _dataList = [];
    Response response = await _dio.get(getCarrerUrl);
    var body = (response.data['data']);

    _dataList.add(CarrerDetail.fromJson(body));
    return _dataList;
  }

  //getcarrerrequiredlist
  Future<List<CareerModel>> getCarrerRequiredList() async {
    List<CareerModel> _dataList = [];
    Response response = await _dio.get(carrerUrl);
    var body = (response.data['data']);

    _dataList.add(CareerModel.fromJson(body));
    return _dataList;
  }

  //updatecarrer
  Future<String> updateCarrer(
      Object educations, Object experiences, Object carrers) async {
    Response response = await _dio.post(updateCarrerUrl, data: {
      'educations': educations,
      'experiences': experiences,
      'carrers': carrers,
    });

    if (response.statusCode == 200) return "success";
  }

  //position
  // Future<List<Position>> GetPositon() async {
  //   List<Position> _dataList = [];
  //   var token = await this.getToken();
  //   _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
  //   Response response = await _dio.get(carrerUrl);

  //   var body = (response.data['data']);
  //   var positions = body['positions'];

  //   try {
  //     if (response.statusCode == 200) {
  //       for (var item in positions) {
  //         Position data = new Position.fromJson(item);
  //         _dataList.add(data);
  //       }
  //       return _dataList;
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //   }
  // }

  // //isoList
  // Future<List<String>> GetIsoList() async {
  //   List<String> _isolist = [];
  //   var token = await this.getToken();
  //   _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
  //   Response response = await _dio.get(carrerUrl);
  //   var body = (response.data['data']);
  //   var list = body['iso_list'];
  //   for (var item in list) {
  //     _isolist.add(item);
  //   }

  //   return _isolist;
  // }

  // //employment_type
  // Future<List<EmploymentType>> GetEmployment() async {
  //   List<EmploymentType> _dataList = [];
  //   var token = await this.getToken();
  //   _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
  //   Response response = await _dio.get(carrerUrl);
  //   var body = (response.data['data']);
  //   var positions = body['employment_types'];

  //   try {
  //     if (response.statusCode == 200) {
  //       for (var item in positions) {
  //         EmploymentType data = new EmploymentType.fromJson(item);
  //         _dataList.add(data);
  //       }
  //       return _dataList;
  //     }
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //   }
  // }

  //publicSearch
  Future<List<PublicSearch>> getJobseekerInit() async {
    List<PublicSearch> _dataList = [];
    Response response = await _dio.get(publicSearch);
    var body = (response.data);

    for (int i = 0; i < response.data['country'].length; i++) {
      response.data['country'][i]['completed'] = false;
    }

    for (int i = 0; i < response.data['popular_country'].length; i++) {
      response.data['popular_country'][i]['completed'] = false;
    }

    for (int i = 0; i < response.data['continent'].length; i++) {
      response.data['continent'][i]['completed'] = false;
    }

    for (int i = 0; i < response.data['occupation'].length; i++) {
      response.data['occupation'][i]['completed'] = false;
    }

    _dataList.add(PublicSearch.fromJson(body));
    return _dataList;
  }

  var searchData;
  Future<List<Job>> getJobs(page, searchData) async {
    searchData = searchData;
    List<Job> _dataList = [];
    Response response = await _dio
        .get(jobListURL + "?page=${page}&searchData=" + jsonEncode(searchData));
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        for (var item in body['data']) {
          Job data = new Job.fromJson(item);
          _dataList.add(data);
        }
        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future addAndRemoveFavJob(int jobId, String type) async {
    Response response = await _dio
        .get(mainUrl + '/jobseeker/job-favourite/' + '$jobId' + '/' + '$type');
    return response.data;
  }

  //publicSearch

  //Contact Us Form
  Future<String> contactus(
      String corporateName,
      String name,
      String furiganaName,
      String email,
      String confirmEmail,
      String inquiryDetails,
      bool policy) async {
    final response = await _dio.post(contactUsUrl, data: {
      "corporate_name": corporateName,
      "name": name,
      "furigana_name": furiganaName,
      "email": email,
      "confirm_mail": confirmEmail,
      "inquiry_details": inquiryDetails,
      "policy": policy
    });
    return response.data;
  }

  //forgetPassword
  // $request->routeName == 'jobseeker-forgot-password'
  Future<String> forgetPassword(String email, String routeName) async {
    routeName = 'jobseeker-forgot-password';
    Response response = await _dio.post(mainUrl + Apis.forgetPassword, data: {
      "email": email,
      "routeName": routeName,
    });

    return response.data['success'];
  }

// deactivate
  Future<Map<String, dynamic>> deactivate(String password) async {
    Map usr = await this.getUserData();
    Response res = await _dio.post(mainUrl + Apis.passwordCheck,
        data: {'email': usr['email'], 'password': password});
    try {
      if (res.statusCode == 200) {
        final deactivate =
            await _dio.post(mainUrl + Apis.deactivate, data: {'id': usr['id']});
        return deactivate.data['data'];
      }
      return res.data;
    } catch (e) {
      return (e);
    }
  }

  // Password setting
  Future<String> checkPassword(String password) async {
    Map usr = await this.getUserData();
    Response response = await _dio.post(mainUrl + Apis.passwordCheck,
        data: {'email': usr['email'], 'password': password});

    // Response response =
    // await _dio.post(checkPasswordUrl, data: {"password": password});

    try {
      if (response.statusCode == 200) {
        return "authenticated";
      }
    } catch (error) {
      var err = error.data.error.message;
      return (err);
    }
  }

  Future<String> changePassword(String password) async {
    Response response =
        await _dio.post(changePasswordUrl, data: {"password": password});

    try {
      if (response.statusCode == 200) {
        return "パスワードが変更されました。";
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<TimeZoneModel>> getTimeZoneList() async {
    List<TimeZoneModel> _timezoneList = [];
    Response response = await _dio.get(timeZoneListUrl);
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        print("$body");
        for (var item in body['get_timezone']) {
          TimeZoneModel data = new TimeZoneModel.fromJson(item);
          _timezoneList.add(data);
        }
        return _timezoneList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // get user time zone
  Future<List<TimeZoneSettingModel>> getUserTimeZone() async {
    List<TimeZoneSettingModel> _usertimezone = [];
    Response response = await _dio.get(userTimeZoneUrl);
    var body = (response.data["user_timezone"]);
    if (body == null) {
      body = {"timezone": "Asia/Tokyo", "offset": "+9:00"};
    }
    try {
      if (response.statusCode == 200) {
        TimeZoneSettingModel data = new TimeZoneSettingModel.fromJson(body);
        _usertimezone.add(data);
        return _usertimezone;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // get user time zone
  Future<List<TimeZoneSettingModel>> changedTimeZone(
      String changedTimezone, String changedOffset) async {
    List<TimeZoneSettingModel> _changedTimezone = [];
    var splitarray = changedOffset.split(" ");
    Response response = await _dio.post(changedTimeZoneUrl,
        data: {"timezone": changedTimezone, "offset": splitarray[1]});
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        TimeZoneSettingModel data = new TimeZoneSettingModel.fromJson(body);
        _changedTimezone.add(data);
        print(_changedTimezone);
        return _changedTimezone;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // Scouted List
  Future<List<Scout>> getScoutedList(int page) async {
    Map usr = await this.getUserData();
    int userId = usr["id"];
    List<Scout> _scoutedList = [];
    Response response =
        await _dio.get(mainUrl + '/jobseeker/$userId/scouts?page=$page');
    var body = response.data;
    print("body $body");
    print(body["total"]);
    try {
      if (response.statusCode == 200) {
        for (var item in body['data']) {
          Scout data = new Scout.fromJson(item);
          _scoutedList.add(data);
        }
        return _scoutedList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // Scouted List total and unread (new api call bcz forget in scout model)
  Future<List> getScoutedListTotal() async {
    Map usr = await this.getUserData();
    int userId = usr["id"];
    List _data = [
      {"total": 0, "unread_count": 0}
    ];
    Response response =
        await _dio.get(mainUrl + '/jobseeker/$userId/scouts?page=1');
    var body = response.data;
    print("body $body");
    try {
      if (response.statusCode == 200) {
        _data[0]["total"] = body["total"];
        _data[0]["unread_count"] = body["unread_count"];
        return _data;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // Delete Scout
  Future<List<Scout>> actionScout(scoutId, madeAction, int page) async {
    List<Scout> _changeScout = [];

    Response response = await _dio
        .post(actionScoutUrl, data: {"scoutId": scoutId, "action": madeAction});
    // var body = response.data;
    print("response $response");
    try {
      if (response.statusCode == 200) {
        _changeScout = await this.getScoutedList(page);

        return _changeScout;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //jobDetail
  Future<JobDataModel> getJobData(jobID) async {
    Response response = await _dio.get(jobdetailsUrl + '$jobID');
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        return JobDataModel.fromJson(body);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //mailunique
  Future<String> mailcheck1(String email) async {
    try {
      var params = {
        "email": email,
      };
      Response response = await _dio.post(
        mailunique,
        data: params,
      );
      print(response.data);
      if (response.statusCode == HttpStatus.ok) {
        print("200");
        return null;
      }
    } catch (error, stacktrace) {
      print("not 200");
      //print("Exception occured: $error stackTrace: $stacktrace");
      return "mail exit";
    }
  }

  //jobapplied
  Future<String> jobapplied(jobID) async {
    Response response = await _dio.post(jobapply + '$jobID');
    return response.data;
  }

  //job_applied_status
  Future<List<Jobapply>> getjobappliedlist(jobID) async {
    List<Jobapply> _test = [];
    Response response = await _dio.get(jobappliedlist + '$jobID');
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        // return Scoutstatus.fromJson(body);
        for (var item in body['jobapplied']) {
          Jobapply data = new Jobapply.fromJson(item);
          _test.add(data);
        }
        return _test;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //scout_status
  Future<List<Scoutstatus>> getscoutstatus(jobID) async {
    List<Scoutstatus> _scout = [];
    Response response = await _dio.get(jobappliedlist + '$jobID');
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        // return Scoutstatus.fromJson(body);
        for (var item in body['scout']) {
          Scoutstatus data = new Scoutstatus.fromJson(item);
          _scout.add(data);
        }
        return _scout;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //jobappliedpages
  Future<List<Jobappliedpage>> getjobappliedpage(int page) async {
    List<Jobappliedpage> _joblist = [];
    Response response = await _dio.get(joblistpage + '?page=${page}');
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        for (var item in body) {
          Jobappliedpage data = new Jobappliedpage.fromJson(item);
          _joblist.add(data);
          // print(_joblist);
        }
        return _joblist;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //change_status
  Future<List<Jobappliedpage>> getchangestatus(applyid, int page) async {
    List<Jobappliedpage> _jobliststatus = [];
    Response response = await _dio.get(mainUrl +
        '/jobseeker/apply-changes-status/$applyid/status?page=${page}');
    var body = (response.data);
    try {
      if (response.statusCode == 200) {
        for (var item in body) {
          Jobappliedpage data = new Jobappliedpage.fromJson(item);
          _jobliststatus.add(data);
          // print(_jobliststatus);
        }
        return _jobliststatus;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //favourite job lists
  Future<List<FavouritejobsModel>> getfavouritejobs() async {
    List<FavouritejobsModel> _dataList = [];
    Response response = await _dio.post(favouriteJobUrl);

    var items = (response.data['favourite_job_list']);
    for (var i = 0; i < items.length; i++) {
      if (items[i]['other_keywords'] == null ||
          items[i]['other_keywords'] == "") {
        items[i]['other_keywords'] = [];
      }
    }

    try {
      if (response.statusCode == 200) {
        for (var item in items) {
          FavouritejobsModel data = new FavouritejobsModel.fromJson(item);
          _dataList.add(data);
        }
        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //Delete favourite jobs list
  Future<FavouritejobsModel> removefavouritejobs(int id) async {
    Response response = await _dio
        .post(mainUrl + '/jobseeker/favourite-job/' + '$id' + '/remove');
    print(response);
    try {
      if (response.statusCode == 200) {
        getfavouritejobs();
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  // Desired Condition
  Future<List<DesiredCondition>> getDesiredCondition() async {
    List<DesiredCondition> _dataList = [];
    Response response = await _dio.get(getDesiredConditionUrl);
    var body = (response.data);

    _dataList.add(DesiredCondition.fromJson(body));
    return _dataList;
  }

  Future<String> updateDesiredCondition(
      Object desiredCondition, Object industries, Object occupations) async {
    Response response = await _dio.post(updateDesiredConditionUrl, data: {
      "desired_condition": desiredCondition,
      "industries": industries,
      "occupations": occupations,
    });

    if (response.statusCode == 200) return "success";

    return "some error";
  }

  // Exp Qualification
  Future<List<ExpQualification>> getExpQualification() async {
    List<ExpQualification> _dataList = [];
    Response response = await _dio.post(getExpQuaUrl);
    var body = (response.data);

    _dataList.add(ExpQualification.fromJson(body["data"]));

    return _dataList;
  }

  Future<String> updateExpQualification(
      Object industryHistory,
      Object deleteIndustryHistoryId,
      Object studyAbroad,
      Object deleteStudyAbroad,
      Object workingAbroad,
      Object deleteWorkingAbroad,
      List workVisa,
      Object langLevel,
      Object deleteLangLevel,
      List otherQua) async {
    Response response = await _dio.post(updateExpQuaUrl, data: {
      "experienced_jobs": industryHistory,
      "delete_experience_jobs": deleteIndustryHistoryId,
      "study_abroad_experiences": studyAbroad,
      "delete_study_abroad": deleteStudyAbroad,
      "working_abroad_experiences": workingAbroad,
      "delete_working_abroad": deleteWorkingAbroad,
      "work_visa": workVisa[0],
      "foreign_language_experiences": langLevel,
      "delete_foreign_languages_experiences": deleteLangLevel,
      "other_qualifications": otherQua[0]
    });

    if (response.statusCode == 200) return "success";

    return "some error";
  }

  //scoutdetails
  Future<List<Scout>> getscoutdetails(scoutid) async {
    List<Scout> _scoutdetails = [];
    Response response = await _dio.get(scoutdetails + '$scoutid');
    var body = (response.data['data']);
    try {
      if (response.statusCode == 200) {
        Scout data = new Scout.fromJson(body);
        _scoutdetails.add(data);

        return _scoutdetails;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //emailupdate
  Future<String> emailchange(String email) async {
    Response response = await _dio.post(emailupdate, data: {"email": email});
    try {
      if (response.statusCode == 200) {
        return "success";
      } else if (response.statusCode == 500) {
        print('not success');
        return "not success";
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  //getbasicinfo
  Future<List<Basicinfo>> getbasicinfo() async {
    List<Basicinfo> _dataList = [];
    Response response = await _dio.get(basicinfo);
    var body = (response.data['data']);
    var profile = body['profile'];

    try {
      if (response.statusCode == 200) {
        Basicinfo data = new Basicinfo.fromJson(profile);
        _dataList.add(data);
        print(data);

        return _dataList;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //  return ContactModel.withError('asdfasdfasdfasdf');

    }
  }

  //langlistbsinfo
  Future<List<Infolang>> getlanglist() async {
    List<Infolang> _lang = [];
    Response response = await _dio.get(basicinfo);
    var body = (response.data['data']);
    // var profile = body['profile'];
    var langlist = body['languages'];
    try {
      if (response.statusCode == 200) {
        for (var item in langlist) {
          Infolang data = new Infolang.fromJson(item);
          _lang.add(data);
        }
        return _lang;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //  return ContactModel.withError('asdfasdfasdfasdf');

    }
  }

  //countrylistbsinfo
  //updatebasicinfo
  Future<Map<String, dynamic>> updatebasicinfo(
    String jobseeker_name,
    String jobseeker_furigana_name,
    String jobseeker_furigana_name_status,
    String gender,
    String gender_status,
    String dob,
    String dob_status,
    String current_address_status,
    String address,
    String phone,
    String email,
    String skype_account,
    String final_education,
    String current_situation,
    String city_name,
    String country_name,
    String language_id,
  ) async {
    Response response = await _dio.post(basicinfo, data: {
      "jobseeker_name": jobseeker_name,
      "jobseeker_furigana_name": jobseeker_furigana_name,
      "jobseeker_furigana_name_status": jobseeker_furigana_name_status,
      "gender": gender,
      "gender_status": gender_status,
      "dob": dob,
      "dob_status": dob_status,
      "current_address_status": current_address_status,
      "address": address,
      "phone": phone,
      "email": email,
      "skype_account": skype_account,
      "final_education": final_education,
      "current_situation": current_situation,
      "city_name": city_name,
      "country_name": country_name,
      "language_id": language_id,
    });
    return response.data;
  }
  //updatebasicinfo

  //get all fav count
  Future getAllFavCount() async {
    //    var token = await this.getToken();
    //   final headers = {
    //     HttpHeaders.contentTypeHeader: 'application/json',
    //     HttpHeaders.authorizationHeader: 'Bearer $token',
    //   };
    //   try {
    //     final res = await http.get(mainUrl + Apis.jobseekerFavCount, headers: headers);
    //     List resBody = jsonDecode(res.body);
    //     return resBody[0];
    //   } catch (e) {
    //     print(e);
    //   }
    // }
    var token = await this.getToken();
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer ' + token;
    int count = 0;
    try {
      Response res = await _dio.get(mainUrl + Apis.jobseekerFavCount);
      count = res.data;
      return count;
    } catch (e) {
      print(e);
    }
  }
}
