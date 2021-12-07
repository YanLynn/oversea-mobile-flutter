import 'package:borderlessWorking/bloc/exp_qualifications_bloc/exp_qualifications_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/custom_expansion_tile.dart' as custom;
import 'package:borderlessWorking/style/theme.dart' as Style;

class ExpQualificationDetails extends StatefulWidget {
  @override
  _ExpQualificationDetailsState createState() =>
      _ExpQualificationDetailsState();
}

class _ExpQualificationDetailsState extends State<ExpQualificationDetails> {
  final ExpQualificationsBloc _bloc = ExpQualificationsBloc();

  @override
  void initState() {
    _bloc.add(GetExpQualification());
    super.initState();
  }

  List _expQuaData = [];
  List<String> _jsLanguage = [];

  visaCountry() {
    if (this._expQuaData[0].jobseeker_detail["visa_country"] == null ||
        this._expQuaData[0].jobseeker_detail["visa_country"] == '') {
      return "有り";
    } else {
      var countryId =
          int.parse(this._expQuaData[0].jobseeker_detail["visa_country"]);
      var visaCountry = this
          ._expQuaData[0]
          .countries
          .where((c) => c["id"] == countryId)
          .toList();
      return visaCountry[0]["country_name"].toString();
    }
  }

  void jsLanguage() async {
    for (int i = 0; i < this._expQuaData[0].languages_levels.length; i++) {
      var value = '';
      if (this._expQuaData[0].languages_levels[i]["language_id"] != null &&
          this._expQuaData[0].languages_levels[i]["language_id"] != 0) {
        var langId =
            int.parse(this._expQuaData[0].languages_levels[i]["language_id"]);
        var lang = this
            ._expQuaData[0]
            .languages
            .where((c) => c["id"] == langId)
            .toList();
        if (this._expQuaData[0].languages_levels[i]["language_level"] != null &&
            this._expQuaData[0].languages_levels[i]["language_level"] !=
                '語学レベルを選択') {
          value = lang[0]["language_name"] +
              " | " +
              this._expQuaData[0].languages_levels[i]["language_level"];
        } else {
          value = lang[0]["language_name"];
        }

        this._jsLanguage.add(value);
      } else {
        this._jsLanguage.add("未入力");
      }
    }
  }

  _occupationName(int occId) {
    var occVal =
        this._expQuaData[0].occupations.where((c) => c["id"] == occId).toList();
    return occVal[0]["occupation_name"].toString();
  }

  _industryName(int industryId) {
    var indVal = this
        ._expQuaData[0]
        .industries
        .where((c) => c["id"] == industryId)
        .toList();
    return indVal[0]["industry_name"].toString();
  }

  _positionName(int posId) {
    var posVal =
        this._expQuaData[0].positions.where((c) => c["id"] == posId).toList();
    return posVal[0]["position_name"].toString();
  }

  _countryName(int countryId) {
    var countryVal = this
        ._expQuaData[0]
        .countries
        .where((c) => c["id"] == countryId)
        .toList();
    return countryVal[0]["country_name"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener<ExpQualificationsBloc, ExpQualificationsState>(
        listener: (context, state) {
          if (state is ExpQualificationsFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<ExpQualificationsBloc, ExpQualificationsState>(
            builder: (context, state) {
          if (state is ExpQualificationsInitial) {
            return progressLoading();
          }
          if (state is ExpQualificationsSuccess) {
            _expQuaData = state.expQua;
            if (_expQuaData[0].languages_levels.length > 0 &&
                _jsLanguage.length < 1) jsLanguage();

            return Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 経験業種・職種
                Container(
                  child: custom.ExpansionTile(
                    initiallyExpanded: true,
                    headerBackgroundColor: Style.CustomColor.grey,
                    title: Text('経験業種・職種',
                        style:
                            TextStyle(color: Style.CustomColor.secondaryColor)),
                    children: [
                      if (_expQuaData[0].industry_histories.length > 0)
                        for (int i = 0;
                            i < _expQuaData[0].industry_histories.length;
                            i++)
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "経験年数",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].industry_histories[i]
                                                  ["experience_year"] ==
                                              null ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["experience_year"] ==
                                              0 ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["experience_year"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _expQuaData[0].industry_histories[i]
                                                  ["experience_year"] +
                                              "年",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "経験業種",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].industry_histories[i]
                                                  ["occupation_keyword_id"] ==
                                              null ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["occupation_keyword_id"] ==
                                              0 ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["occupation_keyword_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _occupationName(_expQuaData[0]
                                                  .industry_histories[i]
                                              ["occupation_keyword_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "経験職種",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].industry_histories[i]
                                                  ["industry_id"] ==
                                              null ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["industry_id"] ==
                                              0 ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["industry_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _industryName(_expQuaData[0]
                                                  .industry_histories[i]
                                              ["industry_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "ポジション",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].industry_histories[i]
                                                  ["position_id"] ==
                                              null ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["position_id"] ==
                                              0 ||
                                          _expQuaData[0].industry_histories[i]
                                                  ["position_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _positionName(_expQuaData[0]
                                                  .industry_histories[i]
                                              ["position_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                if (i <
                                    (_expQuaData[0].industry_histories.length -
                                        1))
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                if (i <
                                    (_expQuaData[0].industry_histories.length -
                                        1))
                                  Divider(
                                      color: Style.CustomColor.secondaryColor),
                                if (i ==
                                    (_expQuaData[0].industry_histories.length -
                                        1))
                                  SizedBox(
                                    height: 15.0,
                                  )
                              ],
                            ),
                          ),
                      if (_expQuaData[0].industry_histories.length < 1)
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.topLeft, child: Text("未入力")),
                        ),
                    ],
                  ),
                ),

                // 留学経験
                Container(
                  child: custom.ExpansionTile(
                    initiallyExpanded: true,
                    headerBackgroundColor: Style.CustomColor.grey,
                    title: Text('留学経験',
                        style:
                            TextStyle(color: Style.CustomColor.secondaryColor)),
                    children: [
                      if (_expQuaData[0].education_overseas.length > 0)
                        for (int i = 0;
                            i < _expQuaData[0].education_overseas.length;
                            i++)
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Column(
                              children: [
                                // 国地域名
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "国地域名",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].education_overseas[i]
                                                  ["country_id"] ==
                                              null ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["country_id"] ==
                                              0 ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["country_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _countryName(_expQuaData[0]
                                                  .education_overseas[i]
                                              ["country_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),

                                //  期間
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "期間",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].education_overseas[i]
                                                  ["period"] ==
                                              null ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["period"] ==
                                              0 ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["period"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _expQuaData[0].education_overseas[i]
                                              ["period"],
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),

                                // 留学の目的
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "留学の目的",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].education_overseas[i]
                                                  ["purpose"] ==
                                              null ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["purpose"] ==
                                              0 ||
                                          _expQuaData[0].education_overseas[i]
                                                  ["purpose"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _expQuaData[0].education_overseas[i]
                                              ["purpose"],
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),

                                if (i <
                                    (_expQuaData[0].education_overseas.length -
                                        1))
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                if (i <
                                    (_expQuaData[0].education_overseas.length -
                                        1))
                                  Divider(
                                      color: Style.CustomColor.secondaryColor),

                                if (i ==
                                    (_expQuaData[0].education_overseas.length -
                                        1))
                                  SizedBox(
                                    height: 15.0,
                                  )
                              ],
                            ),
                          ),
                      if (_expQuaData[0].education_overseas.length < 1)
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.topLeft, child: Text("未入力")),
                        ),
                    ],
                  ),
                ),

                // 海外での勤務経験
                Container(
                  child: custom.ExpansionTile(
                    initiallyExpanded: true,
                    headerBackgroundColor: Style.CustomColor.grey,
                    title: Text('海外での勤務経験',
                        style:
                            TextStyle(color: Style.CustomColor.secondaryColor)),
                    children: [
                      if (_expQuaData[0].working_overseas.length > 0)
                        for (int i = 0;
                            i < _expQuaData[0].working_overseas.length;
                            i++)
                          Container(
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 15.0, 15.0, 0.0),
                            child: Column(
                              children: [
                                // 国・地域名
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "国・地域名",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].working_overseas[i]
                                                  ["country_id"] ==
                                              null ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["country_id"] ==
                                              0 ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["country_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _countryName(
                                              _expQuaData[0].working_overseas[i]
                                                  ["country_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),

                                //  期間
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "期間",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].working_overseas[i]
                                                  ["period"] ==
                                              null ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["period"] ==
                                              0 ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["period"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _expQuaData[0].working_overseas[i]
                                              ["period"],
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),

                                // ポジション
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "ポジション",
                                    style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: (_expQuaData[0].working_overseas[i]
                                                  ["position_id"] ==
                                              null ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["position_id"] ==
                                              0 ||
                                          _expQuaData[0].working_overseas[i]
                                                  ["position_id"] ==
                                              '')
                                      ? Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          _positionName(
                                              _expQuaData[0].working_overseas[i]
                                                  ["position_id"]),
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                ),

                                if (i <
                                    (_expQuaData[0].working_overseas.length -
                                        1))
                                  SizedBox(
                                    height: 10.0,
                                  ),

                                if (i <
                                    (_expQuaData[0].working_overseas.length -
                                        1))
                                  Divider(
                                      color: Style.CustomColor.secondaryColor),

                                if (i ==
                                    (_expQuaData[0].working_overseas.length -
                                        1))
                                  SizedBox(
                                    height: 15.0,
                                  )
                              ],
                            ),
                          ),
                      if (_expQuaData[0].working_overseas.length < 1)
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.topLeft, child: Text("未入力")),
                        ),
                    ],
                  ),
                ),

                // visa
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "就労ビザ",
                          style: TextStyle(
                            color: Style.CustomColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                            _expQuaData[0].jobseeker_detail["visa_status"] == 0
                                ? Text(
                                    "無し",
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  )
                                : Text(
                                    visaCountry(),
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),

                // 語学レベル
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "語学レベル",
                          style: TextStyle(
                            color: Style.CustomColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      if (_jsLanguage.length > 0)
                        for (int i = 0; i < _jsLanguage.length; i++)
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _jsLanguage[i],
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                      if (_jsLanguage.length < 1)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "未入力",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),

                // TOEICスコア
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "TOEICスコア",
                          style: TextStyle(
                            color: Style.CustomColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: _expQuaData[0].jobseeker_detail["toeic_score"] ==
                                null
                            ? Text(
                                "未入力",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              )
                            : Text(
                                _expQuaData[0].jobseeker_detail["toeic_score"],
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),

                // その他語学関連資料
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "その他語学関連資料",
                          style: TextStyle(
                            color: Style.CustomColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: _expQuaData[0].jobseeker_detail[
                                    "other_language_certificate"] ==
                                null
                            ? Text(
                                "未入力",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              )
                            : Text(
                                _expQuaData[0].jobseeker_detail[
                                    "other_language_certificate"],
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),

                // その他資格
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "その他資格",
                          style: TextStyle(
                            color: Style.CustomColor.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: _expQuaData[0]
                                    .jobseeker_detail["other_certificate"] ==
                                null
                            ? Text(
                                "未入力",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              )
                            : Text(
                                _expQuaData[0]
                                    .jobseeker_detail["other_certificate"],
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
          }

          return progressLoading();
        }),
      ),
    );
  }
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
