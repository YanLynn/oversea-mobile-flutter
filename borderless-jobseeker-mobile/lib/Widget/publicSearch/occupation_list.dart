import 'dart:ui';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/data/repositories/public_search_repositories.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class OccupationList extends StatefulWidget {
  final List<dynamic> data;

  //final List<dynamic> countryArr;
  OccupationList({Key key, @required this.data}) : super(key: key);
  @override
  _OccupationListState createState() => _OccupationListState();
}

class _OccupationListState extends State<OccupationList> {
  final GlobalKey<ExpansionTileCardState> cardBasicInfo = new GlobalKey();
  final AuthRepository authRepository = AuthRepository();
  Apis apis = new Apis();

  bool checked = false;
  bool clearItem = false;
  int selected_occupation_count = 0;

  List<dynamic> occupationList = [];
  final _publicSearch = new PublicSearchRepository();
  bool initialState = false;
  @override
  void initState() {
    super.initState();
    this.initialState = false;
    occupationList = List<dynamic>.from(widget.data);
    getJobseekerInit();
  }

  List jobseekerInit = [
    {
      'occupation_list': [],
      'confirm_selected_occupaton_list': [],
    }
  ];
  void clearSelectedItem() {
    setState(() {
      this
          .jobseekerInit[0]['occupation_list']
          .map((element) => {element.completed = false})
          .toList();
      var list = this
          .jobseekerInit[0]['occupation_list']
          .where((x) => x.completed == true)
          .toList();
      this.selected_occupation_count = list.length;
    });
  }

  void getJobseekerInit() async {
    final data = await _publicSearch.getJobseekerInit();

    setState(() {
      this.jobseekerInit[0]['occupation_list'] = data[0].occupation;

      this.occupationList.forEach((element) {
        this.jobseekerInit[0]['occupation_list'].forEach((e) {
          if (e.occupation_name == element.occupation_name) {
            e.completed = true;
          }
        });
        var list = this
            .jobseekerInit[0]['occupation_list']
            .where((x) => x.completed == true)
            .toList();
        this.selected_occupation_count = list.length;
      });
      this.initialState = true;
    });
  }

  checkItem($index) {
    setState(() {
      this.jobseekerInit[0]['occupation_list'][$index].completed =
          !this.jobseekerInit[0]['occupation_list'][$index].completed;

      var list = this
          .jobseekerInit[0]['occupation_list']
          .where((x) => x.completed == true)
          .toList();
      this.selected_occupation_count = list.length;
    });
  }

  void _confirmSelectedItem() {
    setState(() {
      this.jobseekerInit[0]['confirm_selected_occupaton_list'] = this
          .jobseekerInit[0]['occupation_list']
          .where((x) => x.completed == true)
          .toList();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new PublicHomeScreen(
                    authRepository: authRepository,
                    checkAlert: '',
                    selectedIndex: 1,
                    countryList: Apis.countryList,
                    occupationList: this.jobseekerInit[0]
                        ['confirm_selected_occupaton_list'],
                        
                  )));

      // Navigator.of(context).pushNamed('/public-search',
      //     arguments: this.jobseekerInit[0]['confirm_selected_occupaton_list']);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.CustomColor.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new PublicHomeScreen(
                          authRepository: authRepository,
                          checkAlert: '',
                          selectedIndex: 1,
                          countryList: Apis.countryList,
                          occupationList: occupationList,
                          
                        )));
            // Navigator.of(context)
            //     .pushNamed('/public-search', arguments: this.occupationList);
          },
        ),
        title: Text('職種', style: TextStyle(color: Colors.white)),
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
      backgroundColor: Colors.white,
      body: initialState
          ? Container(
              margin: EdgeInsets.only(left: 0, right: 0, top: 10),
              child: Form(
                  child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text('職種',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Style.CustomColor.secondaryColor)),
                        ),
                        Container(
                          child: SizedBox(
                              width: 120, // specific value
                              child: Center(
                                child: new RaisedButton(
                                  elevation: 5,
                                  child: Text(
                                    '全てクリア ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  onPressed: () => clearSelectedItem(),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  for (int i = 0;
                      i < jobseekerInit[0]['occupation_list'].length;
                      i++)
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 0),
                      child: Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 1, top: 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        // margin: EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: jobseekerInit[0]['occupation_list']
                                              [i]
                                          .occupation_name,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              child: Checkbox(
                                checkColor: Colors.white, // color of tick Mark
                                activeColor: Style.CustomColor.secondaryColor,
                                value: jobseekerInit[0]['occupation_list'][i]
                                    .completed,
                                onChanged: (value) {
                                  setState(() {
                                    checkItem(i);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: 50),

                  // button
                  // Padding(
                  //     padding: EdgeInsets.all(15),
                  //     child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.stretch,
                  //         children: <Widget>[
                  //           SizedBox(
                  //             height: 45,
                  //             child: RaisedButton(
                  //               elevation: 5.0,
                  //               color: Style.CustomColor.secondaryColor,
                  //               disabledColor: Style.CustomColor.mainColor,
                  //               disabledTextColor: Colors.white,
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(5)),
                  //               onPressed: _confirmSelectedItem,
                  //               child: new Text(
                  //                 '選択する' +
                  //                     "( " +
                  //                     (selected_occupation_count.toString() +
                  //                         " )"),
                  //                 style: Style.Customstyles.customText,
                  //               ),
                  //             ),
                  //           )
                  //         ])),

                  SizedBox(height: 30),
                ]),
              )))
          : buildLoading(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        onPressed: _confirmSelectedItem,
        label: Text(
          '選択する' + "( " + (selected_occupation_count.toString() + " )"),
          style: Style.Customstyles.customText,
        ),
        backgroundColor: Style.CustomColor.secondaryColor,
      ),
    );
  }
}

Widget buildLoading() => Center(child: CupertinoActivityIndicator());
