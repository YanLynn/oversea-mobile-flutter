import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:borderlessWorking/Widget/sizeConfig.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:path/path.dart' as path;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SendMessageWidget extends StatefulWidget {
  final message;
  final timezone;
  const SendMessageWidget(
      {Key key, @required this.message, @required this.timezone})
      : super(key: key);

  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  var myTimeZone;
  bool loading = false;
  String _progress = "-";
  final _dio = getDio();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = new InitializationSettings(android: android, iOS: iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.high, importance: Importance.max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android: android, iOS: iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        'ダウンロード',
        isSuccess ? 'ファイルをダウンロードしました。' : 'ファイルをダウンロードできませんでした。',
        platform,
        payload: json);
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        loading = true;
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _startDownload(String savePath, String fileUrl) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final getFileName = await _dio.get(fileUrl);
      var fileName = getFileName.data;
      if (getFileName.statusCode == 200) {
        final response = await _dio.download(
            Apis.siteUrl + '/uploads/chat/$fileName', savePath,
            onReceiveProgress: _onReceiveProgress);
        result['isSuccess'] = response.statusCode == 200;
        result['filePath'] = savePath;
      }
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
      Timer(Duration(seconds: 3), () {
        setState(() {
          loading = false;
        });
      });
    }
  }

  downloadFile(id, fileName) async {
    var fileUrl = Apis.mailURL + '/messages/file/$id/download';
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted =
        await _requestPermissions(Permission.storage);
    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, fileName);
      await _startDownload(savePath, fileUrl);
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  String utcToTimezone(value, timezone, {showSecond = false}) {
    if (value == null || timezone == null) {
      return value;
    }

    var detroit = tz.getLocation(this.myTimeZone);

    DateTime date = DateTime.parse(value);
    DateTime utc = DateTime.utc(date.year, date.month, date.day, date.hour,
        date.minute, date.second, 0);
    DateTime v = tz.TZDateTime.from(utc, detroit);

    int m = v.month;
    var month = m < 10 ? '0' + m.toString() : m.toString();
    int d = v.day;
    var day = d < 10 ? '0' + d.toString() : d.toString();
    int h = v.hour;
    var hour = h < 10 ? '0' + h.toString() : h.toString();
    int min = v.minute;
    var minutes = min < 10 ? '0' + min.toString() : min.toString();
    int s = v.second;
    var second = s < 10 ? '0' + s.toString() : s.toString();

    return showSecond
        ? '${v.year}-$month-$day $hour:$minutes:$second'
        : '${v.year}-$month-$day $hour:$minutes';
  }

  String xdate(value, tz) {
    if (value == null || tz == null) {
      return value;
    }
    return utcToTimezone(value, tz);
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    var message = widget.message;
    this.myTimeZone = widget.timezone;
    // message['created_at'] =
    //     utcToTimezone(message['created_at'], this.myTimeZone);

    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message['message_type'] == 'file' &&
                loading &&
                message['expired'] == null)
              Transform(
                  transform: Matrix4.translationValues(
                      SizeConfig.blockSizeHorizontal * 0.2.h,
                      SizeConfig.blockSizeHorizontal * -0.1.h,
                      0.0),
                  child: Text(_progress)),
            if (message['message_type'] == 'file' &&
                !loading &&
                message['expired'] == null)
              Transform(
                transform: Matrix4.translationValues(
                    SizeConfig.blockSizeHorizontal * 0.2.h,
                    SizeConfig.blockSizeHorizontal * -0.1.h,
                    0.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: const Icon(
                    Icons.download,
                    size: 20,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    downloadFile(message['id'], message['message']);
                  },
                ),
              ),
            Align(
              alignment: Alignment.centerRight,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 140,
                ),
                child: Card(
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  color: Color(0xFFC7D5E9),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * .3.h,
                      vertical: SizeConfig.safeBlockVertical * .09.h),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // if (msgType == 'file')
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            child: message['message_type'] == 'file'
                                ? Container(
                                    child: message['expired'] == null
                                        ? Row(
                                            children: [
                                              Icon(
                                                Icons.text_snippet,
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    1.0.h,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                message['message'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              )),
                                            ],
                                          )
                                        : Row(children: [
                                            Icon(
                                              Icons.text_snippet,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1.0.h,
                                              color: Colors.black54,
                                            ),
                                            if (message['message_type'] ==
                                                'file')
                                              Expanded(
                                                  child: Text(
                                                message['message'],
                                                // maxLines: 2,
                                                // overflow: TextOverflow.ellipsis,
                                                // softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black45),
                                              )),
                                          ]))
                                : Text(
                                    message['message'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message['status'] == 1)
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  bottom: 3,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.done,
                      size: 15,
                      color: Colors.green[700],
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                bottom: 3,
              ),
              child: Text(
                xdate(message['created_at'], this.myTimeZone).toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
          ],
        ),
         if (message['message_type'] == 'file' && message['expired'] != null)
        Column(         
            children: [
                Container(
                padding: EdgeInsets.only(right: 10),
                  child: Text(
                'このファイルのダウンロード期間が過ぎました',
                style: TextStyle(fontSize: 12, color: Colors.black45),
              )
              ),
              SizedBox(height: 15,)
            ],
        )
      ],
    );
  }
}
