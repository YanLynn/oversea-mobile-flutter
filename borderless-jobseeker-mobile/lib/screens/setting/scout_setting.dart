import 'package:borderlessWorking/bloc/scout_setting_bloc/scout_setting_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
// import 'package:borderlessWorking/data/repositories/scout_setting_repositories.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoutSetting extends StatefulWidget {
  @override
  _ScoutSettingState createState() => _ScoutSettingState();
}

class _ScoutSettingState extends State<ScoutSetting> {
  final ScoutSettingBloc _bloc = ScoutSettingBloc();

  @override
  void initState() {
    _bloc.add(GetScoutSetting());
    super.initState();
  }

  var selectedValue = null;
  // final _scoutSettingRepository = ScoutSettingRepository();

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
      body: BlocProvider<ScoutSettingBloc>(
        create: (_) => _bloc,
        child: BlocBuilder<ScoutSettingBloc, ScoutSettingState>(
          builder: (context, state) {
            if (state is ScoutSettingSuccess) {
              selectedValue = state.status;
            }

            return item(context, selectedValue);
          },
        ),
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
    );
  }

  Widget item(context, int status) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Align(
                    child: new Text('スカウトを利用しない'),
                    alignment: Alignment.topLeft),
                leading: Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => Style.CustomColor.mainColor),
                  value: 0,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    BlocProvider.of<ScoutSettingBloc>(context).add(
                      ScoutSettingChanged(value),
                    );
                    setState(() {
                      selectedValue = value;
                    });
                    // _changeSetting(context, value);
                  },
                ),
              ),
              ListTile(
                title: Align(
                    child: new Text('登録済みのすべての企業からスカウトを受ける'),
                    alignment: Alignment.topLeft),
                leading: Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => Style.CustomColor.mainColor),
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    BlocProvider.of<ScoutSettingBloc>(context).add(
                      ScoutSettingChanged(value),
                    );
                    setState(() {
                      selectedValue = value;
                    });
                    // _changeSetting(context, value);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'プロフィールの公開情報は、編集ができます。 \n※非公開情報が少ないほど、スカウトされやすくなります。プロフィールを更新してください。',
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.grey[300],
                ),
              ),
            ],
          )),
    );
  }
}
