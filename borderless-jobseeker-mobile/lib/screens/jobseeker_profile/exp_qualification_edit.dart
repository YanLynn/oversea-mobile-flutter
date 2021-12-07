import 'package:borderlessWorking/bloc/exp_qualifications_bloc/exp_qualifications_bloc.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpQualificationEdit extends StatefulWidget {
  @override
  _ExpQualificationEditState createState() => _ExpQualificationEditState();
}

class _ExpQualificationEditState extends State<ExpQualificationEdit> {
  final ExpQualificationsBloc _bloc = ExpQualificationsBloc();

  final _studyAbroadPeriod = [
    "期間を選択",
    "半年未満",
    "半年～1年",
    "1年～2年",
    "2年～3年",
    "4年以上",
  ];

  final _studyAbroadPurpose = [
    "留学の目的を選択",
    "語学留学",
    "大学",
    "MBA",
    "MBA以外の修士号",
    "その他",
  ];

  final _workingAbroadPeriod = [
    "期間を選択",
    "1年未満",
    "1年～2年",
    "2年～3年",
    "4年以上",
  ];

  final _langLevelList = [
    "語学レベルを選択",
    "挨拶程度",
    "日常会話",
    "ビジネスレベル",
    "ネイティブレベル",
  ];

  List _expQuaData = [];

  List<dynamic> _industryHistory = [];
  List<dynamic> _industryHistoryToSave = [];
  List<dynamic> _industryHistoryDeleteId = [];

  List<dynamic> _studyAbroad = [];
  List<dynamic> _studyAbroadToSave = [];
  List<dynamic> _studyAbroadDeleteId = [];

  List<dynamic> _workingAbroad = [];
  List<dynamic> _workingAbroadToSave = [];
  List<dynamic> _workingAbroadDeleteId = [];

  List<TextEditingController> _expYearController = [];
  List<dynamic> _industryList = [];
  List<dynamic> _occupationList = [];
  List<dynamic> _positionList = [];
  List<dynamic> _countryList = [];

  List<dynamic> _langList = [];
  List<dynamic> _langLevel = [];
  List<dynamic> _langLevelToSave = [];
  List<dynamic> _langLevelDeleteId = [];

  List<dynamic> _otherQuaToSave = [];
  List<dynamic> _visaToSave = [];

  final _toeicController = new TextEditingController();
  final _otherLangQuaController = new TextEditingController();
  final _otherQuaController = new TextEditingController();

  @override
  void initState() {
    _bloc.add(GetExpQualification());
    super.initState();
  }

  _changeArrayIndustryHistory(List array) {
    for (int i = 0; i < array.length; i++) {
      this._industryHistoryToSave.add({
        "industry_history_id": array[i]["id"],
        "experience_year": _expYearController[i].text,
        "experience_industry": array[i]["industry_id"],
        "experience_occupation": array[i]["occupation_keyword_id"],
        "experience_position": array[i]["position_id"],
      });
    }
  }

  _changeArrayStudyAbroad(List array) {
    for (int i = 0; i < array.length; i++) {
      this._studyAbroadToSave.add({
        "study_abroad_id": array[i]["id"],
        "study_abroad_country": array[i]["country_id"],
        "study_abroad_period": array[i]["period"],
        "study_abroad_purpose": array[i]["purpose"],
      });
    }
  }

  _changeArrayWorkingAbroad(List array) {
    for (int i = 0; i < array.length; i++) {
      this._workingAbroadToSave.add({
        "working_abroad_id": array[i]["id"],
        "working_abroad_country": array[i]["country_id"],
        "working_abroad_position": array[i]["position_id"],
        "working_abroad_period": array[i]["period"],
      });
    }
  }

  _changeArrayLangLevel(List array) {
    for (int i = 0; i < array.length; i++) {
      if (array[i]["language_id"] != 0 && array[i]["language_id"] != null) {
        this._langLevelToSave.add({
          "foreign_language_id": array[i]["id"],
          "foreign_language": array[i]["language_id"],
          "language_level": array[i]["language_level"],
        });
      } else {
        if (array[i]["id"] != 0 && array[i]["id"] != null) {
          this._langLevelDeleteId.add(array[i]["id"]);
        }
      }
    }
  }

  _changeArrays() {
    this._otherQuaToSave.add({
      "TOEIC_score": _toeicController.text,
      "language_qualifications": _otherLangQuaController.text,
      "qualifications": _otherQuaController.text,
    });

    this._visaToSave.add({
      "country": _expQuaData[0].jobseeker_detail["visa_country"],
      "status": _expQuaData[0].jobseeker_detail["visa_status"],
    });
  }

  _addIndustryHistory() async {
    setState(() {
      this._industryHistory.add({
        "id": 0,
        "experience_year": null,
        "industry_id": null,
        "occupation_keyword_id": null,
        "position_id": null,
      });
      _expYearController.add(TextEditingController());
    });
  }

  _removeIndustryHistory(int i, historyId) async {
    setState(() {
      if (this._industryHistory.length > 1) {
        if (historyId != 0 && historyId != null) {
          this._industryHistoryDeleteId.add(historyId);
        }
        this._industryHistory.removeAt(i);
        _expYearController.removeAt(i);
      }
    });
  }

  _addStudyAbroad() async {
    setState(() {
      this._studyAbroad.add({
        "id": 0,
        "country_id": null,
        "period": "期間を選択",
        "purpose": "留学の目的を選択",
      });
    });
  }

  _removeStudyAbroad(int i, studyId) async {
    setState(() {
      if (this._studyAbroad.length > 1) {
        if (studyId != 0 && studyId != null) {
          this._studyAbroadDeleteId.add(studyId);
        }
        this._studyAbroad.removeAt(i);
      }
    });
  }

  _addWorkingAbroad() async {
    setState(() {
      this._workingAbroad.add({
        "id": 0,
        "country_id": null,
        "period": "期間を選択",
        "position_id": null,
      });
    });
  }

  _removeWorkingAbroad(int i, workingId) async {
    setState(() {
      if (this._workingAbroad.length > 1) {
        if (workingId != 0 && workingId != null) {
          this._workingAbroadDeleteId.add(workingId);
        }
        this._workingAbroad.removeAt(i);
      }
    });
  }

  _addLangLevel() async {
    print(_langLevel);
    setState(() {
      this._langLevel.add({
        "id": 0,
        "language_id": null,
        "language_level": "語学レベルを選択",
      });
    });
  }

  _removeLangLevel(int i, langId) async {
    setState(() {
      if (this._langLevel.length > 1) {
        if (langId != 0 && langId != null) {
          this._langLevelDeleteId.add(langId);
        }
        this._langLevel.removeAt(i);
      }
    });
  }

  @override
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
          title: Text('経験・資格', style: TextStyle(color: Colors.white)),
          backgroundColor: Style.CustomColor.mainColor,
        ),
        backgroundColor: Colors.white,
        body: BlocProvider<ExpQualificationsBloc>(
            create: (_) => _bloc,
            child: BlocListener<ExpQualificationsBloc, ExpQualificationsState>(
              listener: (context, state) {
                if (state is UpdateSuccess) {
                  // Navigator.of(context).popAndPushNamed('/profile');
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ExpansionTileCardDemo(
                              saveSuccess: "保存しました。")));
                }
                if (state is ExpQualificationsSuccess) {
                  _expQuaData = state.expQua;
                  _industryHistory = _expQuaData[0].industry_histories;
                  _studyAbroad = _expQuaData[0].education_overseas;
                  _workingAbroad = _expQuaData[0].working_overseas;
                  _langLevel = _expQuaData[0].languages_levels;

                  if (_industryHistory.length == 0) {
                    _addIndustryHistory();
                  } else {
                    _expYearController = [];
                    for (int i = 0; i < _industryHistory.length; i++) {
                      _expYearController.add(TextEditingController());
                      _expYearController[i].text =
                          _industryHistory[i]["experience_year"];
                    }
                  }

                  _toeicController.text =
                      _expQuaData[0].jobseeker_detail["toeic_score"];
                  _otherQuaController.text =
                      _expQuaData[0].jobseeker_detail["other_certificate"];
                  _otherLangQuaController.text = _expQuaData[0]
                      .jobseeker_detail["other_language_certificate"];

                  _expQuaData[0].jobseeker_detail["visa_status"] =
                      _expQuaData[0].jobseeker_detail["visa_status"] == null
                          ? 0
                          : _expQuaData[0].jobseeker_detail["visa_status"];

                  if (_studyAbroad.length == 0) _addStudyAbroad();

                  if (_workingAbroad.length == 0) _addWorkingAbroad();

                  if (_langLevel.length == 0) _addLangLevel();

                  _industryList = _expQuaData[0].industries;
                  if (_industryList[0]["id"] != null)
                    _industryList
                        .insert(0, {"id": null, "industry_name": "経験業種を選択"});

                  _occupationList = _expQuaData[0].occupations;
                  if (_occupationList[0]["id"] != null)
                    _occupationList
                        .insert(0, {"id": null, "occupation_name": "経験職種を選択"});

                  _positionList = _expQuaData[0].positions;
                  if (_positionList[0]["id"] != null)
                    _positionList
                        .insert(0, {"id": null, "position_name": "ポジションを選択"});

                  _countryList = _expQuaData[0].countries;
                  if (_countryList[0]["id"] != null)
                    _countryList
                        .insert(0, {"id": 0, "country_name": "国・地域名を選択"});

                  _langList = _expQuaData[0].languages;
                  if (_langList[0]["id"] != null)
                    _langList.insert(0, {"id": 0, "language_name": "外国語を選択"});
                }
              },
              child: BlocBuilder<ExpQualificationsBloc, ExpQualificationsState>(
                  builder: (context, state) {
                if (state is ExpQualificationsSuccess) {
                  // _expQuaData = state.expQua;
                  // _industryHistory = _expQuaData[0].industry_histories;

                  // if(_expQuaData[0].industry_histories.length > 0 && _industryHistory.length == 0)
                  // _changeArrayIndustryHistory(_expQuaData[0].industry_histories);

                  // _studyAbroad = _expQuaData[0].education_overseas;
                  // if(_expQuaData[0].education_overseas.length > 0 && _studyAbroad.length == 0)
                  // _changeArrayStudyAbroad(_expQuaData[0].education_overseas);

                  // _workingAbroad = _expQuaData[0].working_overseas;
                  // if(_expQuaData[0].education_overseas.length > 0 && _studyAbroad.length == 0)
                  // _changeArrayStudyAbroad(_expQuaData[0].education_overseas);

                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          // 経験業種・職種
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 5.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "経験業種・職種",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          _addIndustryHistory();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                if (_industryHistory.length > 0)
                                  for (int i = 0;
                                      i < _industryHistory.length;
                                      i++)
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 5.0, 15.0, 5.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "経験年数",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
                                            decoration: BoxDecoration(),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText: '経験年数を入力',
                                                hintStyle: TextStyle(
                                                    color: Color(0xffc1c1c1)),
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blueGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              controller: _expYearController[i],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "経験業種",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("経験業種を選択"),
                                              isExpanded: true,
                                              value: _industryHistory[i]
                                                          ["industry_id"] ==
                                                      0
                                                  ? null
                                                  : _industryHistory[i]
                                                      ["industry_id"],
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
                                                  if (value == "経験業種を選択") {
                                                    _industryHistory[i]
                                                        ["industry_id"] = null;
                                                  } else {
                                                    _industryHistory[i]
                                                        ["industry_id"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "経験職種",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("経験職種を選択"),
                                              isExpanded: true,
                                              value: _industryHistory[i][
                                                          "occupation_keyword_id"] ==
                                                      0
                                                  ? null
                                                  : _industryHistory[i]
                                                      ["occupation_keyword_id"],
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
                                                setState(() {
                                                  if (value == "経験職種を選択") {
                                                    _industryHistory[i][
                                                            "occupation_keyword_id"] =
                                                        null;
                                                  } else {
                                                    _industryHistory[i][
                                                            "occupation_keyword_id"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "ポジション",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("ポジションを選択"),
                                              isExpanded: true,
                                              value: _industryHistory[i]
                                                          ["position_id"] ==
                                                      0
                                                  ? null
                                                  : _industryHistory[i]
                                                      ["position_id"],
                                              items: _positionList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["position_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "ポジションを選択") {
                                                    _industryHistory[i]
                                                        ["position_id"] = null;
                                                  } else {
                                                    _industryHistory[i]
                                                        ["position_id"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          if (_industryHistory.length > 1)
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),

                                                // ? Icon(
                                                //     Icons.remove_circle,
                                                //     color: Colors.red,
                                                //   )
                                                // : Icon(
                                                //     Icons.remove_circle,
                                                //     color: Colors.black26,
                                                //   ),
                                                onPressed: () {
                                                  if (_industryHistory.length >
                                                      1)
                                                    _removeIndustryHistory(
                                                        i,
                                                        _industryHistory[i]
                                                            ["id"]);
                                                },
                                              ),
                                            ),
                                          if (i < (_industryHistory.length - 1))
                                            Divider(
                                              color: Style
                                                  .CustomColor.secondaryColor,
                                            ),
                                        ],
                                      ),
                                    ),

                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 5.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "留学経験",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          _addStudyAbroad();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                if (_studyAbroad.length > 0)
                                  for (int i = 0; i < _studyAbroad.length; i++)
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 5.0, 15.0, 5.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "国・地域名",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("国・地域名を選択"),
                                              isExpanded: true,
                                              value: _studyAbroad[i]
                                                          ["country_id"] ==
                                                      0
                                                  ? null
                                                  : _studyAbroad[i]
                                                      ["country_id"],
                                              // value: _langLevel[i]["language_id"] != null ? int.parse(_langLevel[i]["language_id"]) : null,
                                              items: _countryList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["country_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == 0) {
                                                    _studyAbroad[i]
                                                        ["country_id"] = null;
                                                  } else {
                                                    _studyAbroad[i]
                                                        ["country_id"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "期間",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("期間を選択"),
                                              isExpanded: true,
                                              value: _studyAbroad[i]
                                                          ["period"] ==
                                                      null
                                                  ? null
                                                  : _studyAbroad[i]["period"],
                                              items: _studyAbroadPeriod
                                                  .map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "期間を選択") {
                                                    _studyAbroad[i]["period"] =
                                                        null;
                                                  } else {
                                                    _studyAbroad[i]["period"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "留学の目的",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("留学の目的を選択"),
                                              isExpanded: true,
                                              value: _studyAbroad[i]
                                                          ["purpose"] ==
                                                      0
                                                  ? null
                                                  : _studyAbroad[i]["purpose"],
                                              items: _studyAbroadPurpose
                                                  .map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "留学の目的を選択") {
                                                    _studyAbroad[i]["purpose"] =
                                                        null;
                                                  } else {
                                                    _studyAbroad[i]["purpose"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          if (_studyAbroad.length > 1)
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  if (_studyAbroad.length > 1)
                                                    _removeStudyAbroad(i,
                                                        _studyAbroad[i]["id"]);
                                                },
                                              ),
                                            ),
                                          // Container(
                                          //   child: IconButton(
                                          //     icon: _studyAbroad.length > 1
                                          //         ? Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.red,
                                          //           )
                                          //         : Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.black26,
                                          //           ),
                                          //     onPressed: () {
                                          //       if (_studyAbroad.length > 1)
                                          //         _removeStudyAbroad(
                                          //             i, _studyAbroad[i]["id"]);
                                          //     },
                                          //   ),
                                          // ),
                                          if (i < (_studyAbroad.length - 1))
                                            Divider(
                                              color: Style
                                                  .CustomColor.secondaryColor,
                                            ),
                                        ],
                                      ),
                                    ),

                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 5.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "海外での勤務経験",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          _addWorkingAbroad();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                if (_workingAbroad.length > 0)
                                  for (int i = 0;
                                      i < _workingAbroad.length;
                                      i++)
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 5.0, 15.0, 5.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "国・地域名",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("国・地域名を選択"),
                                              isExpanded: true,
                                              value: _workingAbroad[i]
                                                          ["country_id"] ==
                                                      0
                                                  ? null
                                                  : _workingAbroad[i]
                                                      ["country_id"],
                                              items: _countryList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["country_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == 0) {
                                                    _workingAbroad[i]
                                                        ["country_id"] = null;
                                                  } else {
                                                    _workingAbroad[i]
                                                        ["country_id"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "期間",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("期間を選択"),
                                              isExpanded: true,
                                              value: _workingAbroad[i]
                                                          ["period"] ==
                                                      null
                                                  ? null
                                                  : _workingAbroad[i]["period"],
                                              items: _workingAbroadPeriod
                                                  .map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "期間を選択") {
                                                    _workingAbroad[i]
                                                        ["period"] = null;
                                                  } else {
                                                    _workingAbroad[i]
                                                        ["period"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "ポジション",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("ポジションを選択"),
                                              isExpanded: true,
                                              value: _workingAbroad[i]
                                                          ["position_id"] ==
                                                      0
                                                  ? null
                                                  : _workingAbroad[i]
                                                      ["position_id"],
                                              items: _positionList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["position_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == "ポジションを選択") {
                                                    _workingAbroad[i]
                                                        ["position_id"] = null;
                                                  } else {
                                                    _workingAbroad[i]
                                                        ["position_id"] = value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          if (_workingAbroad.length > 1)
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  if (_workingAbroad.length > 1)
                                                    _removeWorkingAbroad(
                                                        i,
                                                        _workingAbroad[i]
                                                            ["id"]);
                                                },
                                              ),
                                            ),
                                          // Container(
                                          //   child: IconButton(
                                          //     icon: _workingAbroad.length > 1
                                          //         ? Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.red,
                                          //           )
                                          //         : Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.black26,
                                          //           ),
                                          //     onPressed: () {
                                          //       if (_workingAbroad.length > 1)
                                          //         _removeWorkingAbroad(i,
                                          //             _workingAbroad[i]["id"]);
                                          //     },
                                          //   ),
                                          // ),
                                          if (i < (_workingAbroad.length - 1))
                                            Divider(
                                              color: Style
                                                  .CustomColor.secondaryColor,
                                            ),
                                        ],
                                      ),
                                    ),

                                // Visa
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(17.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "就労ビザ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Align(
                                            child: new Text('有り'),
                                            alignment: Alignment.topLeft),
                                        leading: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Style
                                                      .CustomColor.mainColor),
                                          value: 1,
                                          groupValue: _expQuaData[0]
                                              .jobseeker_detail["visa_status"],
                                          onChanged: (value) {
                                            setState(() {
                                              _expQuaData[0].jobseeker_detail[
                                                  "visa_status"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        title: Align(
                                            child: new Text('無し'),
                                            alignment: Alignment.topLeft),
                                        leading: Radio(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Style
                                                      .CustomColor.mainColor),
                                          value: 0,
                                          groupValue: _expQuaData[0]
                                              .jobseeker_detail["visa_status"],
                                          onChanged: (value) {
                                            setState(() {
                                              _expQuaData[0].jobseeker_detail[
                                                  "visa_status"] = value;
                                              _expQuaData[0].jobseeker_detail[
                                                  "visa_country"] = null;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 7.0,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "国・地域名",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 15.0),
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
                                    hint: Text("国・地域名を選択 "),
                                    isExpanded: true,
                                    disabledHint: Text("国・地域名を選択 "),
                                    value: _expQuaData[0].jobseeker_detail[
                                                "visa_country"] !=
                                            null
                                        ? int.parse(_expQuaData[0]
                                            .jobseeker_detail["visa_country"])
                                        : null,
                                    items: _countryList.map((item) {
                                      if (item != null) {
                                        return DropdownMenuItem(
                                          child: Text(item["country_name"]),
                                          value: item["id"],
                                        );
                                      }
                                    }).toList(),
                                    onChanged: _expQuaData[0].jobseeker_detail[
                                                "visa_status"] ==
                                            0
                                        ? null
                                        : (value) {
                                            setState(() {
                                              if (value == 0) {
                                                _expQuaData[0].jobseeker_detail[
                                                    "visa_country"] = null;
                                              } else {
                                                _expQuaData[0].jobseeker_detail[
                                                        "visa_country"] =
                                                    value.toString();
                                              }
                                            });
                                          },
                                  ),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),

                                // Language Level
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 5.0, 15.0, 5.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "外国語レベル",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle),
                                        onPressed: () {
                                          _addLangLevel();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                if (_langLevel.length > 0)
                                  for (int i = 0; i < _langLevel.length; i++)
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "外国語",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("外国語を選択"),
                                              isExpanded: true,
                                              // value: _langLevel[i]["language_id"] != null ? _langLevel[i]["language_id"] : null,
                                              // value: _langLevel[i]["language_id"] == 0 ? null : _langLevel[i]["language_id"],
                                              value: _langLevel[i]
                                                          ["language_id"] !=
                                                      null
                                                  ? int.parse(_langLevel[i]
                                                      ["language_id"])
                                                  : null,
                                              items: _langList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(
                                                        item["language_name"]),
                                                    value: item["id"],
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value == 0) {
                                                    _langLevel[i]
                                                        ["language_id"] = null;
                                                  } else {
                                                    _langLevel[i]
                                                            ["language_id"] =
                                                        value.toString();
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "語学レベル",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin:
                                                const EdgeInsets.only(top: 7.0),
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
                                              hint: Text("語学レベルを選択"),
                                              isExpanded: true,
                                              // value: _langLevel[i]["language_level"] == 0 ? null : _langLevel[i]["language_level"],
                                              // value: _langLevel[i]["language_level"] != null ? _langLevel[i]["language_level"] : null,
                                              value: _langLevel[i]
                                                          ["language_level"] ==
                                                      null
                                                  ? null
                                                  : _langLevel[i]
                                                      ["language_level"],
                                              items: _langLevelList.map((item) {
                                                if (item != null) {
                                                  return DropdownMenuItem(
                                                    child: Text(item),
                                                    value: item,
                                                  );
                                                }
                                              }).toList(),
                                              onChanged: (value) {
                                                print(value.runtimeType);
                                                setState(() {
                                                  if (value == "語学レベルを選択") {
                                                    _langLevel[i]
                                                            ["language_level"] =
                                                        null;
                                                  } else {
                                                    _langLevel[i]
                                                            ["language_level"] =
                                                        value;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          if (_langLevel.length > 1)
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  if (_langLevel.length > 1)
                                                    _removeLangLevel(
                                                        i, _langLevel[i]["id"]);
                                                },
                                              ),
                                            ),
                                          // Container(
                                          //   child: IconButton(
                                          //     icon: _langLevel.length > 1
                                          //         ? Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.red,
                                          //           )
                                          //         : Icon(
                                          //             Icons.remove_circle,
                                          //             color: Colors.black26,
                                          //           ),
                                          //     onPressed: () {
                                          //       if (_langLevel.length > 1)
                                          //         _removeLangLevel(
                                          //             i, _langLevel[i]["id"]);
                                          //     },
                                          //   ),
                                          // ),
                                          if (i < (_langLevel.length - 1))
                                            Divider(
                                              color: Style
                                                  .CustomColor.secondaryColor,
                                            ),
                                        ],
                                      ),
                                    ),

                                // Toeic
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.all(17.0),
                                  decoration: BoxDecoration(
                                    color: Style.CustomColor.grey,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "資格",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),

                                Container(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5.0),
                                        alignment: Alignment.topLeft,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "TOEICスコア",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'スコアを入力',
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
                                          controller: this._toeicController,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "その他語学関連資格",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          keyboardType: TextInputType.multiline,
                                          textInputAction:
                                              TextInputAction.newline,
                                          minLines: 5,
                                          maxLines: 20,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            // hintText: 'スコアを入力',
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
                                              this._otherLangQuaController,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "その他資格",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          keyboardType: TextInputType.multiline,
                                          textInputAction:
                                              TextInputAction.newline,
                                          minLines: 5,
                                          maxLines: 20,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            // hintText: 'スコアを入力',
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
                                          controller: this._otherQuaController,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0,
                                        bottom: 10.0,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 45,
                                            child: RaisedButton(
                                                elevation: 5.0,
                                                color: Style
                                                    .CustomColor.secondaryColor,
                                                disabledColor:
                                                    Style.CustomColor.mainColor,
                                                disabledTextColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                onPressed: () => {
                                                      _changeArrayIndustryHistory(
                                                          _industryHistory),
                                                      _changeArrayStudyAbroad(
                                                          _studyAbroad),
                                                      _changeArrayWorkingAbroad(
                                                          _workingAbroad),
                                                      _changeArrayLangLevel(
                                                          _langLevel),
                                                      _changeArrays(),
                                                      print(
                                                          _industryHistoryDeleteId),
                                                      print(
                                                          _studyAbroadDeleteId),
                                                      print(
                                                          _workingAbroadDeleteId),
                                                      print(_langLevelDeleteId),
                                                      BlocProvider.of<
                                                                  ExpQualificationsBloc>(
                                                              context)
                                                          .add(
                                                        UpdateButtonPressed(
                                                          industryHistory:
                                                              _industryHistoryToSave,
                                                          deleteIndustryHistoryId:
                                                              _industryHistoryDeleteId,
                                                          studyAbroad:
                                                              _studyAbroadToSave,
                                                          deleteStudyAbroad:
                                                              _studyAbroadDeleteId,
                                                          workingAbroad:
                                                              _workingAbroadToSave,
                                                          deleteWorkingAbroad:
                                                              _workingAbroadDeleteId,
                                                          workVisa: _visaToSave,
                                                          langLevel:
                                                              _langLevelToSave,
                                                          deleteLangLevel:
                                                              _langLevelDeleteId,
                                                          otherQua:
                                                              _otherQuaToSave,
                                                        ),
                                                      )
                                                    },
                                                child: Text(
                                                  "保存する",
                                                  style: Style
                                                      .Customstyles.customText,
                                                )),
                                          )
                                        ])),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return progressLoading();
              }),
            )));
  }
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
