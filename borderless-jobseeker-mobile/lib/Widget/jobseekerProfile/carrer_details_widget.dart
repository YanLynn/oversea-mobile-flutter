import 'package:borderlessWorking/style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:borderlessWorking/style/custom_expansion_tile.dart' as custom;

Widget buildLoading() => Center(child: CupertinoActivityIndicator());

Widget item(List model, BuildContext context) {
  eduyearAndmonth(int i) {
    // for (int i = 0; i < model[0].educations.length; i++) {
    var value = '';
    if (model[0].educations[i]['from_year'] != null ||
        model[0].educations[i]['from_month'] != null) {
      if (model[0].educations[i]['from_year'] != null) {
        value += (model[0].educations[i]['from_year']).toString() + '年';
      }
      if (model[0].educations[i]['from_month'] != null) {
        value += (model[0].educations[i]['from_month']).toString() + '月';
      }
      if (model[0].educations[i]['to_year'] != null &&
          model[0].educations[i]['to_month'] != null) {
        value += ' ~ ' +
            (model[0].educations[i]['to_year']).toString() +
            '年' +
            (model[0].educations[i]['to_month']).toString() +
            '月';
      }
      if (model[0].educations[i]['to_year'] != null &&
          model[0].educations[i]['to_month'] == null) {
        value += ' ~ ' + (model[0].educations[i]['to_year']).toString() + '年';
      }
      if (model[0].educations[i]['to_year'] == null &&
          model[0].educations[i]['to_month'] != null) {
        value += ' ~ ' + (model[0].educations[i]['to_month']).toString() + '月';
      }
      if (model[0].educations[i]['to_year'] == null &&
          model[0].educations[i]['to_month'] == null) {
        value += ' ~  在籍中';
      }
    } else {
      if (model[0].educations[i]['to_year'] != null &&
          model[0].educations[i]['to_month'] == null) {
        value = '~ ' + (model[0].educations[i]['to_year']).toString() + '年';
      } else if (model[0].educations[i]['to_year'] == null &&
          model[0].educations[i]['to_month'] != null) {
        value = '~ ' + (model[0].educations[i]['to_month']).toString() + '月';
      } else if (model[0].educations[i]['to_year'] != null &&
          model[0].educations[i]['to_month'] != null) {
        value = '~ ' +
            (model[0].educations[i]['to_year']).toString() +
            '年' +
            (model[0].educations[i]['to_month']).toString() +
            '月';
      }
    }
    if (model[0].educations[i]['from_year'] == null &&
        model[0].educations[i]['from_month'] == null &&
        model[0].educations[i]['to_year'] == null &&
        model[0].educations[i]['to_month'] == null) {
      value = ' - ';
    }
    // }
    return value.toString();
  }

  schoolname(int i) {
    if (model[0].educations[i]['school_name'] == '' ||
        model[0].educations[i]['school_name'] == null) {
      return '-';
    } else {
      return model[0].educations[i]['school_name'];
    }
  }

  subject(int i) {
    if (model[0].educations[i]['subject'] == '' ||
        model[0].educations[i]['subject'] == null) {
      return '-';
    } else {
      return model[0].educations[i]['subject'];
    }
  }

  degree(int i) {
    if (model[0].educations[i]['degree'] == '' ||
        model[0].educations[i]['degree'] == null) {
      return '-';
    } else {
      return model[0].educations[i]['degree'];
    }
  }

  educationstatus(int i) {
    if (model[0].educations[i]['education_status'] == '' ||
        model[0].educations[i]['education_status'] == null) {
      return '-';
    } else {
      return model[0].educations[i]['education_status'];
    }
  }

  numofexp() {
    if (model[0].carrers['num_of_experienced_companies'] == null ||
        model[0].carrers['num_of_experienced_companies'] == '') {
      return '未入力';
    } else {
      return model[0].carrers['num_of_experienced_companies'].toString();
    }
  }

  annualincome() {
    var value = '';
    if (model[0].carrers['last_currency'] != null ||
        model[0].carrers['last_annual_income'] != null) {
      if (model[0].carrers['last_annual_income'] != null) {
        value = model[0].carrers['last_annual_income'];
      }
      if (model[0].carrers['last_currency'] != null) {
        value += ' ' + model[0].carrers['last_currency'];
      }
    } else {
      value = '未入力';
    }
    return value;
  }

  expyearAndmonth(i) {
    var value = '';
    if (model[0].experiences[i]['current'] == 0 ||
        model[0].experiences[i]['current'] == null) {
      if (model[0].experiences[i]['from_year'] != null ||
          model[0].experiences[i]['from_month'] != null) {
        if (model[0].experiences[i]['from_year'] != null) {
          value += (model[0].experiences[i]['from_year']).toString() + '年';
        }
        if (model[0].experiences[i]['from_month'] != null) {
          value += (model[0].experiences[i]['from_month']).toString() + '月';
        }
        if (model[0].experiences[i]['to_year'] != null &&
            model[0].experiences[i]['to_month'] != null) {
          value += ' ~ ' +
              (model[0].experiences[i]['to_year']).toString() +
              '年' +
              (model[0].experiences[i]['to_month']).toString() +
              '月';
        }
        if (model[0].experiences[i]['to_year'] != null &&
            model[0].experiences[i]['to_month'] == null) {
          value +=
              ' ~ ' + (model[0].experiences[i]['to_year']).toString() + '年';
        }
        if (model[0].experiences[i]['to_year'] == null &&
            model[0].experiences[i]['to_month'] != null) {
          value +=
              ' ~ ' + (model[0].experiences[i]['to_month']).toString() + '月';
        }
        if (model[0].experiences[i]['to_year'] == null &&
            model[0].experiences[i]['to_month'] == null) {
          value += ' ~  在籍中';
        }
      } else {
        value = ' - ';
      }
    } else {
      if (model[0].experiences[i]['from_year'] != null &&
          model[0].experiences[i]['from_month'] != null) {
        value = model[0].experiences[i]['from_year'].toString() +
            '年' +
            model[0].experiences[i]['from_month'].toString() +
            '月' +
            ' ~ 在籍中';
      }
    }
    return value.toString();
  }

  joblocation(i) {
    if (model[0].experiences[i]['job_location'] == '' ||
        model[0].experiences[i]['job_location'] == null) {
      return '-';
    } else {
      return model[0].experiences[i]['job_location'];
    }
  }

  position(i) {
    if (model[0].experiences[i]['position_name'] == '' ||
        model[0].experiences[i]['position_name'] == null) {
      return '-';
    } else {
      return model[0].experiences[i]['position_name'];
    }
  }

  employmenttype(i) {
    if (model[0].experiences[i]['employment_type_name'] == '' ||
        model[0].experiences[i]['employment_type_name'] == null) {
      return '-';
    } else {
      return model[0].experiences[i]['employment_type_name'];
    }
  }

  mainduty(i) {
    if (model[0].experiences[i]['main_duty'] == '' ||
        model[0].experiences[i]['main_duty'] == null) {
      return '-';
    } else {
      return model[0].experiences[i]['main_duty'];
    }
  }
// double c_width = MediaQuery.of(context).size.width*0.8;
  return Container(
    // height: MediaQuery.of(context).size.height,
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          //educations
          if (model[0].educations.length >= 1)
            for (int i = 0; i < model[0].educations.length; i++)
              Container(
                child: Container(
                  // padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //school_name
                      // SizedBox(height: 15),
                      Container(
                        child: Card(
                          elevation: 0.0,
                          margin: EdgeInsets.all(0),
                          child: custom.ExpansionTile(
                              initiallyExpanded: true,
                              headerBackgroundColor: Style.CustomColor.grey,
                              title: Text('学歴',
                                  style: TextStyle(
                                      color: Style.CustomColor.secondaryColor)),
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 13, top: 10,right: 13),
                                        child: Row(children: [
                                          Flexible(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '学校名',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Style
                                                          .CustomColor.titleColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    schoolname(i),  
                                                    softWrap: true,
                                                    textAlign: TextAlign.justify,                                                
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: CustomColor.txtColor,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(height: 15),
                                      //subject
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 13,right: 13),
                                        child: Row(children: [
                                          Flexible(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '学部学科',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          CustomColor.titleColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    subject(i),
                                                     softWrap: true,
                                                    textAlign: TextAlign.justify,                                                     
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: CustomColor.txtColor,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(height: 15),
                                      //degree
                                      //label
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 13, right: 13),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '学位',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: CustomColor.titleColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                                color: Style.CustomColor.pink,
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text('運営管理者のみ閲覧可',
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0))),
                                          ],
                                        ),
                                      ),
                                      //end label
                                     
                                      SizedBox(height: 10),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    degree(i),
                                                    softWrap: true,
                                                      textAlign: TextAlign.justify,
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: CustomColor.txtColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      // fromyeartoyear
                                      //label
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 13, right: 13),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '在籍期間',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: CustomColor.titleColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                                color: Style.CustomColor.pink,
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text('運営管理者のみ閲覧可',
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0))),
                                          ],
                                        ),
                                      ),
                                      //end label
                                     
                                      SizedBox(height: 10),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 13,right: 13),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      eduyearAndmonth(i),
                                                      softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                        color:
                                                            CustomColor.txtColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),

                                      //status
                                      //label
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 13, right: 13),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'ステータス',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                color: CustomColor.titleColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Container(
                                                color: Style.CustomColor.pink,
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text('運営管理者のみ閲覧可',
                                                    textAlign: TextAlign.right,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0))),
                                          ],
                                        ),
                                      ),
                                      //end label
                                     
                                      SizedBox(height: 10),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 13,right: 13),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  educationstatus(i),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: CustomColor.txtColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                    ]),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

          if (model[0].educations.length == 0)
            Container(
              padding: const EdgeInsets.only(top: 10, left: 13),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      '学歴',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: CustomColor.titleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '未入力 ',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: CustomColor.txtColor,
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          if (model[0].educations.length == 0)
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(color: Colors.grey),
            ),
          //carrers
          Container(
            padding: const EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 10.0),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //numofexp
                    Container(
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            '経験社数',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: CustomColor.titleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            numofexp(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: CustomColor.txtColor,
                            ),
                          ),
                        ]),
                      ]),
                    ),
                    // SizedBox(height: 4),
                  ]),
            ),
          ),
          if (model[0].educations.length == 0)
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(color: Colors.grey),
            ),
          //experiences
          
          if (model[0].experiences.length > 0)
            for (int i = 0; i < model[0].experiences.length; i++)
              Container(
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 15.0),
                        Container(
                            child: Card(
                                elevation: 0.0,
                                margin: EdgeInsets.all(0),
                                child: custom.ExpansionTile(
                                    initiallyExpanded: true,
                                    headerBackgroundColor:
                                        Style.CustomColor.grey,
                                    title: Text('勤務先',
                                        style: TextStyle(
                                            color: Style
                                                .CustomColor.secondaryColor)),
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //job_location
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13, top: 10,right: 13),
                                              child: Row(
                                                 mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '企業名  ',
                                                          softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color: CustomColor
                                                                .titleColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      if (model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              1 ||
                                                          model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              2)
                                                        Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      CustomColor
                                                                          .yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  child: Text(
                                                                      "非公開",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13.0)),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          joblocation(i),
                                                           softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomColor
                                                                .txtColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),

                                            //fromyeartoyear
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                 mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          '在籍期間   ',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            color: CustomColor
                                                                .titleColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      if (model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              1 ||
                                                          model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              2)
                                                        Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      CustomColor
                                                                          .yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  child: Text(
                                                                      "非公開",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13.0)),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          expyearAndmonth(i),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomColor
                                                                .txtColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),

                                            //position
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                 mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'ポジション',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: CustomColor
                                                              .titleColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      if (model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              1 ||
                                                          model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              2)
                                                        Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      CustomColor
                                                                          .yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  child: Text(
                                                                      "非公開",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13.0)),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          position(i),
                                                          softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomColor
                                                                .txtColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),

                                            //employment_type
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                 mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '雇用形態',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: CustomColor
                                                              .titleColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      if (model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              1 ||
                                                          model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              2)
                                                        Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      CustomColor
                                                                          .yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  child: Text(
                                                                      "非公開",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13.0)),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          employmenttype(i),
                                                          softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomColor
                                                                .txtColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),

                                            //main_duty
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13,right: 13),
                                              child: Row(
                                                 mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '主な業務',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                       style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: CustomColor
                                                              .titleColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      if (model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              1 ||
                                                          model[0].experiences[
                                                                      i][
                                                                  'private_status'] ==
                                                              2)
                                                        Column(
                                                          children: [
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  color:
                                                                      CustomColor
                                                                          .yellow,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3.0),
                                                                  child: Text(
                                                                      "非公開",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              13.0)),
                                                                )),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 13, bottom: 20,right: 13),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          mainduty(i),
                                                           softWrap: true,
                                                        textAlign: TextAlign.justify,
                                                          style: const TextStyle(
                                                            fontSize: 14.0,
                                                            color: CustomColor
                                                                .txtColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                          ]),
                                    ]))),
                      ]),
                ),
              ),
              
          if (model[0].experiences.length == 0)
            Container(
              padding: const EdgeInsets.only(top: 10, left: 13),
              child: Row(children: [
                Column(children: [
                  Text(
                    '勤務先',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: CustomColor.titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '未入力 ',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: CustomColor.txtColor,
                    ),
                  ),
                ]),
              ]),
            ),
          if (model[0].experiences.length == 0)
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Divider(color: Colors.grey),
            ),
          //annual income

          Container(
            padding: const EdgeInsets.fromLTRB(13.0, 10.0, 13.0, 0.0),
            child: Container(
              // width: 400,
              // height: 65,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //numofexp
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              '最終年収',
                            
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: CustomColor.titleColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              annualincome(),
                               softWrap: true,
                                                        textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: CustomColor.txtColor,
                              ),
                            ),
                          ]),
                        ),
                      ]),
                    ),
                    SizedBox(height: 20),
                  ]),
            ),
          ),
        ],
      ),
    ),
  );
}
