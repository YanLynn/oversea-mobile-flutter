import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class AboutPage extends StatelessWidget {
  const AboutPage();

  List<Widget> layoutChildren(double boxSide) {
    return [
      Container(
        width: boxSide,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    leading: Container(
                      child: Container(
                        decoration: Style.Customstyles.numberBoxDecoration,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "1",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('世界各国の企業の求人を検索できるばかりではなく、求職者の情報を登録し企業団体からのスカウトを待つことが可能です。')
              ],
            ),
          ),
        ),
      ),
      Container(
        width: boxSide,
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    leading: Container(
                      child: Container(
                        decoration: Style.Customstyles.numberBoxDecoration,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "2",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('求職者と企業団体間でチャットを使って手軽に問い合わせができます。')
              ],
            ),
          ),
        ),
      ),
      Container(
        width: boxSide,
        padding: EdgeInsets.all(0),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    leading: Container(
                      child: Container(
                        decoration: Style.Customstyles.numberBoxDecoration,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "3",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   decoration: Style.Customstyles.numberBoxDecoration,
                //   child: Padding(
                //       padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                //       child: Text(
                //         "3",
                //         style: TextStyle(color: Colors.white, fontSize: 18),
                //         textAlign: TextAlign.justify,
                //       )),
                // ),
                SizedBox(height: 10.0),
                Text('当社の経験豊富な海外就職コーディネーターが求職者や企業団体担当者を手厚くサポートします。')
              ],
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> layoutChildrenLandscape(double boxSide) {
    return [
      Container(
        width: boxSide,
        height: boxSide,
        padding: EdgeInsets.all(0),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: Style.Customstyles.numberBoxDecoration,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.justify,
                      )),
                ),
                SizedBox(height: 20.0),
                Text('世界各国の企業の求人を検索できるばかりではなく、求職者の情報を登録し企業団体からのスカウトを待つことが可能です。')
              ],
            ),
          ),
        ),
      ),
      Container(
        width: boxSide,
        height: boxSide,
        padding: EdgeInsets.all(0),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: Style.Customstyles.numberBoxDecoration,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.justify,
                      )),
                ),
                SizedBox(height: 20.0),
                Text('求職者と企業団体間でチャットを使って手軽に問い合わせができます。')
              ],
            ),
          ),
        ),
      ),
      Container(
        width: boxSide,
        height: boxSide,
        padding: EdgeInsets.all(0),
        decoration: Style.Customstyles.borderBoxDecoration,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: Style.Customstyles.numberBoxDecoration,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Text(
                        "3",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.justify,
                      )),
                ),
                SizedBox(height: 20.0),
                Text('当社の経験豊富な海外就職コーディネーターが求職者や企業団体担当者を手厚くサポートします。')
              ],
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    double boxside = size.shortestSide - 20;
    return Scaffold(
      appBar: AppBar(
        title: Text('ボーダーレスワーキングについて', style: TextStyle(color: Colors.white)),
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
                    "ボーダーレスワーキングについて",
                    style: Style.Customstyles.h1,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  "本サイトは海外で働きたい日本人を応援するために、求職者と企業団体の出会いの場を提供するプラットフォームです。\n" +
                      "掲載されている求人に応募したり、海外での勤務を希望する人材を検索し企業がスカウトを行うことが可能です。",
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image.asset(
                      "assets/images/about.jpg",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ボーダレスワーキングが選ばれる理由",
                    style: Style.Customstyles.h4,
                  ),
                ),
              ),
              Container(
                decoration: Style.Customstyles.wrapperBoxDecoration,
                padding: EdgeInsets.all(20.0),
                // color: Style.CustomColor.greylight,
                child: Builder(builder: (context) {
                  if (orientation.index == Orientation.landscape.index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: layoutChildrenLandscape(boxside / 2),
                    );
                  } else {
                    return Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: layoutChildren(boxside));
                  }
                }),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "料金体系",
                    style: Style.Customstyles.h4,
                  ),
                ),
              ),
              Container(
                decoration: Style.Customstyles.wrapperBoxDecoration,
                padding: EdgeInsets.all(0.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FractionColumnWidth(.3),
                            1: FractionColumnWidth(.7)
                          },
                          children: [
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "求職者会員	",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "無料",
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "企業会員",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '仲介手数料　200,000 円＋消費税\n' +
                                                '※内定が確認できた時点で請求を行います。',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "料金体系",
                            style: Style.Customstyles.p,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                                decoration: BoxDecoration(color: Colors.white),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "入金後はいかなる理由でも返金いたしません。",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
