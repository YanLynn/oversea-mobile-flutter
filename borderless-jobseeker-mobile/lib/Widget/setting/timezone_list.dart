import 'package:borderlessWorking/bloc/timezone_setting_bloc/timezone_setting_bloc.dart';
import 'package:borderlessWorking/screens/setting/all_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class TimezoneList extends StatefulWidget {
  @override
  _TimezoneListState createState() => _TimezoneListState();
}

class _TimezoneListState extends State<TimezoneList> {
  // bool selected = false;
  // void _whenSelect() {
  //   setState(() {
  //     _obscureText = !_obscureText;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        title: Text('タイムゾーン設定',
            textAlign: TextAlign.left, style: TextStyle(color: Colors.white)),
        backgroundColor: Style.CustomColor.mainColor,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            // Navigator.of(context).popAndPushNamed('/all-setting');
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AllSetting(
                          timezoneVal: 'timezone',
                          offsetVal: 'offset',
                        )));
          },
        ),
      ),
      body: BlocProvider<TimezoneSettingBloc>(
        create: (context) => TimezoneSettingBloc()..add(GetTimeZoneList()),
        child: _showList(context),
      ),
    );
  }
}

Widget _showList(BuildContext context) {
  return BlocBuilder<TimezoneSettingBloc, TimezoneSettingState>(
      builder: (context, state) {
    if (state is TimezoneSettingLoading) {
      progressLoading();
    }
    if (state is TimezoneSettingSuccess) {
      List timezoneList = state.timezoneList;
      return ListView.separated(
        //  padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(top: 8.0),
        // margin: const EdgeInsets.all(0.0),
        itemCount: timezoneList.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () => {
              // setState(() {
              //   selected = 'select';
              // }),
              // Navigator.of(context).popAndPushNamed('/all-setting')
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AllSetting(
                            timezoneVal: timezoneList[position].Time_Zone,
                            offsetVal: timezoneList[position].GMT_Offset,
                          ))),
            },
            child: Container(
              height: 50,
              //  decoration: BoxDecoration(
              //    gradient: LinearGradient(
              //      begin: Alignment.topCenter,
              //      end: Alignment.bottomCenter,
              //      colors: [
              //        Colors.black26,
              //        Colors.black12,
              //        Colors.black26,
              //      ]
              //    ),
              //  ),
              child: Center(
                  child: Text("(" +
                      timezoneList[position].GMT_Offset +
                      ") " +
                      timezoneList[position].Time_Zone)),
            ),
          );
          // return scoutCard(scoutedList[position], context, 'list');
        },
        //  itemBuilder: (BuildContext context, int index) {
        //    return Container(
        //      height: 50,
        //      child: Center(child: Text('${timezoneList[index]}')),
        //    );
        //  },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
    return progressLoading();
  });
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
