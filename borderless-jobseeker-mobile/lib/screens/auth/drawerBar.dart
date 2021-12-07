import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:borderlessWorking/screens/setting/all_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:borderlessWorking/data/api/apis.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer(this.profileImg, this.username);
  final String profileImg, username;
  AuthRepository authRepository = AuthRepository();
  @override
  
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        final userData = state.user;
        return SafeArea(                   
          child: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: new Color(0xFF91AABE),
                  ),
                  // "https://testoverseas-jobs.management-partners.co.jp/uploads/jobseekers/images/${userData['face_image']}",
                  accountName: Text(
                    (username == null || username == '') ? userData['name'] : username,
                  ),
                  accountEmail: Text("${userData['jobseeker_number']}"),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? new Color(0xFFb4bdce)
                            : Colors.white,
                    backgroundImage: AssetImage('assets/images/loading.gif'),
                    child: CircleAvatar(
                      radius: 33.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        (profileImg == null || profileImg == '') ? userData['face_image_url'] : profileImg,
                        // "https://testoverseas-jobs.management-partners.co.jp/uploads/jobseekers/images/${userData['face_image']}"
                      ),
                    ),
                  ),
                ),
                ListTile(
                  // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(Icons.home),
                  title: Align(
                    child: new Text('サイトトップページへ', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/');
                  },
                ),
                ListTile(
                  // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(Icons.assignment_ind),
                  title: Align(
                    child: new Text('プロフィール', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () {
                    // Navigator.of(context).popAndPushNamed('/profile');
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new ExpansionTileCardDemo(saveSuccess: null)));
                  },
                ),
                ListTile(
                  // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(Icons.settings),
                  title: Align(
                    child: new Text('各種設定の変更', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new AllSetting(
                                timezoneVal: 'timezone', offsetVal: 'offset')));
                  },
                ),
                ListTile(
                  // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(Icons.mark_as_unread),
                  title: Align(
                    child: new Text('スカウト設定', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/scout-setting');
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text('Contact Us'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  title: Text('お問い合わせフォーム',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/content')},
                ),
                ListTile(
                  dense: true,
                  title: Text('Information'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('ボーダレスワーキングについて',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {Navigator.of(context).popAndPushNamed('/about')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('プライバシーポリシー',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/privacypolicy')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('利用規約',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {Navigator.of(context).popAndPushNamed('/terms')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('特定商取引法に基づく表記',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {
                    Navigator.of(context)
                        .popAndPushNamed('/specified-commerical-transactions')
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text('Membership'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('登録とスカウトを受けるまでの流れ',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/jobseeker-flow')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  onTap: () async {
                    Apis.socket.emit("logout-user", "logout");
                    Navigator.of(context).pop();                  
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      LoggedOut(),
                    );
                    Apis.profileImg = null;
                    Apis.userName = null;
                    
                    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PublicHomeScreen(authRepository: authRepository, checkAlert: 'ログアウトしました。', selectedIndex: 0)), (route) => false);
                  },
                  title: Align(
                    child: new Text('ログアウト', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
        
                  // dense: true,
                  // title: Text("oversea"),
                  // trailing: Text(
                  //   "Version 2.0",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  // ),
                  leading: Icon(Icons.logout_rounded),
                ),
              ],
            ),
          ),
        );
      }
      if (state is AuthenticationUnauthenticated) {
        return SafeArea(
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  margin: EdgeInsets.only(bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Style.CustomColor.mainColor,
                  ),
                  child: IconButton(
                    // icon: Icon(Icons.person_add_rounded),
                    icon: Icon(Icons.person_add),
                    color: Colors.black12,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed("/register");
                    },
                  ),
                ),
                ListTile(
                  // visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  leading: Icon(Icons.home),
                  title: Align(
                    child: new Text('サイトトップページへ', style: TextStyle(color: Style.CustomColor.secondaryColor)),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed('/');
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text('Contact Us'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  title: Text('お問い合わせフォーム',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/content')},
                ),
                ListTile(
                  dense: true,
                  title: Text('Information'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('ボーダレスワーキングについて',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {Navigator.of(context).popAndPushNamed('/about')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('プライバシーポリシー',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/privacypolicy')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('利用規約',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {Navigator.of(context).popAndPushNamed('/terms')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('特定商取引法に基づく表記',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () => {
                    Navigator.of(context)
                        .popAndPushNamed('/specified-commerical-transactions')
                  },
                ),
                ListTile(
                  dense: true,
                  title: Text('Membership'),
                  tileColor: Color(0xFFECECEC),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('登録とスカウトを受けるまでの流れ',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/jobseeker-flow')},
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: Text('求職者会員新規登録',
                      style: TextStyle(color: Style.CustomColor.secondaryColor)),
                  onTap: () =>
                      {Navigator.of(context).popAndPushNamed('/register')},
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: RaisedButton(
                    onPressed: () =>
                        {
                          Apis.loginPageType = 'home',
                          Navigator.of(context).popAndPushNamed('/login')
                        },
                    child: Text(
                      'ログイン',
                      style: Style.Customstyles.customText,
                    ),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(15),
                    color: Style.CustomColor.secondaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return Center();
    });
  }
}
