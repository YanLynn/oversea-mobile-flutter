import 'package:borderlessWorking/bloc/desired_condition_bloc/desired_condition_bloc.dart';
import 'package:borderlessWorking/data/repositories/desired_condition_repositories.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class DesiredConditionEdit extends StatefulWidget {
  @override
  _DesiredConditionEditState createState() => _DesiredConditionEditState();
}

class _DesiredConditionEditState extends State<DesiredConditionEdit> {
  final DesiredConditionBloc _bloc = DesiredConditionBloc();
  // final _formKey = GlobalKey<FormState>();
  final _desiredConditionRepository = new DesiredConditionRepository();
  final motivation = [
    "転職意欲を選択",
    "積極的に多くの企業と会いたい",
    "いいところがあれば会いたい",
    "まだ積極的には考えていない",
  ];
  final activatyStatus = [
    "転職活動状況を選択",
    "特に何もしていない",
    "情報収集（求人サイト・求人雑誌）",
    "情報収集（人材会社等に登録）",
    "企業にエントリー済み",
    "一次面接・筆記試験予定がある",
    "最終面接予定がある",
    "既に内定をもらっている"
  ];
  final changeJob = [
    "転職で最も重視することを選択",
    "特になし",
    "勤務地域（国、都市）",
    "経験を活かせる業界、職種で働きたい",
    "未経験・異なる業界、職種に挑戦したい",
    "有名企業、大手企業で働きたい",
    "安定性、将来性がある企業で働きたい",
    "新規拠点・事業の立上げに関わりたい",
    "給与・待遇面を改善したい",
    "駐在案件の海外勤務を希望"
  ];

  List<String> _isolist = [];
  final _minAnnualIncomeController = new TextEditingController();
  final _maxAnnualIncomeController = new TextEditingController();

  List<dynamic> _industries = [];
  List<dynamic> _occupations = [];
  List<dynamic> _dateList = [];
  List<dynamic> _cityList = [];
  List<dynamic> _city1List = [];
  List<dynamic> _city2List = [];
  List<dynamic> _city3List = [];
  List<dynamic> _industryList = [];
  List<dynamic> _occupationList = [];

  var desiredCondition = {};

  var desired_errors = {
    "industry_error": '',
    "occupation_error": '',
    "location_error": '',
    "location_error_status": false
  };

  _addIndustry() async {
    setState(() {
      this._industries.add({
        "id": 0,
        "jobseeker_id": null,
      });
    });
  }

  _removeIndustry(int i) async {
    setState(() {
      if (this._industries.length > 1) {
        this._industries.removeAt(i);
      }
    });
  }

  _addOccupation() async {
    setState(() {
      this._occupations.add({
        "id": 0,
        "jobseeker_id": null,
      });
    });
  }

  _removeOccupation(int i) async {
    setState(() {
      if (this._occupations.length > 1) {
        this._occupations.removeAt(i);
      }
    });
  }

  void getRequiredList() async {
    final data = await _desiredConditionRepository.getCarrerRequiredList();
    _isolist.add('通貨単位を選択');
    data[0].iso_list.forEach((data) {
      _isolist.add(data);
    });

    // setState(() {

    // });
  }

  List _desiredCondition = [];
  // List<dynamic> _dateList = [];
  // List<dynamic> _city1List = [];
  // List<dynamic> _city2List = [];
  // List<dynamic> _city3List = [];
  // List<dynamic> _industries = [];
  // List<dynamic> _industryList = [];
  // List<dynamic> _occupations = [];
  // List<dynamic> _occupationList = [];

  // void getDesiredCondition() async {
  //   final data = await _desiredConditionRepository.getDesiredCondition();
  //   setState(() {
  //     data.forEach((data) {
  //       _desiredCondition.add(data);
  //     });
  //   });

  //   _dateList = _desiredCondition[0].date_list;
  //   if(_dateList[0] != "転職希望時期を選択")
  //   _dateList.insert(0, "転職希望時期を選択");
  //   List<dynamic> _cityList = _desiredCondition[0].city_list;
  //   _city1List = _cityList.map((value) => value).toList();
  //   _city2List = _cityList.map((value) => value).toList();
  //   _city3List = _cityList.map((value) => value).toList();

  //   if(_city1List[0]["country_name"] != "第1希望を選択")
  //   _city1List.insert(0, {"id": null, "city_name" : null, "country_name" : "第1希望を選択"});

  //   if(_city2List[0]["country_name"] != "第2希望を選択")
  //   _city2List.insert(0, {"id": null, "city_name" : null, "country_name" : "第2希望を選択"});

  //   if(_city3List[0]["country_name"] != "第3希望を選択")
  //   _city3List.insert(0, {"id": null, "city_name" : null, "country_name" : "第3希望を選択"});

  //   _industries = _desiredCondition[0].industries;
  //   _industryList = _desiredCondition[0].industry_list;
  //   _occupations = _desiredCondition[0].occupations;
  //   _occupationList = _desiredCondition[0].occupation_list;
  // }

  @override
  void initState() {
    _bloc.add(GetDesiredCondition());
    super.initState();
    getRequiredList();
    // getDesiredCondition();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Navigator.of(context).popAndPushNamed('/profile');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new ExpansionTileCardDemo(saveSuccess: null)));
            },
          ),
          title: Text('希望条件', style: TextStyle(color: Colors.white)),
          backgroundColor: Style.CustomColor.mainColor,
        ),
        backgroundColor: Colors.white,
        body: BlocProvider<DesiredConditionBloc>(
          create: (_) => _bloc,
          child: BlocListener<DesiredConditionBloc, DesiredConditionState>(
            listener: (context, state) {
              if (state is UpdateSuccess) {
                // Navigator.of(context).popAndPushNamed('/profile');
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new ExpansionTileCardDemo(saveSuccess: "保存しました。")));
              }
              if (state is DesiredConditionSuccess) {
                _desiredCondition = state.desiredCondition;

                _dateList = _desiredCondition[0].date_list;
                if (_dateList[0] != "転職希望時期を選択")
                  _dateList.insert(0, "転職希望時期を選択");

                var dateVal = _dateList.where((c) => c == _desiredCondition[0].desired_condition["desired_change_period"]).toList().length;
                if (dateVal < 1) {
                  _desiredCondition[0]
                      .desired_condition["desired_change_period"] = '転職希望時期を選択';
                }

                _cityList = _desiredCondition[0].city_list;

                _city1List = _cityList.map((value) => value).toList();
                _city2List = _cityList.map((value) => value).toList();
                _city3List = _cityList.map((value) => value).toList();

                if (_city1List[0]["country_name"] != "第1希望を選択")
                  _city1List.insert(0,
                      {"id": 0, "city_name": null, "country_name": "第1希望を選択"});

                if (_city2List[0]["country_name"] != "第2希望を選択")
                  _city2List.insert(0,
                      {"id": 0, "city_name": null, "country_name": "第2希望を選択"});

                if (_city3List[0]["country_name"] != "第3希望を選択")
                  _city3List.insert(0,
                      {"id": 0, "city_name": null, "country_name": "第3希望を選択"});
                _industries = _desiredCondition[0].industries;
                if (_industries.length < 1) _addIndustry();

                _industryList = _desiredCondition[0].industry_list;
                if (_industryList[0]["id"] != null)
                  _industryList
                      .insert(0, {"id": null, "industry_name": "業種を選択"});

                _occupations = _desiredCondition[0].occupations;
                if (_occupations.length < 1) _addOccupation();

                _occupationList = _desiredCondition[0].occupation_list;
                if (_occupationList[0]["id"] != null)
                  _occupationList
                      .insert(0, {"id": null, "occupation_name": "職種を選択"});

                _maxAnnualIncomeController.text = _desiredCondition[0]
                    .desired_condition["desired_max_annual_income"];
                _minAnnualIncomeController.text = _desiredCondition[0]
                    .desired_condition["desired_min_annual_income"];
              }
            },
            child: BlocBuilder<DesiredConditionBloc, DesiredConditionState>(
              builder: (context, state) {
                if (state is DesiredConditionSuccess) {
                  // _desiredCondition = state.desiredCondition;
                  // List<dynamic> _dateList = _desiredCondition[0].date_list;
                  // if (_dateList[0] != "転職希望時期を選択")
                  //   _dateList.insert(0, "転職希望時期を選択");

                  // var dateVal = _dateList.where((c) => c == _desiredCondition[0].desired_condition["desired_change_period"]).toList().length;
                  // if(dateVal < 1) {
                  //   _desiredCondition[0].desired_condition["desired_change_period"] = null;
                  // }

                  // List<dynamic> _cityList = _desiredCondition[0].city_list;

                  // List<dynamic> _city1List =
                  //     _cityList.map((value) => value).toList();
                  // List<dynamic> _city2List =
                  //     _cityList.map((value) => value).toList();
                  // List<dynamic> _city3List =
                  //     _cityList.map((value) => value).toList();

                  // if (_city1List[0]["country_name"] != "第1希望を選択")
                  //   _city1List.insert(0, {
                  //     "id": null,
                  //     "city_name": null,
                  //     "country_name": "第1希望を選択"
                  //   });

                  // if (_city2List[0]["country_name"] != "第2希望を選択")
                  //   _city2List.insert(0, {
                  //     "id": null,
                  //     "city_name": null,
                  //     "country_name": "第2希望を選択"
                  //   });

                  // if (_city3List[0]["country_name"] != "第3希望を選択")
                  //   _city3List.insert(0, {
                  //     "id": null,
                  //     "city_name": null,
                  //     "country_name": "第3希望を選択"
                  //   });

                  // _industries = _desiredCondition[0].industries;
                  // List<dynamic> _industryList =
                  //     _desiredCondition[0].industry_list;
                  // if (_industryList[0]["id"] != null)
                  //   _industryList
                  //       .insert(0, {"id": null, "industry_name": "業種を選択"});

                  // _occupations = _desiredCondition[0].occupations;
                  // List<dynamic> _occupationList =
                  //     _desiredCondition[0].occupation_list;
                  // if (_occupationList[0]["id"] != null)
                  //   _occupationList
                  //       .insert(0, {"id": null, "occupation_name": "職種を選択"});

                  // _maxAnnualIncomeController.text = _desiredCondition[0].desired_condition["desired_max_annual_income"];
                  // _minAnnualIncomeController.text = _desiredCondition[0].desired_condition["desired_min_annual_income"];

                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("転職意欲"),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("転職意欲を選択"),
                                    isExpanded: true,
                                    value: _desiredCondition[0]
                                        .desired_condition["job_change_reason"],
                                    items: motivation.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "転職意欲を選択") {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "job_change_reason"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "job_change_reason"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("転職活動状況"),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("転職活動状況を選択"),
                                    isExpanded: true,
                                    value:
                                        _desiredCondition[0].desired_condition[
                                            "job_search_activity"],
                                    items: activatyStatus.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "転職活動状況を選択") {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "job_search_activity"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "job_search_activity"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("転臓で最も重視すること"),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("転職で最も重視することを選択"),
                                    isExpanded: true,
                                    value:
                                        _desiredCondition[0].desired_condition[
                                            "main_fact_when_change"],
                                    items: changeJob.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "転職で最も重視することを選択") {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "main_fact_when_change"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "main_fact_when_change"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("転職希望時期"),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("転職希望時期を選択"),
                                    isExpanded: true,
                                    value: _desiredCondition[0]
                                        .desired_condition[
                                            "desired_change_period"]
                                        .toString(),
                                    items: _dateList.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem<dynamic>(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "転職希望時期を選択") {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_change_period"] = '転職希望時期を選択';
                                        } else {
                                          _desiredCondition[0]
                                                      .desired_condition[
                                                  "desired_change_period"] =
                                              value.toString();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Text("勤務希望地"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("第1希望を選択"),
                                    isExpanded: true,
                                    value:
                                        _desiredCondition[0].desired_condition[
                                                    "desired_location_1"] ==
                                                0
                                            ? null
                                            : _desiredCondition[0]
                                                    .desired_condition[
                                                "desired_location_1"],
                                    items: _city1List.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item["country_name"]),
                                          value: item["id"],
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == 0) {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_1"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_1"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("第2希望を選択"),
                                    isExpanded: true,
                                    value:
                                        _desiredCondition[0].desired_condition[
                                                    "desired_location_2"] ==
                                                0
                                            ? null
                                            : _desiredCondition[0]
                                                    .desired_condition[
                                                "desired_location_2"],
                                    items: _city2List.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item["country_name"]),
                                          value: item["id"],
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == 0) {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_2"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_2"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    hint: Text("第3希望を選択"),
                                    isExpanded: true,
                                    value:
                                        _desiredCondition[0].desired_condition[
                                                    "desired_location_3"] ==
                                                0
                                            ? null
                                            : _desiredCondition[0]
                                                    .desired_condition[
                                                "desired_location_3"],
                                    items: _city3List.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item["country_name"]),
                                          value: item["id"],
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == 0) {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_3"] = null;
                                        } else {
                                          _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_location_3"] = value;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            ),
                          ),

                          // Industry List
                          Container(
                            alignment: Alignment.topLeft,
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("希望業種"),
                                IconButton(
                                  icon: Icon(Icons.add_circle),
                                  onPressed: () {
                                    _addIndustry();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor:
                                            Colors.white, // color of tick Mark
                                        activeColor:
                                            Style.CustomColor.secondaryColor,
                                        // value: _desiredCondition[0].desired_condition[ "desired_industry_status"] == 1 ? true : false,
                                        value: (_desiredCondition[0]
                                                            .desired_condition[
                                                        "desired_industry_status"] ==
                                                    1 ||
                                                _desiredCondition[0]
                                                            .desired_condition[
                                                        "desired_industry_status"] ==
                                                    true)
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              _desiredCondition[0]
                                                      .desired_condition[
                                                  "desired_industry_status"] = 1;
                                            } else {
                                              _desiredCondition[0]
                                                      .desired_condition[
                                                  "desired_industry_status"] = 0;
                                            }
                                          });
                                        },
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'こだわらない',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if (_desiredCondition[0].desired_condition[
                                            "desired_industry_status"] ==
                                        0 ||
                                    _desiredCondition[0].desired_condition[
                                            "desired_industry_status"] ==
                                        null)
                                  for (int i = 0; i < _industries.length; i++)
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(),
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              hint: Text("業種を選択"),
                                              isExpanded: true,
                                              value: _industries[i]["id"] == 0
                                                  ? null
                                                  : _industries[i]["id"],
                                              items: _industryList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["industry_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "業種を選択") {
                                                    _industries[i]["id"] = null;
                                                  } else {
                                                    _industries[i]["id"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        if (_industries.length > 1)
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    if (_industries.length > 1)
                                                      _removeIndustry(i);
                                                  },
                                                ),
                                              )),
                                      ],
                                    ),
                              ],
                            ),
                          ),

                          // Occupation List
                          Container(
                            alignment: Alignment.topLeft,
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("希望職種"),
                                IconButton(
                                  icon: Icon(Icons.add_circle),
                                  onPressed: () {
                                    _addOccupation();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        checkColor:
                                            Colors.white, // color of tick Mark
                                        activeColor:
                                            Style.CustomColor.secondaryColor,
                                        // value: _desiredCondition[0].desired_condition[ "desired_occupation_status"] == 1 ? true : false,
                                        value: (_desiredCondition[0]
                                                            .desired_condition[
                                                        "desired_occupation_status"] ==
                                                    1 ||
                                                _desiredCondition[0]
                                                            .desired_condition[
                                                        "desired_occupation_status"] ==
                                                    true)
                                            ? true
                                            : false,
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              _desiredCondition[0]
                                                      .desired_condition[
                                                  "desired_occupation_status"] = 1;
                                            } else {
                                              _desiredCondition[0]
                                                      .desired_condition[
                                                  "desired_occupation_status"] = 0;
                                            }
                                          });
                                        },
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'こだわらない',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if (_desiredCondition[0].desired_condition[
                                            "desired_occupation_status"] ==
                                        0 ||
                                    _desiredCondition[0].desired_condition[
                                            "desired_occupation_status"] ==
                                        null)
                                  for (int i = 0; i < _occupations.length; i++)
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(),
                                            child: DropdownButtonFormField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              hint: Text("職種を選択"),
                                              isExpanded: true,
                                              value: _occupations[i]["id"] == 0
                                                  ? null
                                                  : _occupations[i]["id"],
                                              items:
                                                  _occupationList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(item[
                                                        "occupation_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                print("val");
                                                print(value);
                                                setState(() {
                                                  if (value == "職種を選択") {
                                                    _occupations[i]["id"] =
                                                        null;
                                                  } else {
                                                    _occupations[i]["id"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        if (_occupations.length > 1)
                                          Expanded(
                                              flex: 1,
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    if (_occupations.length > 1)
                                                      _removeOccupation(i);
                                                  },
                                                ),
                                              )
                                              // Container(
                                              //   child: IconButton(
                                              //     icon: _occupations.length > 1
                                              //         ? Icon(
                                              //             Icons.remove_circle,
                                              //             color: Colors.red,
                                              //           )
                                              //         : Icon(
                                              //             Icons.remove_circle,
                                              //             color: Colors.black26,
                                              //           ),
                                              //     onPressed: () {
                                              //       if (_occupations.length > 1)
                                              //         _removeOccupation(i);
                                              //     },
                                              //   ),
                                              // )
                                              ),
                                      ],
                                    ),
                              ],
                            ),
                          ),

                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Text("希望年収"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("最低年収"),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '金額を入力',
                                      hintStyle:
                                          TextStyle(color: Color(0xffc1c1c1)),
                                      contentPadding: const EdgeInsets.all(10),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blueGrey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    controller: this._minAnnualIncomeController,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  alignment: Alignment.topLeft,
                                  child: Text("最高年収"),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '金額を入力',
                                            hintStyle: TextStyle(
                                                color: Color(0xffc1c1c1)),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.blueGrey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          controller:
                                              this._maxAnnualIncomeController,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(),
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            // hintText: ' 通貨単位を選択',
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          hint: Text("通貨単位を選択"),
                                          isExpanded: true,
                                          value: _desiredCondition[0]
                                                  .desired_condition[
                                              "desired_currency"],
                                          items: _isolist.map((item) {
                                            if (item != null) {
                                              return DropdownMenuItem<dynamic>(
                                                child: Text(item),
                                                value: item,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              if (value == "通貨単位を選択") {
                                                _desiredCondition[0]
                                                        .desired_condition[
                                                    "desired_currency"] = null;
                                              } else {
                                                _desiredCondition[0]
                                                        .desired_condition[
                                                    "desired_currency"] = value;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 15.0, bottom: 10.0, left: 10, right: 10),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 45,
                                      child: RaisedButton(
                                          elevation: 5.0,
                                          color:
                                              Style.CustomColor.secondaryColor,
                                          disabledColor:
                                              Style.CustomColor.mainColor,
                                          disabledTextColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onPressed: () => {
                                                if (_desiredCondition.length >
                                                    0)
                                                  {
                                                    _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_max_annual_income"] =
                                                        _maxAnnualIncomeController
                                                            .text,
                                                    _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_min_annual_income"] =
                                                        _minAnnualIncomeController
                                                            .text,
                                                    if (_desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_industry_status"] ==
                                                        1)
                                                      {
                                                        _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_industry_status"] = true,
                                                        _industries = [],
                                                      }
                                                    else
                                                      {
                                                        _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_industry_status"] = false,
                                                      },
                                                    if (_desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_occupation_status"] ==
                                                        1)
                                                      {
                                                        _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_occupation_status"] = true,
                                                        _occupations = [],
                                                      }
                                                    else
                                                      {
                                                        _desiredCondition[0]
                                                                .desired_condition[
                                                            "desired_occupation_status"] = false,
                                                      }
                                                  },
                                                BlocProvider.of<
                                                            DesiredConditionBloc>(
                                                        context)
                                                    .add(
                                                  UpdateButtonPressed(
                                                      desiredCondition:
                                                          _desiredCondition[0]
                                                              .desired_condition,
                                                      industries: _industries,
                                                      occupations:
                                                          _occupations),
                                                )
                                              },
                                          child: Text(
                                            "保存する",
                                            style:
                                                Style.Customstyles.customText,
                                          )),
                                    )
                                  ])),

                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
                }
                return progressLoading();
              },
            ),
          ),
        ));
  }
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
