import 'package:borderlessWorking/Widget/setting/deactivate_setting.dart';
import 'package:borderlessWorking/Widget/setting/emailchange.dart';
import 'package:borderlessWorking/Widget/setting/time_zone_setting.dart';
import 'package:borderlessWorking/Widget/setting/password_setting.dart';
import 'package:borderlessWorking/bloc/deactivate_bloc/deactivate_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSetting extends StatefulWidget {
  final timezoneVal, offsetVal;
  AllSetting({Key key, @required this.timezoneVal, @required this.offsetVal})
      : super(key: key);
  @override
  _AllSettingState createState() =>
      _AllSettingState(this.timezoneVal, this.offsetVal);
}

class _AllSettingState extends State<AllSetting> {
  final String timezoneVal, offsetVal;

  _AllSettingState(this.timezoneVal, this.offsetVal);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          centerTitle: true,
          backgroundColor: Style.CustomColor.mainColor,
          actions: [
            ValueListenableBuilder(
                valueListenable: Apis.notiCountforHomeIcon,
                builder:
                    (BuildContext context, int newNotiCounter, Widget child) {
                  return Stack(
                    children: [
                      IconButton(
                          onPressed: () =>
                              {Navigator.of(context).pushNamed('/chat-lists')},
                          icon: Icon(
                            Icons.message_rounded,
                          )),
                      if (newNotiCounter != 0)
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
                                border:
                                    Border.all(color: Colors.white, width: 0)),
                            child: Center(
                              child: Text(
                                  newNotiCounter < 5
                                      ? newNotiCounter.toString()
                                      : '5+',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            ),
                          ),
                        ),
                    ],
                  );
                })
          ],
        ),
        drawer: MyDrawer(Apis.profileImg, Apis.userName),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<DeactivateBloc>(create: (_) => DeactivateBloc()),
          ],
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Timezone(timezoneVal: timezoneVal, offsetVal: offsetVal),
                  PasswordSetting(),
                  Emailsetting(),
                  DeactivateSetting(),
                ],
              ),
            ),
          ),
        ));
  }
}
