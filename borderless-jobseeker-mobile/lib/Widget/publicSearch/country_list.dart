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

class CountryList extends StatefulWidget {
  final List<dynamic> data;

  //final List<dynamic> countryArr;
  CountryList({Key key, @required this.data}) : super(key: key);
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final GlobalKey<ExpansionTileCardState> cardBasicInfo = new GlobalKey();
  final AuthRepository authRepository = AuthRepository();
  Apis apis = new Apis();
  bool checked = false;
  bool clearItem = false;
  String bindData = '';
  List<dynamic> countryList = [];
  final _publicSearch = new PublicSearchRepository();
  var initialState = false;
  @override
  void initState() {
    super.initState();
    this.initialState = false;
    getJobseekerInit();
    bindData = widget.data[0];
    countryList = List<dynamic>.from(widget.data[1]);
  }

  List jobseekerInit = [
    {
      'show': false,
      'continent_list': [],
      'popular_list': [],
      'confirm_popular_list': [],
      'country_list': [],
      'confirm_country_list': [],
      'main_country_list': [],
      'confirm_main_country_list': [],
      'selected_country_list': [],
      'confirm_selected_country_list': [],
      'confirm_selected_occupaton_list': [],
      'item': '',
      'btn_disabled': false,
      'checked_country': null,
      'confirm_count': 0,
      'continent_name': '',
    }
  ];
  void clearSelectedItem() {
    setState(() {
      this.clearItem = true;

      this
          .jobseekerInit[0]['continent_list']
          .map((element) => {element.checkcount = ''})
          .toList();

      this
          .jobseekerInit[0]['popular_list']
          .map((element) => {element.completed = false})
          .toList();

      this
          .jobseekerInit[0]['country_list']
          .map((element) => {element.completed = false})
          .toList();

      this
          .jobseekerInit[0]['main_country_list']
          .map((element) => {element.completed = false})
          .toList();

      this.jobseekerInit[0]['selected_country_list'] = [];
      this.jobseekerInit[0]['confirm_count'] = 0;
    });
  }

  void getJobseekerInit() async {
    final data = await _publicSearch.getJobseekerInit();

    setState(() {
      this.jobseekerInit[0]['main_country_list'] = data[0].country;
      this.jobseekerInit[0]['main_country_list'] = data[0].country;
      this.jobseekerInit[0]['confirm_main_country_list'] = data[0].country;
      this.jobseekerInit[0]['popular_list'] = data[0].popular_country;
      this.jobseekerInit[0]['confirm_popular_list'] = data[0].popular_country;
      this.jobseekerInit[0]['continent_list'] = data[0].continent;
      countforEachContinent();
      this.initialState = true;
    });
  }

  countforEachContinent() {
    this.jobseekerInit[0]['selected_country_list'] =
        List<dynamic>.from(countryList);

    if (countryList.length != 0) {
      final Map countrytempList = {};
      this.jobseekerInit[0]['continent_list'].asMap().forEach((index, country) {
        countrytempList[
            this.jobseekerInit[0]['continent_list'][index].continent_name] = 0;
      });

      countryList.forEach((element) {
        var continent = this
            .jobseekerInit[0]['main_country_list']
            .where((e) => e.country_name == element)
            .toList();
        countrytempList[continent[0].continent_name] += 1;

        this
            .jobseekerInit[0]['main_country_list']
            .map((e) => {
                  if (e.country_name == element) {e.completed = true}
                })
            .toList();

        this
            .jobseekerInit[0]['popular_list']
            .map((e) => {
                  if (e.country_name == element) {e.completed = true}
                })
            .toList();
      });

      this.jobseekerInit[0]['continent_list'].asMap().forEach((index, country) {
        if (countrytempList[country.continent_name] != 0) {
          this.jobseekerInit[0]['continent_list'][index].checkcount =
              countrytempList[country.continent_name].toString();
        }
      });
    }
  }

  dataRebind() {
    if (checked == false) {
      this.jobseekerInit[0]['selected_country_list'] =
          List<dynamic>.from(countryList);
      this.jobseekerInit[0]['country_list'].forEach((country) {
        countryList.forEach((element) {
          if (country.country_name == element) {
            country.completed = true;
          }
        });
      });
    } else {
      this.jobseekerInit[0]['country_list'].forEach((country) {
        this.jobseekerInit[0]['selected_country_list'].forEach((element) {
          if (country.country_name == element) country.completed = true;
        });
      });
    }
  }

  checkItem($index, $value) {
    setState(() {
      if ($value == 'continent') {
        this.jobseekerInit[0]['country_list'] = [];
        this.jobseekerInit[0]['confirm_country_list'] = [];
        this.jobseekerInit[0]['checked_country'] = $index;

        final temp_country = this
            .jobseekerInit[0]['main_country_list']
            .where((value) =>
                value.continent_name ==
                this.jobseekerInit[0]['checked_country'])
            .toList();

        this.jobseekerInit[0]['country_list'] = temp_country;

        if (this.countryList != null) {
          if (this.countryList.length != 0 &&
              this.bindData == 'rebind' &&
              this.clearItem == false) {
            dataRebind();
          }
        }

        this.jobseekerInit[0]['confirm_country_list'] = temp_country;
        this.jobseekerInit[0]['btn_disabled'] = true;
        this.jobseekerInit[0]['item'] = 'country';
      }
      if ($value == 'country') {
        this.checked = true;

        this.jobseekerInit[0]['country_list'][$index].completed =
            !this.jobseekerInit[0]['country_list'][$index].completed;
        if (this.jobseekerInit[0]['selected_country_list'].length != 0) {
          if (!this.jobseekerInit[0]['selected_country_list'].contains(
              this.jobseekerInit[0]['country_list'][$index].country_name)) {
            this.jobseekerInit[0]['selected_country_list'].add(
                this.jobseekerInit[0]['country_list'][$index].country_name);
            this.jobseekerInit[0]['confirm_count'] += 1;

            this
                .jobseekerInit[0]['popular_list']
                .map((element) => {
                      if (element.country_name ==
                          this
                              .jobseekerInit[0]['country_list'][$index]
                              .country_name)
                        {element.completed = true}
                    })
                .toList();
            //check data also in popular_list
          } else {
            var $selected_country_index = this
                .jobseekerInit[0]['selected_country_list']
                .indexOf(
                    this.jobseekerInit[0]['country_list'][$index].country_name);
            this
                .jobseekerInit[0]['selected_country_list']
                .removeAt($selected_country_index);
            this.jobseekerInit[0]['confirm_count'] -= 1;
            //to reduce count in confirm button

            //remove check data also in popular_list
            this
                .jobseekerInit[0]['popular_list']
                .map((element) => {
                      if (element.country_name ==
                          this
                              .jobseekerInit[0]['country_list'][$index]
                              .country_name)
                        {element.completed = false}
                    })
                .toList();
            //remove check data also in popular_list
          }
        } else {
          this
              .jobseekerInit[0]['selected_country_list']
              .add(this.jobseekerInit[0]['country_list'][$index].country_name);
          this.jobseekerInit[0]['confirm_count'] += 1;

          this
              .jobseekerInit[0]['popular_list']
              .map((element) => {
                    if (element.country_name ==
                        this
                            .jobseekerInit[0]['country_list'][$index]
                            .country_name)
                      {element.completed = true}
                  })
              .toList();
        }

        this.continentCount($value);
      }
      if ($value == "popular-country") {
        this.checked = true;
        this.jobseekerInit[0]['popular_list'][$index].completed =
            !this.jobseekerInit[0]['popular_list'][$index].completed;

        if (this.jobseekerInit[0]['popular_list'][$index].completed == true) {
          this
              .jobseekerInit[0]['selected_country_list']
              .add(this.jobseekerInit[0]['popular_list'][$index].country_name);
          this.jobseekerInit[0]['confirm_count'] += 1;

          this
              .jobseekerInit[0]['main_country_list']
              .map((element) => {
                    if (element.country_name ==
                        this
                            .jobseekerInit[0]['popular_list'][$index]
                            .country_name)
                      {element.completed = true}
                  })
              .toList();
        } else {
          var $selected_country_index = this
              .jobseekerInit[0]['selected_country_list']
              .indexOf(
                  this.jobseekerInit[0]['popular_list'][$index].country_name);

          this
              .jobseekerInit[0]['selected_country_list']
              .removeAt($selected_country_index);

          this.jobseekerInit[0]['confirm_count'] -= 1;

          this
              .jobseekerInit[0]['main_country_list']
              .map((element) => {
                    if (element.country_name ==
                        this
                            .jobseekerInit[0]['popular_list'][$index]
                            .country_name)
                      {element.completed = false}
                  })
              .toList();
        }
        this.continentCount('popular_country');
      }
    });
  }

  continentCount($value) {
    setState(() {
      if ($value == 'country') {
        final check = this
            .jobseekerInit[0]['country_list']
            .where((value) => value.completed == true)
            .toList();

        var continent_index = this
            .jobseekerInit[0]['continent_list']
            .indexWhere((value) =>
                value.continent_name ==
                this.jobseekerInit[0]['checked_country']);
        if (check.length != 0) {
          this.jobseekerInit[0]['continent_list'][continent_index].checkcount =
              check.length.toString();
        } else {
          this.jobseekerInit[0]['continent_list'][continent_index].checkcount =
              '';
        }
      } else {
        var check = this
            .jobseekerInit[0]['main_country_list']
            .where((value) => value.completed == true)
            .toList();

        final Map populartempList = {};
        this
            .jobseekerInit[0]['continent_list']
            .asMap()
            .forEach((index, country) {
          populartempList[this
              .jobseekerInit[0]['continent_list'][index]
              .continent_name] = 0;
        });

        check.forEach((element) {
          var continent = this
              .jobseekerInit[0]['main_country_list']
              .where((e) => e.country_name == element.country_name)
              .toList();
          populartempList[continent[0].continent_name] += 1;
        });

        this
            .jobseekerInit[0]['continent_list']
            .asMap()
            .forEach((index, country) {
          if (populartempList[country.continent_name] != 0) {
            this.jobseekerInit[0]['continent_list'][index].checkcount =
                populartempList[country.continent_name].toString();
          } else {
            this.jobseekerInit[0]['continent_list'][index].checkcount = '';
          }
        });
      }
      //to show count for each continent
    });
  }

  void _confirmSelectedItem() {
    setState(() {
      this.jobseekerInit[0]['confirm_selected_country_list'] =
          this.jobseekerInit[0]['selected_country_list'];
      this.jobseekerInit[0]['confirm_popular_list'] =
          this.jobseekerInit[0]['popular_list'];
      this.jobseekerInit[0]['confirm_country_list'] =
          this.jobseekerInit[0]['country_list'];
      this.jobseekerInit[0]['confirm_main_country_list'] =
          this.jobseekerInit[0]['main_country_list'];

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new PublicHomeScreen(
                    authRepository: authRepository,
                    checkAlert: '',
                    selectedIndex: 1,
                    countryList: this.jobseekerInit[0]
                        ['confirm_selected_country_list'],
                    occupationList: Apis.occupationList,
                    
                  )));

      // Navigator.of(context).pushNamed('/public-search',
      //     arguments: this.jobseekerInit[0]['confirm_selected_country_list']);
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
                          countryList: countryList,
                          occupationList: Apis.occupationList,
                          
                        )));
            // Navigator.of(context)
            //     .pushNamed('/public-search', arguments: countryList);
          },
        ),
        title: Text('勤務地', style: TextStyle(color: Colors.white)),
      ),
      drawer: MyDrawer(Apis.profileImg, Apis.userName),
      backgroundColor: Colors.white,
      body: initialState
          ? Container(
              margin: EdgeInsets.only(top: 10),
              child: Form(
                  child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text('勤務地',
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

                  Divider(
                    color: Colors.grey,
                  ),

                  //popular list
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('人気エリア',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Style.CustomColor.secondaryColor)),
                  ),
                  for (int i = 0;
                      i < jobseekerInit[0]['popular_list'].length;
                      i++)
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: jobseekerInit[0]['popular_list'][i]
                                        .country_name,
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
                              value:
                                  jobseekerInit[0]['popular_list'][i].completed,
                              onChanged: (value) {
                                setState(() {
                                  checkItem(i, 'popular-country');
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  //end popular list
                  Divider(
                    color: Colors.grey,
                  ),
                  //continent list

                  for (int i = 0;
                      i < jobseekerInit[0]['continent_list'].length;
                      i++)
                    Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 0.5, top: 0.01),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        child: ExpansionTile(
                          onExpansionChanged: ((newState) {
                            checkItem(
                                jobseekerInit[0]['continent_list'][i]
                                    .continent_name,
                                'continent');
                          }),
                          title: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            leading:
                                //continent list and count
                                RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "(" +
                                        jobseekerInit[0]['continent_list'][i]
                                            .continent_name +
                                        ") ",
                                    style: TextStyle(
                                      color: Style.CustomColor.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: this
                                        .jobseekerInit[0]['continent_list'][i]
                                        .checkcount,
                                    style: TextStyle(
                                        color: Style.CustomColor.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // end continent list and count

                            // Text("(" +
                            //     jobseekerInit[0]['continent_list'][i]
                            //         .continent_name +
                            //     ") " +
                            //     " " +
                            //     this
                            //         .jobseekerInit[0]['continent_list'][i]
                            //         .checkcount),
                          ),
                          children: <Widget>[
                            for (int j = 0;
                                j < jobseekerInit[0]['country_list'].length;
                                j++)
                              if (jobseekerInit[0]['continent_list'][i]
                                      .continent_name ==
                                  jobseekerInit[0]['country_list'][j]
                                      .continent_name)
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: jobseekerInit[0]
                                                        ['country_list'][j]
                                                    .country_name,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        child: Checkbox(
                                          checkColor: Colors
                                              .white, // color of tick Mark
                                          activeColor:
                                              Style.CustomColor.secondaryColor,
                                          value: jobseekerInit[0]
                                                  ['country_list'][j]
                                              .completed,
                                          onChanged: (value) {
                                            setState(() {
                                              checkItem(j, 'country');
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          ],
                        )),
                  //end continent list

                  SizedBox(height: 80),

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
                  //                     (this
                  //                             .jobseekerInit[0]
                  //                                 ['selected_country_list']
                  //                             .length
                  //                             .toString() +
                  //                         " )"),
                  //                 style: Style.Customstyles.customText,
                  //               ),
                  //             ),
                  //           )
                  //         ])),
                  // SizedBox(height: 30),
                ]),
              )))
          : buildLoading(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        onPressed: _confirmSelectedItem,
        label: Text(
          '選択する' +
              "( " +
              (this
                      .jobseekerInit[0]['selected_country_list']
                      .length
                      .toString() +
                  " )"),
          style: Style.Customstyles.customText,
        ),
        backgroundColor: Style.CustomColor.secondaryColor,
      ),
    );
  }
}

Widget buildLoading() => Center(child: CupertinoActivityIndicator());
