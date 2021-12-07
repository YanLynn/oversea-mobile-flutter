import 'package:borderlessWorking/bloc/desired_condition_bloc/desired_condition_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class DesiredConditionDetails extends StatefulWidget {
  @override
  _DesiredConditionDetailsState createState() =>
      _DesiredConditionDetailsState();
}

class _DesiredConditionDetailsState extends State<DesiredConditionDetails> {
  final DesiredConditionBloc _bloc = DesiredConditionBloc();

  @override
  void initState() {
    _bloc.add(GetDesiredCondition());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener<DesiredConditionBloc, DesiredConditionState>(
        listener: (context, state) {
          if (state is DesiredConditionFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<DesiredConditionBloc, DesiredConditionState>(
          builder: (context, state) {
            if (state is DesiredConditionInitial) {
              return progressLoading();
            }
            if (state is DesiredConditionSuccess) {
              List desiredCondition = state.desiredCondition;

              // Industry name array
              var industryName = '';
              if (desiredCondition[0]
                      .desired_condition["industry_name"]
                      .length >
                  0) {
                for (int i = 0;
                    i <
                        desiredCondition[0]
                            .desired_condition["industry_name"]
                            .length;
                    i++) {
                  industryName +=
                      (desiredCondition[0].desired_condition["industry_name"][i]
                                  ["industry_name"])
                              .toString() +
                          "\n";
                }
              } else {
                industryName = "未入力 \n";
              }

              // Occupation name array
              var occupationName = '';
              if (desiredCondition[0]
                      .desired_condition["occupation_name"]
                      .length >
                  0) {
                for (int i = 0;
                    i <
                        desiredCondition[0]
                            .desired_condition["occupation_name"]
                            .length;
                    i++) {
                  occupationName +=
                      (desiredCondition[0].desired_condition["occupation_name"]
                                  [i]["occupation_name"])
                              .toString() +
                          "\n";
                }
              } else {
                occupationName = "未入力 \n";
              }

              // Income
              var incomeVal = '';
              if (desiredCondition[0]
                          .desired_condition["desired_min_annual_income"] ==
                      null &&
                  desiredCondition[0]
                          .desired_condition["desired_max_annual_income"] ==
                      null) {
                incomeVal = "未入力";
              } else if (desiredCondition[0]
                          .desired_condition["desired_min_annual_income"] !=
                      null &&
                  desiredCondition[0]
                          .desired_condition["desired_max_annual_income"] ==
                      null) {
                incomeVal = desiredCondition[0]
                        .desired_condition["desired_min_annual_income"] +
                    desiredCondition[0].desired_condition["desired_currency"] +
                    " 以上";
              } else if (desiredCondition[0]
                          .desired_condition["desired_min_annual_income"] ==
                      null &&
                  desiredCondition[0]
                          .desired_condition["desired_max_annual_income"] !=
                      null) {
                incomeVal = desiredCondition[0]
                        .desired_condition["desired_max_annual_income"] +
                    desiredCondition[0].desired_condition["desired_currency"];
              } else {
                incomeVal = desiredCondition[0]
                        .desired_condition["desired_min_annual_income"] +
                    " ~ " +
                    desiredCondition[0]
                        .desired_condition["desired_max_annual_income"] +
                    " " +
                    desiredCondition[0].desired_condition["desired_currency"];
              }

              return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "転職意欲",
                                  style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: (desiredCondition[0].desired_condition["job_change_reason"] == null || desiredCondition[0].desired_condition["job_change_reason"] == '転職意欲を選択')
                                    ? Text(
                                        "未入力",
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      )
                                    : Text(
                                        desiredCondition[0].desired_condition[
                                            "job_change_reason"],
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "転職活動状況",
                                  style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: (desiredCondition[0].desired_condition[ "job_search_activity"] == null || desiredCondition[0].desired_condition[ "job_search_activity"] == '転職活動状況を選択')
                                    ? Text(
                                        "未入力",
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      )
                                    : Text(
                                        desiredCondition[0].desired_condition[
                                            "job_search_activity"],
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "転臓で最も重視すること",
                                  style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: (desiredCondition[0].desired_condition[ "main_fact_when_change"] == null || desiredCondition[0].desired_condition[ "main_fact_when_change"] == '転職で最も重視することを選択')
                                    ? Text(
                                        "未入力",
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      )
                                    : Text(
                                        desiredCondition[0].desired_condition[
                                            "main_fact_when_change"],
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "転職希望時期",
                                  style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: (desiredCondition[0].desired_condition["desired_change_period"] == null || desiredCondition[0].desired_condition["desired_change_period"] == '転職希望時期を選択')
                                    ? Text(
                                        "未入力",
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      )
                                    : Text(
                                        desiredCondition[0].desired_condition[
                                            "desired_change_period"],
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "希望勤務地",
                                  style: TextStyle(
                                    color: Style.CustomColor.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "第一希望",
                                      style: TextStyle(
                                          color:
                                              Style.CustomColor.secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                        desiredCondition[0].desired_condition[
                                                    "desired_locations_1"] ==
                                                null
                                            ? Text(
                                                "未入力",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                ),
                                              )
                                            : Text(
                                                desiredCondition[0]
                                                        .desired_condition[
                                                    "desired_locations_1"],
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
                                      "第一希望",
                                      style: TextStyle(
                                          color:
                                              Style.CustomColor.secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                        desiredCondition[0].desired_condition[
                                                    "desired_locations_2"] ==
                                                null
                                            ? Text(
                                                "未入力",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                ),
                                              )
                                            : Text(
                                                desiredCondition[0]
                                                        .desired_condition[
                                                    "desired_locations_2"],
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
                                      "第一希望",
                                      style: TextStyle(
                                          color:
                                              Style.CustomColor.secondaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                        desiredCondition[0].desired_condition[
                                                    "desired_locations_3"] ==
                                                null
                                            ? Text(
                                                "未入力",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                ),
                                              )
                                            : Text(
                                                desiredCondition[0]
                                                        .desired_condition[
                                                    "desired_locations_3"],
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "希望業種",
                                  style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 15.0, 15.0, 0.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: desiredCondition[0].desired_condition[
                                              "desired_industry_status"] ==
                                          1
                                      ? Text(
                                          "こだわらない \n",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          industryName,
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "希望職種",
                                  style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: desiredCondition[0].desired_condition[
                                              "desired_occupation_status"] ==
                                          1
                                      ? Text(
                                          "こだわらない \n",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )
                                      : Text(
                                          occupationName,
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        )),
                            ),
                          ],
                        ),
                      ),
                      // Divider(color: Colors.black45,),
                      Container(
                        alignment: Alignment.centerLeft,
                        // padding: const EdgeInsets.fromLTRB(15, 7, 10, 7),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.grey,
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "希望年収",
                                  style: TextStyle(
                                      color: Style.CustomColor.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  incomeVal,
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
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
          },
        ),
      ),
    );
  }
}

Widget progressLoading() => Center(child: CupertinoActivityIndicator());
