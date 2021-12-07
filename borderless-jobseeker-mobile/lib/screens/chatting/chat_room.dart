import 'dart:async';
import 'dart:math';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/register/register.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:borderlessWorking/Widget/sizeConfig.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/data/repositories/chatting_repositories.dart';
import 'package:borderlessWorking/screens/chatting/SendedMessageWidget.dart';
import 'package:borderlessWorking/screens/chatting/ReceivedMessageWidget.dart';
import 'package:borderlessWorking/screens/chatting/TypingIndicator.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ChatRoom extends StatefulWidget {
  final chatUserData;

  const ChatRoom({
    Key key,
    @required this.chatUserData,
  }) : super(key: key);

  // @override
  // _ChatRoomState createState() => _ChatRoomState();
  @override
  State<StatefulWidget> createState() {
    return _ChatRoomState();
  }
}

class _ChatRoomState extends State<ChatRoom> {
  FocusNode focusNode = FocusNode();

  ChatRepositories chatRepositories = ChatRepositories();
  AuthRepository authRepository = AuthRepository();
  TextEditingController _text = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var myTimeZone = null;
  bool show = false;
  bool typing = false;
  bool checkFile = false;
  String username = '';
  String title = '';
  String number = '';
  int currentUserRoleID = 0;
  List messages = [];
  Map getMe;
  Map getCurrentUser;
  int page = 1;
  var ro_status = ['入金確認済', '入金確認済', '不採用/辞退', '辞退/不採用'];
  var hidden_status = ['不採用/辞退', '辞退/不採用'];
  bool readOnly = false;
  List offlineUsers = [];
  Map meta;
  var detroit;
  DateTime date;

  var messagePayLoad = {
    'recruiter_id': 0,
    'jobseeker_id': 0,
    'speaker_id': 0,
    'speaker_role_id': 0,
    'scoutid_or_applyid': 0,
    'type': '',
    'message': '',
    'created_at': DateTime.now(),
    'message_type': 'text',
    'file_expired': false,
    'file': null,
  };

  socketEmitListener() async {
    Apis.socket.on(
        'channel-chat',
        (data) => {
              if (receiver(data))
                {
                  if (mounted)
                    {
                      setState(() {
                        if (data['message_type'] == 'file') {
                          data['message'] = substring(data['message']);
                        }
                        this.messages.add(data);
                        markAsReads();
                        scrollToBottomMessageWithAnimate();
                      })
                    }
                }
            });

    Apis.socket.on(
        'usertyping',
        (data) => {
              if (receiver(data))
                {
                  if (mounted)
                    {
                      setState(() {
                        typing = true;
                        Timer(Duration(seconds: 3), () {
                          setState(() {
                            typing = false;
                          });
                        });
                      })
                    }
                }
            });
    Apis.socket.on(
        "status-changed",
        (data) => {
              // this.getUsers();
              if (data.scoutid_or_applyid ==
                      this.messagePayLoad['scoutid_or_applyid'] &&
                  data.type == this.messagePayLoad['type'])
                {
                  // --Read only when status is payment_confirmed

                  if (this.ro_status.contains(data.status))
                    {this.readOnly = true, scrollToBottomMessage()}
                  else
                    {this.readOnly = false},

                  if (this.hidden_status.contains(data.status))
                    {
                      // this.resetChatMessage(data);
                    }
                }
            });
    Apis.socket.on(
        "message-been-read",
        (data) => {
              if (mounted)
                {
                  if (this.messagePayLoad['scoutid_or_applyid'] ==
                          data['scoutid_or_applyid'] &&
                      this.messagePayLoad['type'] == data['type'])
                    {
                      for (var i = 0; i < this.messages.length; i++)
                        {
                          if (data['message_ids']
                              .contains(this.messages[i]['id']))
                            {
                              setState(() {
                                this.messages[i]['status'] = 1;
                                this.messages[i]['read_time'] =
                                    data['read_time_utc'];
                              })
                            }
                        }
                    }
                }
            });
  }

  //user typing emit send to web
  _typingEmit(text) {
    if (text != null) {
      Apis.socket.emit('typing', {
        'speaker_role_id': this.messagePayLoad['speaker_role_id'],
        'jobseeker_id': this.messagePayLoad['jobseeker_id'],
        'recruiter_id': this.messagePayLoad['recruiter_id'],
        'scoutid_or_applyid': this.messagePayLoad['scoutid_or_applyid'],
        'type': this.messagePayLoad['type'],
      });
    }
  }

  //check receiver user
  bool receiver(socketPalyload) {
    if (socketPalyload['speaker_role_id'] != this.currentUserRoleID) {
      if (this.currentUserRoleID == 3) {
        if (this.getMe['id'] == socketPalyload['jobseeker_id'] &&
            this.messagePayLoad['scoutid_or_applyid'] ==
                socketPalyload['scoutid_or_applyid'] &&
            this.messagePayLoad['type'] == socketPalyload['type']) {
          return true;
        }
      }
    }
    return false;
  }

  markAsReads() async {
    try {
      final jobSeekerID = this.messages[0]['recruiter_id'];
      final data = await chatRepositories.makeAsRead(
          this.messagePayLoad['type'],
          this.messagePayLoad['scoutid_or_applyid'],
          this.currentUserRoleID,
          jobSeekerID);

      var messageIds = data['message_ids'];
      var readTime = data['read_time'];
      var readTimeUtc = data['read_time_utc'];
      setState(() {
        Apis.notiCountforHomeIcon.value = 0;
      });
      Apis.socket.emit("message-read", {
        'scoutid_or_applyid': this.messagePayLoad['scoutid_or_applyid'],
        'type': this.messagePayLoad['type'],
        'message_ids': messageIds,
        'read_time': readTime,
        'read_time_utc': readTimeUtc,
      });
    } catch (e) {
      print(e);
    }
  }

  //get load more message using pull-to-refresh
  _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    this.page++;
    final getMsgLoadPage =
        await chatRepositories.getMessages(widget.chatUserData, this.page);
    List getLoadMsg = getMsgLoadPage[0].data['data'];
    getLoadMsg.sort((a, b) {
      var adate = a['created_at'];
      var bdate = b['created_at'];
      //null error
      if (adate == null || bdate == null) {
        adate = DateTime.utc(2000);
        bdate = DateTime.utc(2000);
      }
      return bdate.compareTo(adate);
    });
    //reverse
    if (getLoadMsg.length != 0) {
      for (var i = 0; i < getLoadMsg.length; i++) {
        setState(() {
          this.messages.insert(0, getLoadMsg[i]);
        });
      }
    }
    _refreshController.refreshCompleted();
  }

  substring(message) {
    String str = message;
    int len = str.length;
    if (len > 14) {
      return message.substring(14);
    } else {
      return message;
    }
  }

  forLoading() async {
    final data = await chatRepositories.getMessages(widget.chatUserData, 1);
    return data;
  }

  getMsg() async {
    //getMessageAndChatUserInfo
    final data = await chatRepositories.getMessages(widget.chatUserData, 1);
    getMe = await chatRepositories.me();
    if (getMe['extra'].length == 0) {
      this.myTimeZone = 'Asia/Tokyo';
    } else {
      if (getMe['extra']['timezone'] == 'Asia/Yangon') {
        this.myTimeZone = 'Asia/Rangoon';
      } else {
        this.myTimeZone = getMe['extra']['timezone'];
      }
    }

    Map getCurrentUser = await authRepository.getUserData();
    currentUserRoleID = getCurrentUser['role_id'];
    //get message
    //add message
    if (mounted) {
      setState(() {
        var msgData = data[0].data['data'];
        msgData.forEach((data) => {
              if (data['message_type'] == 'file')
                {data['message'] = substring(data['message'])}
            });

        this.messages = msgData;
        var ro_status = [
          '入金確認済',
          '入金確認済',
        ];

        // widget.chatUserData.status = '入金確認済';
        this.readOnly = ro_status.contains(widget.chatUserData.status);
      });
    }
    scrollToBottomMessage();
    //sort msg
    sortMsg();

    //set formData
    this.messagePayLoad['recruiter_id'] = widget.chatUserData.recruiter_id;
    this.messagePayLoad['jobseeker_id'] = widget.chatUserData.jobseeker_id;
    this.messagePayLoad['scoutid_or_applyid'] =
        widget.chatUserData.scoutid_or_applyid;
    this.messagePayLoad['type'] = widget.chatUserData.type;
    this.messagePayLoad['speaker_role_id'] = this.currentUserRoleID;
    this.messagePayLoad['speaker_id'] = getMe['id'];
    //recruiter appBar info
    meta = data[1].data['data'];
    final job = meta['job'];
    final jobseeker = meta['jobseeker'];
    final recruiter = meta['recruiter'];
    final admin = meta['admin'];
    // set appBar userInfo
    //set appBar info
    username = recruiter['recruiter_name'].toString();
    title = job['title'].toString();
    number = job['management_number'].toString();
    markAsReads();
    return null;
  }

  formatBytes(int bytes) {
    if (bytes <= 0) return 0;
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)));
  }

  finleInput() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    final ext = result.files[0].extension;
    final fileSize = formatBytes(result.files[0].size);
    final allowedExt = [
      'html',
      'htm',
      'css',
      'js',
      'jpeg',
      'jpg',
      'png',
      'gif',
      'tiff',
      'bmp',
      'avi',
      'wmv',
      'mpg',
      'mov',
      'swf',
      'mp4',
      'mp3',
      'pdf',
      'txt',
      'docx',
      'xlsx',
      'pptx',
      'zip',
      'csv',
      'doc',
      'xls',
      'ppt',
      'txt',
      'xml',
      'rar',
      'gz',
      'flv',
      'pps',
      'xlr',
      'odt',
      'mkv',
      'tar',
      'log',
      'dat',
    ];
    if (result != null) {
      // && fileSize < 51
      if (allowedExt.contains(ext)) {
        var image = await MultipartFile.fromFile(result.files[0].path,
            filename: result.files[0].name);
        this.messagePayLoad['file'] = image;
        // this.messagePayLoad['message'] = image.filename;
        this.messagePayLoad['message_type'] = 'file';
        _text.clear();
        _text.text = image.filename;
      } else {
        return false;
      }
    }
  }

  sortMsg() {
    this.messages.sort((a, b) {
      var adate = a['created_at'];
      var bdate = b['created_at'];
      //null error
      if (adate == null || bdate == null) {
        adate = DateTime.utc(2000);
        bdate = DateTime.utc(2000);
      }
      return adate.compareTo(bdate);
    });
  }

  sendMsg() async {
    //check file
    // // this.detroit = tz.getLocation(this.myTimeZone);
    // this.date = tz.TZDateTime.from(DateTime.now(), detroit);
    // this.date = DateTime.now();

    if (_text.text != "") {
      this.messagePayLoad['message'] = _text.text;
      this.messagePayLoad['created_at'] = DateTime.now();

      final message = await chatRepositories.sendMessage(this.messagePayLoad);
      if (message['message_type'] == 'file') {
        message['message'] = substring(message['message']);
      }
      final addMessages = {
        "id": message['id'],
        "recruiter_id": this.messagePayLoad['recruiter_id'],
        "jobseeker_id": this.messagePayLoad['jobseeker_id'],
        "speaker_id": this.messagePayLoad['speaker_id'],
        "speaker_role_id": this.messagePayLoad['speaker_role_id'],
        "scoutid_or_applyid": this.messagePayLoad['scoutid_or_applyid'],
        "type": this.messagePayLoad['type'],
        "message": message['message'],
        "message_type": this.messagePayLoad['message_type'],
        "created_at": message['created_at_utc'],
        "last_chat_time": message['created_at_utc'],
        "status": 0,
        "read_time": null,
      };
      setState(() {
        this.messages.add(addMessages);
      });
      Apis.socket.emit("chat-message", addMessages);
      this.messagePayLoad['file'] = null;
      this.messagePayLoad['message_type'] = 'text';
      this.messagePayLoad['message'] = '';

      scrollToBottomMessageWithAnimate();

      if (this.messagePayLoad['speaker_role_id'] == 3) {
        // mobile app only jobseeker
        if (!Apis.onlineUsers.value
            .contains(this.meta['recruiter']['user_id'])) {
          offlineUsers.add({
            "message_id": message['id'],
            "from": this.meta["jobseeker"]["jobseeker_name"],
            "to": this.meta["recruiter"]["email"],
            "to_name": this.meta["recruiter"]["recruiter_name"],
            "date": "2021-08-08 04:40:00",
            "number": this.number,
            "title": this.title,
            "jobseeker_email": this.meta["jobseeker"]["email"],
            "recruiter_email": this.meta["recruiter"]["email"],
            "receiver_role_id": 2,
          });
        }
        if (!Apis.onlineUsers.value.contains(this.meta["admin"]["id"])) {
          offlineUsers.add({
            "message_id": message['id'],
            "from": this.meta["jobseeker"]["jobseeker_name"],
            "to": this.meta["admin"]["email"],
            "to_name": '運営管理者',
            "date": "2021-08-08 04:40:00",
            "number": this.number,
            "title": this.title,
            "jobseeker_email": this.meta["jobseeker"]["email"],
            "recruiter_email": this.meta["recruiter"]["email"],
            "receiver_role_id": 1,
          });
        }

        if (message['id'] > 0) {
          offlineUsers.forEach((element) {
            chatRepositories.sendMail(element);
          });
        }
      }
    } else {
      return false;
    }
  }

  scrollToBottomMessage() {
    setState(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  scrollToBottomMessageWithAnimate() {
    setState(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Apis.socket.connect();
    getMsg();
    socketEmitListener();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Style.CustomColor.mainColor,
              // leadingWidth: SizeConfig.safeBlockVertical * 0.6.h,
              // titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: SizeConfig.blockSizeHorizontal * 0.7.h,
                    ),
                  ],
                ),
              ),
              title: Transform(
                transform: Matrix4.translationValues(
                    SizeConfig.safeBlockHorizontal * -0.0.h,
                    SizeConfig.blockSizeHorizontal * 0.0.h,
                    SizeConfig.blockSizeHorizontal * 0.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$number',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        // fontSize: SizeConfig.safeBlockHorizontal * 0.4.w
                      ),
                    ),
                    Text(
                      '$title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          // fontSize: SizeConfig.safeBlockHorizontal * 0.5.h
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$username',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          // fontSize: SizeConfig.safeBlockHorizontal * 0.5.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            body: FutureBuilder(
              future: forLoading(),
              builder: (cxt, snp) {
                if (snp.hasData) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: WillPopScope(
                      child: Column(
                        children: [
                          Expanded(
                              // height: MediaQuery.of(context).size.height - 150,
                              child: SmartRefresher(
                                  controller: _refreshController,
                                  enablePullDown: true,
                                  enablePullUp: false,
                                  header: CustomHeader(
                                    builder: (context, mode) {
                                      return Container(
                                        height: 60.0,
                                        child: Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child: Center(
                                              child:
                                                  CupertinoActivityIndicator()),
                                        ),
                                      );
                                    },
                                  ),
                                  onRefresh: _onRefresh,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      if (index == this.messages.length) {
                                        return Center(child: Text('loading'));
                                      }

                                      if (this.messages[index]
                                              ['speaker_role_id'] ==
                                          this.currentUserRoleID) {
                                        return SendMessageWidget(
                                            message: messages[index],
                                            timezone: this.myTimeZone);
                                      } else {
                                        return ReceivedMessageWidget(
                                            message: messages[index],
                                            timezone: this.myTimeZone);
                                      }
                                    },
                                  ))),
                          typing ? LoadingIndicator() : SizedBox(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              // height: 70,
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (!readOnly)
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              18.w,
                                          child: Card(
                                            margin: EdgeInsets.only(
                                                left: 2, right: 2, bottom: 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: TextFormField(
                                              controller: _text,
                                              focusNode: focusNode,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 5,
                                              minLines: 1,
                                              onChanged: (value) {
                                                _typingEmit(value);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0),
                                                ),
                                                border: OutlineInputBorder(),
                                                hintText: "メッセージを入力",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                prefixIcon: IconButton(
                                                  color: Colors.grey,
                                                  icon: Icon(Icons.keyboard),
                                                  onPressed: () {
                                                    if (!show) {
                                                      focusNode.unfocus();
                                                      focusNode
                                                              .canRequestFocus =
                                                          false;
                                                    }
                                                    setState(() {
                                                      show = !show;
                                                    });
                                                  },
                                                ),
                                                suffixIcon: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      color: Colors.grey,
                                                      icon: Icon(
                                                          Icons.attach_file),
                                                      onPressed: () {
                                                        finleInput();
                                                        // showModalBottomSheet(
                                                        //     backgroundColor:
                                                        //         Colors.transparent,
                                                        //     context: context,
                                                        //     builder: (builder) =>
                                                        //         bottomSheet());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0,
                                            right: 2,
                                            left: 2,
                                          ),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Style
                                                .CustomColor.secondaryColor,
                                            child: IconButton(
                                              iconSize:
                                                  SizeConfig.safeBlockVertical *
                                                      0.3.h,
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                // scrollToBottomMessageWithAnimate();
                                                sendMsg();
                                                _text.clear();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onWillPop: () {
                        if (show) {
                          setState(() {
                            show = false;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                        return Future.value(false);
                      },
                    ),
                  );
                } else {
                  return Center(child: CupertinoActivityIndicator());
                }
              },
            )),
      ],
    );
  }
}

Widget bottomSheet() {
  return Container(
    height: 278,
    child: Card(
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(Icons.headset, Colors.orange, "Audio"),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.location_pin, Colors.teal, "Location"),
                SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.person, Colors.blue, "Contact"),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget iconCreation(IconData icons, Color color, String text) {
  return InkWell(
    onTap: () {},
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icons,
            // semanticLabel: "Help",
            size: 29,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            // fontWeight: FontWeight.w100,
          ),
        )
      ],
    ),
  );
}
