import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class SpecifiedCommercialTransPage extends StatelessWidget {
  const SpecifiedCommercialTransPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('特定商取引法に基づく表記', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Style.CustomColor.mainColor,        
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                bottom: 15, // Space between underline and text
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "特定商取引法に基づく表記",
                  style: Style.Customstyles.h1,
                ),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("本サイト運営会社")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              // padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('名称：株式会社 TrustGrowth\n' +
                    '運営統括責任者：久保田直一\n' +
                    '本店所在地：〒163-0713 東京都新宿区西新宿 2-7-1 小田急第一生命ビル 13 階'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'お問合せ窓口：',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'https://borderless-working.jp/query',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).popAndPushNamed('/content');
                        },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("サービス費用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('仲介手数料 200,000 円'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("その他の費用")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'その他の費用 消費税\n' +
                        '銀行振り込み手数料\n' +
                        'インターネット接続料金その他の電気通信回線の通信に関する費用\n' +
                        '（料金はお客様がご利用の契約事業者が定める通り）',
                  )),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("支払い方法")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('クレジットカード決済\n' + '銀行振り込み'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("支払い時期")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    'クレジットカード決済：当社に内定の通知をいただいた後、メールによる請求あります。メールの指示に従い14 日以内にお支払いください。\n' +
                        '銀行振り込み：当社に内定の通知をいただいた後、請求書がメールにより送付されますので、その指示によりお支払いください。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("仕事提供の時期")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '企業会員と求職者会員で合意した日時',
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("仕事提供者")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    '仕事提供者の住所、電話番号、仕事提供に関する責任者その他の法定記載事項については、請求があり次第提供いたしますので、必要な方は上記本サイト運営会社のお問合せ窓口までご連絡ください。'),
              ),
            ),
            Container(
              // color: Style.CustomColor.greylight,
              padding: EdgeInsets.all(10),
              decoration: Style.Customstyles.titleCardBoxDecoration,
              child: Row(
                children: <Widget>[Text("キャンセルポリシー")],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    // Strings.header_eight,
                    '内定をキャンセルする場合は入金前に弊社にご連絡ください。\n' +
                        '入金された後はいかなる理由があっても返金いたしません。'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
