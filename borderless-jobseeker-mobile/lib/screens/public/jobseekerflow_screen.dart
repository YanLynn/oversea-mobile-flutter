import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class JobseekerflowPage extends StatelessWidget {
  const JobseekerflowPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登録とスカウトを受けるまでの流れ', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Style.CustomColor.mainColor,        
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: 15, // Space between underline and text
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "スカウトされるまでの流れ",
                    style: Style.Customstyles.h1,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(0),
                decoration: Style.Customstyles.borderBoxDecoration,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 1.0),
                    // decoration: BoxDecoration(
                    //     border: Border(right: BorderSide(width: 1.0))),
                    child: Container(
                      decoration: Style.Customstyles.numberBoxDecoration,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            "1",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.left,
                          )),
                    ),
                  ),
                  title: Text(
                    'まだ会員登録が済んでいない場合、以下のリンクから登録を行います。',
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/register');
                        },
                        child: Text(
                          '求職者会員新規登録',
                          style: Style.Customstyles.customText,
                        ),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.all(15),
                        color: Style.CustomColor.secondaryColor,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(0),
                decoration: Style.Customstyles.borderBoxDecoration,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 1.0),
                    // decoration: BoxDecoration(
                    //     border: Border(right: BorderSide(width: 1.0))),
                    child: Container(
                      decoration: Style.Customstyles.numberBoxDecoration,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            "2",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.left,
                          )),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '求職者会員管理画面',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).popAndPushNamed('/login');
                            },
                        ),
                        TextSpan(
                          text: 'にログインし詳細なプロフィールの入力や\n' +
                              '履歴書・職務経歴書のアップロードを行います。\n' +
                              '企業からスカウトを受けたい場合はスカウトを受ける設定を有効にします。',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(0),
                decoration: Style.Customstyles.borderBoxDecoration,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 1.0),
                    // decoration: BoxDecoration(
                    //     border: Border(right: BorderSide(width: 1.0))),
                    child: Container(
                      decoration: Style.Customstyles.numberBoxDecoration,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.left,
                          )),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'トップ画面',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).popAndPushNamed('/');
                            },
                        ),
                        TextSpan(
                          text: 'より求人を検索し、求人に問合せ/応募します。\n' +
                              'この時点で企業会員とチャットで会話が可能となります。\n' +
                              'チャットにて求人について質問や面接日の設定等を行ってください。\n' +
                              'チャット機能は求職者会員管理画面からのみ利用できます。\n' +
                              '※チャット上での電話・メール・住所等連絡先の交換は禁止していますので、ご注意願います。',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/for-chat.jpg",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15, // Space between underline and text
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "企業よりスカウトされた場合",
                    style: Style.Customstyles.h1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: 15, // Space between underline and text
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'スカウトを受ける設定が有効になっている場合は企業会員からスカウトを受けることがあります。\n' +
                        '掲載されている求人への応募の手順１と２はスカウトの場合も必要です。それ以降の手順が異なります。',
                    style: Style.Customstyles.lighth1,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(0),
                decoration: Style.Customstyles.borderBoxDecoration,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: Container(
                    padding: EdgeInsets.only(right: 1.0),
                    // decoration: BoxDecoration(
                    //     border: Border(right: BorderSide(width: 1.0))),
                    child: Container(
                      decoration: Style.Customstyles.numberBoxDecoration,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.left,
                          )),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'あなたのプロフィールを見た企業会員からスカウトしたい旨のメールが届きます。\n' +
                              'スカウトを受ける場合、',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: '求職者会員管理画面',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).popAndPushNamed('/login');
                            },
                        ),
                        TextSpan(
                          text:
                              'にログイン後、スカウトを受けている求人のリスト上の「興味あり」ボタンをクリックします。\n' +
                                  'この時点で企業会員とチャットで会話が可能となります。\n' +
                                  'チャットにてスカウトについて質問や面接日の設定等を行ってください。\n' +
                                  'チャット機能は求職者会員管理画面からのみ利用できます。\n' +
                                  '※チャット上での電話・メール・住所等連絡先の交換は禁止していますので、ご注意願います。',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Image.asset(
                        "assets/images/scoutedlist.png",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
