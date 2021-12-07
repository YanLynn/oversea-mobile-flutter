// import 'package:borderlessWorking/Widget/setting/timezone_list.dart';
import 'package:borderlessWorking/bloc/timezone_bloc/timezone_bloc.dart';
import 'package:borderlessWorking/data/model/timezonesetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:borderlessWorking/Widget/message_alert.dart';

class Timezone extends StatefulWidget {
  final timezoneVal, offsetVal;
  Timezone({Key key, @required this.timezoneVal, @required this.offsetVal})
      : super(key: key);
  @override
  _TimezoneState createState() =>
      _TimezoneState(this.timezoneVal, this.offsetVal);
}

class _TimezoneState extends State<Timezone> {
  final TimezoneBloc _bloc = TimezoneBloc();

  final String timezoneVal, offsetVal;
  _TimezoneState(this.timezoneVal, this.offsetVal);

  // List<TimeZoneSettingModel> _usertimezone = {"timezone" : "Asia/Yangon", "offset" : "+06:30"} as List<TimeZoneSettingModel>;
  List<dynamic> _usertimezone = [];
  bool _isDisabled = true;

  void initState() {
    _bloc.add(GetUserTimeZone());
    super.initState();
    timezoneInit();
  }

  void timezoneInit() async {
    setState(() {
      this._usertimezone.add({
        "timezone": "",
        "offset": "",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Text("Click me"),
        child: BlocProvider(
            create: (_) => _bloc,
            child: BlocListener<TimezoneBloc, TimezoneState>(
              listener: (context, state) {
                if (state is GetUserTimeZoneSuccess) {                  
                  List<TimeZoneSettingModel> _usertimezoneVal =
                      state.usertimezoneList;
                  _usertimezone[0]["timezone"] = _usertimezoneVal[0].timezone;
                  _usertimezone[0]["offset"] = _usertimezoneVal[0].offset;
                  _isDisabled = timezoneVal == 'timezone' ? true : false;
                }
                if(state is TimeZoneChangedSuccess) {
                  List<TimeZoneSettingModel> _usertimezoneVal =
                      state.usertimezoneList;
                  _usertimezone[0]["timezone"] = _usertimezoneVal[0].timezone;
                  _usertimezone[0]["offset"] = _usertimezoneVal[0].offset;
                  _isDisabled = true;
                  DialogContent().infoAlert(
                      context, Icon(Icons.check_circle_outline), "変更しました。", Colors.greenAccent);
                }
                if(state is TimezoneFailure) {                  
                  DialogContent().infoAlert(
                      context, Icon(Icons.check_circle_outline), state.error, Colors.greenAccent);
                }
              },
              child: BlocBuilder<TimezoneBloc, TimezoneState>(
                  builder: (context, state) {
                // if (state is TimezoneLoading) {
                return Container(
                  child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  color: Color(0xFFDDDDDD),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(
                                          'タイムゾーン設定',
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
                                Container(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "タイムゾーン ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "(UTC " +
                                                _usertimezone[0]["offset"] +
                                                ") " +
                                                _usertimezone[0]["timezone"],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text(
                                              "チャット機能で表示される時刻が選択されたゾーンの時刻となります。",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Style.CustomColor
                                                      .secondaryColor)),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Card(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.grey, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            margin: new EdgeInsets.symmetric(
                                                vertical: 0.0),
                                            child: ListTile(
                                              trailing: Icon(
                                                  Icons.keyboard_arrow_down),
                                              title: timezoneVal == 'timezone'
                                                  ? Text(
                                                      "(UTC " +
                                                          _usertimezone[0]
                                                              ["offset"] +
                                                          ") " +
                                                          _usertimezone[0]
                                                              ["timezone"],
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black87),
                                                    )
                                                  : Text(
                                                      "( " +
                                                          offsetVal +
                                                          ") " +
                                                          timezoneVal,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    '/time-zone-list');
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: RaisedButton(
                                                elevation: 5.0,
                                                color: Style
                                                    .CustomColor.secondaryColor,
                                                disabledColor:
                                                    Style.CustomColor.mainColor,
                                                disabledTextColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                onPressed: _isDisabled ? null : () {
                                                  BlocProvider.of<TimezoneBloc>(
                                                          context)
                                                      .add(
                                                    ChangeTimezoneButtonPressed(
                                                        timezoneVal, offsetVal),
                                                  );
                                                },
                                                child: Text(
                                                  " 変更 ",
                                                  style: Style
                                                      .Customstyles.customText,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            // progressLoading()
                          ])),
                );
                // }

                // return progressLoading();
              }),
            )));
  }
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
