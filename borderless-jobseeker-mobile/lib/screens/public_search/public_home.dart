import 'dart:convert';
import 'package:borderlessWorking/data/repositories/public_search_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'dart:convert' as JSON;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

class PublicSerch extends StatefulWidget {
  final List<dynamic> data;

  PublicSerch({Key key, @required this.data}) : super(key: key);
  @override
  _PublicSerchState createState() => _PublicSerchState();
}

String type = '';
List<dynamic> countryList = [];
List<dynamic> occupationList = [];
TextEditingController _keywordController = TextEditingController();

class _PublicSerchState extends State<PublicSerch> {
  final storage = new FlutterSecureStorage();
  final _publicSearch = new PublicSearchRepository();
  final jsonEncoder = JsonEncoder();

  var popular, historyCountry = [];

  var jobseeker = {
    'keyword': "",
    'country': [],
    'historyCountry': [],
    'occupation': [],
  };

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      if (widget.data[0] != null) {
        countryList = widget.data[0];
      }

      if (widget.data[1] != null) {
        occupationList = widget.data[1];
      }
      // if (type == 'country') {
      //   countryList = widget.data;
      // }
      // if (type == 'occupation') {
      //   occupationList = widget.data;
      // }
    }
    
  }

  void clearData() {
    setState(() {
      _keywordController.text = '';
      countryList = [];
      occupationList = [];
    });
  }

  Widget build(BuildContext context) {
    chooseCountry() {
      type = 'country';
      Navigator.of(context)
          .pushNamed('/country-list', arguments: ['rebind', countryList]);
    }

    chooseOccupation() {
      type = 'occupation';
      Navigator.of(context)
          .pushNamed('/occupation-list', arguments: occupationList);
    }

    searchJob(type, keyword) async {
      if (type == 'keyword') {
        jobseeker['historyCountry'] = [];
        jobseeker['keyword'] = keyword;
        jobseeker['country'] = [];
        jobseeker['occupation'] = [];
      } else {
        // await storage.deleteAll();
        this.jobseeker['historyCountry'] = [];
        this.historyCountry = [];
        var countryArr = {};
        var monthNames = [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ];

        var month = new DateTime.now().month - 1;
        var currentMonthCountry = monthNames[month] + "SearchHistoryCountry";
        var data = await storage.read(key: "search_histories");
        var searchhistories;
        if (data != null) {
          searchhistories = JSON.jsonDecode(data);
        }
        if (searchhistories != null) {
          // var searchhistories = JSON.jsonDecode(data);
          this.popular = searchhistories;
          var key = this.popular[0]['country'].keys.first;
          if (key == currentMonthCountry) {
            var idList = this.popular[0]["country"][currentMonthCountry]['id'];
            // var res = idList.join(",");
            var res = idList.split(",");
            countryList
                .map((e) async => {
                      if (!res.contains(e.toString()))
                        {
                          if (res[0] == "") {res.removeAt(0)},
                          res.add(e.toString()),
                          historyCountry.add(e),
                          this.jobseeker['historyCountry'] = historyCountry,
                          this.popular[0]["country"][currentMonthCountry]
                              ['id'] = res.join(","),
                          await storage.write(
                              key: "search_histories",
                              value: jsonEncoder.convert(this.popular))
                        }
                    })
                .toList();
          } else {
            this.popular[0]["country"].remove(key);
            this.popular[0]["country"][currentMonthCountry] = {
              'id': countryList.join(","),
            };
            this.jobseeker['historyCountry'] = countryList;
            await storage.write(
                key: "search_histories",
                value: jsonEncoder.convert(this.popular));
          }
        } else {
          if (countryList.length != 0) {
            countryArr[currentMonthCountry] = {
              'id': countryList.join(","),
            };
          } else {
            countryArr[currentMonthCountry] = {
              'id': "",
            };
          }

          this.jobseeker['historyCountry'] = this.jobseeker['country'];
          this.popular = [];
          this.popular.add({'country': countryArr});
          await storage.write(
              key: "search_histories",
              value: jsonEncoder.convert(this.popular));
        }

        jobseeker['keyword'] = _keywordController.text;
        jobseeker['country'] = countryList;
        jobseeker['occupation'] = occupationList
            .where((value) => value.completed == true)
            .map((item) {
          return item.id;
        }).toList();
      }

      final jobs = await _publicSearch.getJobs(1, jobseeker);
      List fav_job_ids = [];
      jobs
          .map((x) => {
                if (x.fav != '') {fav_job_ids.add(x.job_id)}
              })
          .toList();

      Navigator.of(context).pushNamed('/public-search-result',
          arguments: [jobs, fav_job_ids, jobseeker]);
    }

    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Container(
        // color: Style.CustomColor.bodyColor,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Form(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            // padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300], spreadRadius: 1),
                              ],
                            ),
                            child: FlatButton(
                              color: Colors.white,
                              onPressed: () => searchJob('keyword', '新卒歓迎'),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Icon(
                                    Icons.school,
                                    color: Color(0XFF35C2D2),
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text("新卒歓迎",
                                style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300], spreadRadius: 1),
                            ],
                          ),
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => searchJob('keyword', '未経験歓迎'),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Icon(
                                  Icons.play_for_work,
                                  color: Color(0XFFD2358E),
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: Text("未経験歓迎",
                              style: TextStyle(
                                  color: Style.CustomColor.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300], spreadRadius: 1),
                            ],
                          ),
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => searchJob('keyword', 'シニア歓迎'),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Icon(
                                  Icons.group_work,
                                  color: Color(0XFFD27435),
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text("シニア歓迎",
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300], spreadRadius: 1),
                            ],
                          ),
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => searchJob('keyword', '本社採用'),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Icon(
                                  Icons.apartment,
                                  color: Color(0XFFD2356A),
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("本社採用",
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 0.2.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300], spreadRadius: 1),
                            ],
                          ),
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => searchJob('keyword', '語学不問'),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Icon(
                                  Icons.language,
                                  color: Color(0XFFD235C2),
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("語学不問",
                            style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            Container(
              child: TextField(
                controller: _keywordController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.h),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "キーワードで絞り込む",
                    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)))),
              ),
            ),
            SizedBox(height: 2.h),

            // if (countryList != null)
            //   Container(
            //     child: Row(
            //       children: <Widget>[
            //         if (countryList.length != null)
            //           for (int i = 0; i < countryList.length; i++)
            //             Text(
            //               countryList[i] + ",",
            //               overflow: TextOverflow.fade,
            //               maxLines: 1,
            //               softWrap: false,
            //             )
            //       ],
            //     ),
            //   ),
            // Container(
            //   child: Card(
            //     elevation: 0.0,
            //     shape: RoundedRectangleBorder(
            //       side: BorderSide(color: Colors.grey, width: 1),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     margin: new EdgeInsets.symmetric(
            //       vertical: 50.0,
            //     ),
            //     child: ListTile(
            //       contentPadding: EdgeInsets.symmetric(
            //           vertical: 50.0, horizontal: 90.0),
            //       dense: true,
            //       leading: Text(
            //         '勤務地を選択',
            //         style: new TextStyle(
            //             fontSize: 30.0,
            //             color: Style.CustomColor.secondaryColor,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       trailing: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Icon(
            //             Icons.keyboard_arrow_right,
            //             size: 40,
            //           ),
            //         ],
            //       ),
            //       subtitle: Row(
            //         children: <Widget>[
            //           if (countryList.length != null)
            //             for (int i = 0; i < countryList.length; i++)
            //               Text(
            //                 countryList[i] + ",",
            //               )
            //         ],
            //       ),
            //       onTap: () {
            //         chooseCountry();
            //       },
            //     ),
            //   ),
            // ),
            // countryList
            GestureDetector(
              onTap: () => {chooseCountry()},
              child: Container(
                padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                decoration: ShapeDecoration(
                    shadows: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 0.5))
                    ],
                    image: DecorationImage(
                        image: AssetImage("assets/images/countrybg.png"),
                        fit: BoxFit.cover),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15))),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey,
                //       offset: Offset(0.0, 1.0),
                //       blurRadius: 2.0,
                //     ),
                //   ],
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      dense: true,
                      title: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            if (countryList.length != null)
                              for (int i = 0; i < countryList.length; i++)
                                (countryList.length - 1 != i)
                                    ? TextSpan(
                                        text: countryList[i] + ',',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : TextSpan(
                                        text: countryList[i],
                                        style: TextStyle(color: Colors.black),
                                      )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          // alignment: Alignment(0, -0.05),
                          child: Text(
                            '勤務地を選択',
                            style: new TextStyle(
                                fontSize: 20.sp,
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 25.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                  ],
                ),
              ),
            ),
            //end countryList
            SizedBox(height: 2.h),
            // chooseOccupation
            GestureDetector(
              onTap: () => {chooseOccupation()},
              child: Container(
                padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h),
                decoration: ShapeDecoration(
                    shadows: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 0.5))
                    ],
                    image: DecorationImage(
                        image: AssetImage("assets/images/occupationbg.png"),
                        fit: BoxFit.cover),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(15))),

                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey,
                //       offset: Offset(0.0, 1.0), //(x,y)
                //       blurRadius: 2.0,
                //     ),
                //   ],
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      dense: true,
                      title: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            if (occupationList != null)
                              for (int i = 0; i < occupationList.length; i++)
                                (occupationList.length - 1 != i)
                                    ? TextSpan(
                                        text:
                                            occupationList[i].occupation_name +
                                                ',',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : TextSpan(
                                        text: occupationList[i].occupation_name,
                                        style: TextStyle(color: Colors.black),
                                      )
                            // TextSpan(
                            //   text: occupationList[i].occupation_name +
                            //       ",",
                            //   style: TextStyle(color: Colors.black),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          // alignment: Alignment(0, -0.05),
                          child: Text(
                            '職種を選択',
                            style: new TextStyle(
                                fontSize: 20.sp,
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 25.sp,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                  ],
                ),
              ),
            ),
            //end chooseOccupation
            SizedBox(height: 4.h),

            //buttons
            Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        elevation: 5,
                        child: Text(
                          '全てクリア ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        onPressed: clearData,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        elevation: 5,
                        child: Text(
                          '検索 ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Style.CustomColor.secondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        onPressed: () => searchJob('search', null),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //end buttons
          ],
        )),
      ),
    ));
  }
}
