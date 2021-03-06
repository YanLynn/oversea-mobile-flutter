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
                industryName = "????????? \n";
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
                occupationName = "????????? \n";
              }

              // Income
              var incomeVal = '';
              if (desiredCondition[0]
                          .desired_condition["desired_min_annual_income"] ==
                      null &&
                  desiredCondition[0]
                          .desired_condition["desired_max_annual_income"] ==
                      null) {
                incomeVal = "?????????";
              } else if (desiredCondition[0]
                          .desired_condition["desired_min_annual_income"] !=
                      null &&
                  desiredCondition[0]
                          .desired_condition["desired_max_annual_income"] ==
                      null) {
                incomeVal = desiredCondition[0]
                        .desired_condition["desired_min_annual_income"] +
                    desiredCondition[0].desired_condition["desired_currency"] +
                    " ??????";
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
                                  "????????????",
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
                                child: (desiredCondition[0].desired_condition["job_change_reason"] == null || desiredCondition[0].desired_condition["job_change_reason"] == '?????????????????????')
                                    ? Text(
                                        "?????????",
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
                                  "??????????????????",
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
                                child: (desiredCondition[0].desired_condition[ "job_search_activity"] == null || desiredCondition[0].desired_condition[ "job_search_activity"] == '???????????????????????????')
                                    ? Text(
                                        "?????????",
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
                                  "?????????????????????????????????",
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
                                child: (desiredCondition[0].desired_condition[ "main_fact_when_change"] == null || desiredCondition[0].desired_condition[ "main_fact_when_change"] == '??????????????????????????????????????????')
                                    ? Text(
                                        "?????????",
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
                                  "??????????????????",
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
                                child: (desiredCondition[0].desired_condition["desired_change_period"] == null || desiredCondition[0].desired_condition["desired_change_period"] == '???????????????????????????')
                                    ? Text(
                                        "?????????",
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
                                  "???????????????",
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
                                      "????????????",
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
                                                "?????????",
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
                                      "????????????",
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
                                                "?????????",
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
                                      "????????????",
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
                                                "?????????",
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
                                  "????????????",
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
                                          "?????????????????? \n",
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
                                  "????????????",
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
                                          "?????????????????? \n",
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
                                  "????????????",
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
