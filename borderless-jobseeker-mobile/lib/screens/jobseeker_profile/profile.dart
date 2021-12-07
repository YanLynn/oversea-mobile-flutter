import 'package:borderlessWorking/Widget/basicinfo/basicinfo.dart';
import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/carrer_details.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/desired_condition_details.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/exp_qualification_details.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/self_intro_details.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:borderlessWorking/style/custom_expansion_tile.dart' as custom;
import 'package:borderlessWorking/style/my_flutter_app_icons.dart'
    as CustomIcons;

class ExpansionTileCardDemo extends StatefulWidget {
  final saveSuccess;
  ExpansionTileCardDemo({Key key, @required this.saveSuccess})
      : super(key: key);
  @override
  _ExpansionTileCardDemoState createState() =>
      _ExpansionTileCardDemoState(this.saveSuccess);
}

class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
  final String saveSuccess;
  _ExpansionTileCardDemoState(this.saveSuccess);

  final GlobalKey<ExpansionTileCardState> cardSelfIntro = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardBasicInfo = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardCareer = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardExperience = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardDesiredCondition =
      new GlobalKey();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showAlert());
    profileImgChange();
  }

  profileImgChange() async {
    final info = await AuthRepository().info();    
    Apis.profileImg = info['face_image_url'];
    Apis.userName = info['jobseeker_name'];
    print("username => " + info['jobseeker_name']);
  }

  Future _showAlert() async {
    if (this.saveSuccess != null) {
      DialogContent().infoAlert(context, Icon(Icons.check_circle_outline),
          this.saveSuccess, Colors.greenAccent);
    }
  }

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
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: custom.ExpansionTile(
                headerBackgroundColor: Style.CustomColor.secondaryColor,
                key: cardSelfIntro,
                title: Text(
                  '⾃⼰紹介',
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        // color: Style.CustomColor.grey,
                        ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 0.0,
                      ),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            Icon(
                              CustomIcons.MyFlutterApp.edit,
                              color: Style.CustomColor.secondaryColor,
                            ), // icon-1
                            Text(
                              '編集',
                              style: TextStyle(
                                  color: Style.CustomColor.secondaryColor,
                                  fontSize: 13),
                              textAlign: TextAlign.left,
                            ), // icon-2
                          ],
                        ),
                        onTap: () => {
                          Navigator.of(context).pushNamed('/selfIntro-edit')
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  SelfIntroDetails()
                ],
              ),
            ),
            custom.ExpansionTile(
              headerBackgroundColor: Style.CustomColor.secondaryColor,
              key: cardBasicInfo,
              title: Text(
                '基本情報',
                style: TextStyle(color: Colors.white),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Style.CustomColor.grey,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 0.0,
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          Icon(
                            CustomIcons.MyFlutterApp.edit,
                            color: Style.CustomColor.secondaryColor,
                          ), // icon-1
                          Text(
                            '編集',
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontSize: 13),
                            textAlign: TextAlign.left,
                          ), // icon-2
                        ],
                      ),
                      onTap: () =>
                          {Navigator.of(context).pushNamed('/editbasicinfo')},
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Getbasicinfo(),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  decoration: Style.Customstyles.borderBoxDecoration,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 1.0),
                            child: Container(
                              decoration:
                                  Style.Customstyles.privateBoxDecoration,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    "非公開",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ),
                          title: Text(
                            'は企業会員からは閲覧することはできませんが、公開とすることも可能です。',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ),
                      Container(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 1.0),
                            child: Container(
                              decoration: Style.Customstyles.viewBoxDecoration,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    "運営管理者のみ閲覧可",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ),
                          title: Text(
                            'は企業会員からは閲覧することはできません。',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            custom.ExpansionTile(
              headerBackgroundColor: Style.CustomColor.secondaryColor,
              key: cardCareer,
              title: Text(
                '経歴',
                style: TextStyle(color: Colors.white),
                // style: const TextStyle(
                //   fontSize: 16.0,
                //   // fontWeight: FontWeight.bold,
                //   color: Style.CustomColor.secondaryColor,
                // ),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Style.CustomColor.grey,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 0.0,
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          Icon(
                            CustomIcons.MyFlutterApp.edit,
                            color: Style.CustomColor.secondaryColor,
                          ), // icon-1
                          Text(
                            '編集',
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontSize: 13),
                            textAlign: TextAlign.left,
                          ), // icon-2
                        ],
                      ),
                      onTap: () =>
                          {Navigator.of(context).pushNamed('/career-edit')},
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                CarrerDetail(),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  decoration: Style.Customstyles.borderBoxDecoration,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 1.0),
                            child: Container(
                              decoration:
                                  Style.Customstyles.privateBoxDecoration,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    "非公開",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ),
                          title: Text(
                            'は企業会員からは閲覧することはできませんが、公開とすることも可能です。',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ),
                      Container(
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          leading: Container(
                            padding: EdgeInsets.only(right: 1.0),
                            child: Container(
                              decoration: Style.Customstyles.viewBoxDecoration,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  child: Text(
                                    "運営管理者のみ閲覧可",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ),
                          title: Text(
                            'は企業会員からは閲覧することはできません。',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            custom.ExpansionTile(
              headerBackgroundColor: Style.CustomColor.secondaryColor,
              key: cardExperience,
              title: Text(
                '経験・資格',
                style: TextStyle(color: Colors.white),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Style.CustomColor.grey,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 0.0,
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          Icon(
                            CustomIcons.MyFlutterApp.edit,
                            color: Style.CustomColor.secondaryColor,
                          ), // icon-1
                          Text(
                            '編集',
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontSize: 13),
                            textAlign: TextAlign.left,
                          ), // icon-2
                        ],
                      ),
                      onTap: () => {
                        Navigator.of(context)
                            .pushNamed('/exp-qualification-edit')
                      },
                    ),
                  ),
                ),
                ExpQualificationDetails(),
              ],
            ),
            custom.ExpansionTile(
              headerBackgroundColor: Style.CustomColor.secondaryColor,
              key: cardDesiredCondition,
              title: Text(
                '希望条件',
                style: TextStyle(color: Colors.white),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: Style.CustomColor.grey,
                      ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 0.0,
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      trailing: Wrap(
                        spacing: 12, // space between two icons
                        children: <Widget>[
                          Icon(
                            CustomIcons.MyFlutterApp.edit,
                            color: Style.CustomColor.secondaryColor,
                          ), // icon-1
                          Text(
                            '編集',
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontSize: 13),
                            textAlign: TextAlign.left,
                          ), // icon-2
                        ],
                      ),
                      onTap: () => {
                        Navigator.of(context)
                            .pushNamed('/desired-condition-edit')
                      },
                    ),
                  ),
                ),
                DesiredConditionDetails(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
