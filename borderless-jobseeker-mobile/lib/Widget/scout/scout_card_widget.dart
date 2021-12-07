import 'package:borderlessWorking/Widget/scoutdetails/scoutDetails.dart';
import 'package:borderlessWorking/bloc/scoutdetails/bloc/scoutdetails_bloc.dart';
import 'package:borderlessWorking/bloc/scouted_list_bloc/scouted_list_bloc.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Payload {
  int jobseeker_id;
  int recruiter_id;
  int scoutid_or_applyid;
  String status;
  String type;
}

Widget scoutCard(Scout scoutedList, BuildContext context, String pageType) {
  double c_width = MediaQuery.of(context).size.width * 0.8;
  return GestureDetector(
    onTap: () => {
      if (pageType == "list" && scoutedList.scout_status != "不採用/辞退")
        {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ScoutDetails(
                        scoutId: scoutedList.id,
                        jobid: scoutedList.job_id,
                      ))),
        }
    },
    child: Card(
        elevation: 2,
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 5.0),
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      (scoutedList.recruiter_name == null
                              ? ''
                              : scoutedList.recruiter_name) +
                          ' ',
                      softWrap: true,
                      // overflow: TextOverflow.fade,
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          height: 1.5,
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: Text(
                    'からのスカウト',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      // backgroundColor: Colors.black12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      margin: EdgeInsets.all(10),
                      child: CachedNetworkImage(
                        imageUrl: scoutedList.incharge_photo_url,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image:
                      //             NetworkImage(scoutedList.incharge_photo_url),
                      //         fit: BoxFit.contain)),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 0, right: 10),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Column(
                        //     children: <Widget>[

                        //       // Text(
                        //       //   (scoutedList.recruiter_name == null
                        //       //           ? ''
                        //       //           : scoutedList.recruiter_name) +
                        //       //       ' ',
                        //       //   maxLines: 1,
                        //       //   overflow: TextOverflow.ellipsis,
                        //       //   style: const TextStyle(
                        //       //     fontSize: 12.0,
                        //       //     color: Colors.black87,
                        //       //   ),
                        //       // ),
                        //       // Text(
                        //       //   'からのスカウト',
                        //       //   style: const TextStyle(
                        //       //     fontSize: 16.0,
                        //       //     color: Colors.black87,
                        //       //     backgroundColor: Colors.black12,
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 8),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '募集ポジション : ',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: (scoutedList.occupation_description ==
                                          null
                                      ? ''
                                      : scoutedList.occupation_description),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          // child: Text(
                          //     '募集ポジション : ' +
                          //         (scoutedList.occupation_description == null
                          //             ? ''
                          //             : scoutedList.occupation_description),
                          //     maxLines: 2,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(fontSize: 14.0)),
                        ),
                        SizedBox(height: 4),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '雇用形態 : ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          (scoutedList.employment_types == null
                                              ? ''
                                              : scoutedList.employment_types),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Text(
                              //   '雇用形態 : ' +
                              //       (scoutedList.employment_types == null
                              //           ? ''
                              //           : scoutedList.employment_types),
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   softWrap: true,
                              //   style: TextStyle(
                              //     fontSize: 14.0,
                              //     color: Colors.black87,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '勤務地詳細 : ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: (scoutedList.job_location == null
                                          ? ''
                                          : scoutedList.job_location),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Text(
                              //   '勤務地詳細 : ' +
                              //       (scoutedList.job_location == null
                              //           ? ''
                              //           : scoutedList.job_location),
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.black87,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'スカウト日時 : ',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // TextSpan(
                                    //   text: scoutedList.user_scouted_date,
                                    //   style: TextStyle(
                                    //       color: Colors.black, fontSize: 14),
                                    // ),
                                  ],
                                ),
                              ),
                              // child: Text(
                              //   'スカウト日時 : ' +
                              //       scoutedList.user_scouted_date.toString(),
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.black87,
                              //   ),
                              // ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                scoutedList.user_scouted_date,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 23.0,
                          color: Colors.transparent,
                          child: new Container(
                              decoration: new BoxDecoration(
                                  border: Border.all(
                                    color: Color(
                                        0xFF7E98AD), // red as border color
                                  ),
                                  color: Color(0xFFCAE0F2),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: new Center(
                                child: new Text("スカウト"),
                              )),
                        ),
                        // child: Container(
                        //   margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                        //   child: Text(
                        //     "スカウト",
                        //     style: const TextStyle(
                        //         fontSize: 14.0,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.bold,
                        //         backgroundColor: Style.CustomColor.mainColor),
                        //   ),
                        // ),
                      ),
                      Expanded(
                        flex: 16,
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0),
                          child: (scoutedList.read_job == 0 &&
                                  scoutedList.scout_status == '回答待ち' &&
                                  pageType == 'list')
                              ? Text(
                                  '未読',
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  scoutedList.scout_status,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Divider(color: Colors.grey),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Center(
                      child: scoutedList.scout_status == '回答待ち'
                          ? FlatButton.icon(
                              color: Colors.white,
                              icon: Icon(
                                Icons.favorite,
                                color: Style.CustomColor.iconColor,
                              ),
                              onPressed: () =>
                                  _favScout(scoutedList.id, context, pageType),
                              label: Text(
                                '興味あり',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            )
                          : ((scoutedList.scout_status == '興味あり' ||
                                  scoutedList.scout_status == '入金確認済' ||
                                  scoutedList.scout_status == '内定未請求' ||
                                  scoutedList.scout_status == '請求済')
                              ? FlatButton.icon(
                                  color: Colors.white,
                                  icon: Icon(
                                    Icons.message,
                                    color: Style.CustomColor.iconColor,
                                  ),
                                  label: Text(
                                    'チャット開始',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                  onPressed: () {
                                    _startChat(scoutedList, context);
                                  },
                                )
                              : Container(child: Text('')))),
                ),
                Expanded(
                  child: Center(
                      child: scoutedList.scout_status == '不採用/辞退'
                          ? Container(child: Text(''))
                          : ((scoutedList.scout_status == '興味あり' ||
                                  scoutedList.scout_status == '回答待ち')
                              ? FlatButton.icon(
                                  onPressed: () => _deleteScout(
                                      scoutedList.id, context, pageType),
                                  color: Colors.white,
                                  icon: Icon(
                                    Icons.thumb_down_alt,
                                    color: Style.CustomColor.iconColor,
                                  ),
                                  label: Text(
                                    '辞退',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                )
                              : Container(child: Text('')))),
                ),
              ],
            ),
          ),
        ])),
  );
}

//delete dialog box
_deleteScout(int scoutId, BuildContext context, String pageType) {
  // set up the buttons
  Widget cancelButton = RaisedButton(
    child: Text(
      'いいえ',
      style: Style.Customstyles.customText,
    ),
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    padding: const EdgeInsets.all(10),
    color: Colors.grey,
    textColor: Colors.white,
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );

  Widget continueButton = RaisedButton(
    child: Text(
      'はい',
      style: Style.Customstyles.customText,
    ),
    elevation: 2.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    padding: const EdgeInsets.all(10),
    color: Style.CustomColor.secondaryColor,
    textColor: Colors.white,
    onPressed: () {
      Navigator.pop(context);
      if (pageType == 'list') {
        BlocProvider.of<ScoutedListBloc>(context).add(
          ActionScout(scoutId, 'delete'),
        );
      } else {
        BlocProvider.of<ScoutdetailsBloc>(context).add(
          ActiondetailsScout(scoutId, 'delete'),
        );
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(
      child: IconTheme(
        data: new IconThemeData(color: Style.CustomColor.mainColor, size: 35),
        child: new Icon(Icons.info),
      ),
    ),
    // content: Text("削除しますか。"),
    content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
        child: Text(
          "辞退しますか。",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ]),
    actions: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        cancelButton,
        SizedBox(width: 10),
        continueButton,
      ]),
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

_favScout(int scoutId, BuildContext context, String pageType) {
  if (pageType == 'list') {
    BlocProvider.of<ScoutedListBloc>(context).add(
      ActionScout(scoutId, 'favourite'),
    );
  } else {
    BlocProvider.of<ScoutdetailsBloc>(context).add(
      ActiondetailsScout(scoutId, 'favourite'),
    );
  }
}

_startChat(Scout scout, BuildContext context) {
  Payload payload = new Payload();
  payload.recruiter_id = scout.recruiter_id;
  payload.jobseeker_id = scout.jobseeker_id;
  payload.scoutid_or_applyid = scout.id;
  payload.type = 'scout';
  payload.status = scout.scout_status;

  Navigator.of(context).pushNamed('/chat-room', arguments: payload);
}
