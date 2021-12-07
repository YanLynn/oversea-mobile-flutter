import 'package:borderlessWorking/bloc/chat_bloc/chatuser_bloc.dart';
import 'package:borderlessWorking/data/model/chat/chatUserList.dart';
import 'package:borderlessWorking/data/repositories/chatting_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ChatLists extends StatefulWidget {
  const ChatLists({Key key}) : super(key: key);

  @override
  _ChatListsState createState() => _ChatListsState();
}

class _ChatListsState extends State<ChatLists> {
  ChatRepositories _chatRepositories = ChatRepositories();
  final ChatuserBloc _chatuserBloc = ChatuserBloc();
  var myTimeZone = null;
  List<ChatUserList> chatUserData = [];
  List<ChatUserList> userList = [];
  String filterText = '';

  @override
  void initState() {
    tz.initializeTimeZones();
    _chatuserBloc.add((GetChatUserList()));
    super.initState();
    countMsg();
    userList = chatUserData;
    Apis.socket.connect();
    getMe();
  }

  countMsg() {
    Apis.socket.on(
        "count-message",
        (data) async => {
              if (mounted)
                {
                  await userList.forEach((e) {
                    if (e.scoutid_or_applyid == data['scoutid_or_applyid'] &&
                        e.type == data['type']) {
                      setState(() {
                        e.unread++;
                        Apis.notiCountforHomeIcon.value = e.unread;
                        e.last_chat_time = data["created_at_time"];
                      });
                    }
                  }),
                  orderUserList(),
                }
            });
  }

  orderUserList() {
    print("order userList");
    userList.sort(
      (b, a) => (a.last_chat_time != null && b.last_chat_time != null)
          ? DateTime.parse(a.last_chat_time)
              .compareTo(DateTime.parse(b.last_chat_time))
          : ((a.last_chat_time != null && b.last_chat_time == null)
              ? 1
              : ((a.last_chat_time == null && b.last_chat_time != null)
                  ? -1
                  : 0)),
    );

    // userList.sort((a, b) {
    //   var dateA = a.last_chat_time != null ? DateTime.parse(a.last_chat_time): null;
    //   var dateB = b.last_chat_time != null ? DateTime.parse(b.last_chat_time): null;
    //   return dateB.compareTo(dateA);
    // });
  }

  lastTime(value) {
    if (value == null) {
      return '';
    }
    var timezone = this.myTimeZone;

    var v = DateTime.parse(utcToTimezone(value, timezone));
    var detroit = tz.getLocation(this.myTimeZone);
    var aa = DateTime.now();
    var t = tz.TZDateTime.from(DateTime.now(), detroit);

    var diff = (t.difference(v).inDays).round();
    if (t.day == v.day && t.month == v.month && t.year == v.year) {
      //isToday
      var h = v.hour;
      var hour = h < 10 ? '0' + h.toString() : h.toString();
      var m = v.minute;
      var minute = m < 10 ? '0' + m.toString() : m.toString();
      return '$hour:$minute';
    } else if (diff < 8) {
      //within 7days
      const days = ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'];
      var day = v.weekday;
      if (day == 7) {
        day = 0;
      }
      return days[day];
    } else {
      var m = v.month;
      var month = m < 10 ? '0' + m.toString() : m.toString();
      var d = v.day;
      var day = d < 10 ? '0' + d.toString() : d.toString();
      return '${v.year}-$month-$day';
    }
  }

  String utcToTimezone(value, timezone, {showSecond = true}) {
    if (value == null || timezone == null) {
      return value;
    }

    var detroit = tz.getLocation(this.myTimeZone);

    DateTime date = DateTime.parse(value);
    DateTime utc = DateTime.utc(date.year, date.month, date.day, date.hour,
        date.minute, date.second, 0);
    var v = tz.TZDateTime.from(utc, detroit);

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

  getMe() async {
    final data = await _chatRepositories.me();

    if (data['extra'].length == 0) {
      this.myTimeZone = 'Asia/Tokyo';
    } else {
      if (data['extra']['timezone'] == 'Asia/Yangon') {
        this.myTimeZone = 'Asia/Rangoon';
      } else {
        this.myTimeZone = data['extra']['timezone'];
      }
    }
  }

  _filterList(String filterText) {
    List<ChatUserList> _result = [];
    _result = chatUserData.where((x) {
      final reName = x.recruiter_name.toLowerCase();
      final inName = x.incharge_name.toLowerCase();
      return reName.contains(filterText.toLowerCase()) ||
          inName.contains(filterText.toLowerCase());
    }).toList();

    setState(() {
      this.filterText = filterText;
      this.userList = _result;
    });
  }
  // '${userList.last_chat_time}'

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('チャット'),
          backgroundColor: Style.CustomColor.mainColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocProvider(
            create: (context) => _chatuserBloc,
            child: BlocListener<ChatuserBloc, ChatuserState>(listener:
                (cxt, state) {
              if (state is ChatuserListSuccess) {
                setState(() {
                  chatUserData = state.getUserList;
                  Apis.userList = chatUserData;
                  userList = Apis.userList;
                  orderUserList();
                });
              }
            }, child:
                BlocBuilder<ChatuserBloc, ChatuserState>(builder: (cxt, state) {
              if (state is ChatuserInitial) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is ChatuserListSuccess) {
                return Container(
                  child: Column(
                    children: [
                       Container(
                    color: Color(0xFFDDDDDD),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            'チャット先を選択してください',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                      _searchBar(),
                      Expanded(
                        child: ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context, position) {
                              return chatUserList(userList[position], context);
                            }),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }))));
  }

  Widget chatUserList(ChatUserList userList, BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, List newOnlineUsers, Widget child) {
        return Ink(
          padding: EdgeInsets.only(bottom: 5.0, top: 0.0),
          decoration: new BoxDecoration(
              color: Colors.white10,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]),
              )),
          child: ListTile(
            leading: newOnlineUsers.contains(userList.user_id)
                ? Icon(
                    Icons.circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.circle,
                    color: Colors.grey[300],
                  ),
            title: Text(
              userList.recruiter_name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Style.CustomColor.secondaryColor)
            ),
            subtitle: Text(
              userList.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(              
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (userList.unread != 0)
                  Container(
                    width: 36,
                    height: 30,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 1),
                    child: Container(
                      width: 25,
                      height: 18,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFF0051),
                          border: Border.all(color: Colors.white, width: 0)),
                      child: Center(
                        child: Text(
                          userList.unread.toString(),
                          style: TextStyle(color: Colors.white,fontSize: 10,),
                        ),
                      ),
                    ),
                  ),
                Container(                  
                  width: 70,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      lastTime(userList.last_chat_time),
                      style: TextStyle(color: Colors.grey,fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            onTap: () => {
              Navigator.of(context)
                  .pushNamed('/chat-room', arguments: userList)
                  .then((value) => _chatuserBloc.add(GetChatUserList()))
            },
          ),
        );
      },
      valueListenable: Apis.onlineUsers,
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 15, right: 15, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: '相手を検索',
          hintStyle: TextStyle(color: Color(0xffc1c1c1)),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          _filterList(text);
        },
      ),
    );
  }
}
