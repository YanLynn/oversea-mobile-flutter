import 'package:borderlessWorking/Widget/jobdetails/jobdetails.dart';
import 'package:borderlessWorking/bloc/jobappliedlist/bloc/jobappliedlist_bloc.dart';
import 'package:borderlessWorking/data/model/jobappliedpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:timezone/data/latest.dart' as tz;

class Jobappliedlist extends StatefulWidget {
  @override
  _JobappliedlistState createState() => _JobappliedlistState();
}

class Payload {
  int jobseeker_id;
  int recruiter_id;
  int scoutid_or_applyid;
  String status;
  String type;
}

class _JobappliedlistState extends State<Jobappliedlist> {
  final JobappliedlistBloc _newbloc = JobappliedlistBloc();
  List<Jobappliedpage> jobs = [];
  List<Jobappliedpage> jobList = [];
  // void changestatus(applyid) async {
  //   _newbloc.add(Getjobstatus(applyid.toString()));
  //   print('$applyid');
  // }

  //delete dialog box
  void changestatus(applyid) async {
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
        _newbloc.add(Getjobstatus(applyid.toString()));
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

  _startChat(Jobappliedpage jobapply) {
    Payload payload = new Payload();
    payload.recruiter_id = jobapply.recruiter_id;
    payload.jobseeker_id = jobapply.jobseeker_id;
    payload.scoutid_or_applyid = jobapply.job_apply_id;
    payload.type = 'job-apply';
    payload.status = jobapply.job_apply_status;

    Navigator.of(context).pushNamed('/chat-room', arguments: payload);
  }

  @override
  void initState() {
    _newbloc.add(Getjobappliedlist());
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // body: BlocProvider(
      //     create: (_) => _newbloc,
      //     child: BlocBuilder<JobappliedlistBloc, JobappliedlistState>(
      //       builder: (context, state) {
      //         if (state is JobappliedlistInitial) {
      //           // return buildLoading();
      //         } else if (state is Jobgetsuccess) {
      //           List<Jobappliedpage> joblist = state.joblist;
      //           return ListView.builder(
      //               itemCount: joblist.length,
      //               itemBuilder: (context, position) {
      //                 return jobappliedlist(joblist[position], context);
      //               });
      //         }
      //         return buildLoading();
      //       },
      //     )
      //     ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("問合わせ/応募中求人",
                  style: TextStyle(
                      color: Style.CustomColor.secondaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: BlocProvider(
                create: (_) => _newbloc,
                child: BlocListener<JobappliedlistBloc, JobappliedlistState>(
                    listener: (cxt, state) {
                  if (state is Jobgetsuccess) {
                    jobs = state.joblist;
                    jobList = jobs;
                  }
                }, child: BlocBuilder<JobappliedlistBloc, JobappliedlistState>(
                  builder: (context, state) {
                    if (state is ChangestatusInitial ||
                        state is JobappliedlistInitial) {
                      return buildLoading();
                    }
                    if (jobList.length == 0) {
                      return Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(child: Text("データがありません")),
                      );
                    }
                    return LazyLoadScrollView(
                        onEndOfPage: () => _newbloc.add(Getjobappliedlist()),
                        scrollOffset: 0,
                        child: ListView.builder(
                            itemBuilder: (context, position) {
                              return jobappliedlist(jobList[position], context);
                            },
                            // separatorBuilder: (context, index) => Divider(),
                            itemCount: jobList.length));
                  },
                ))),
          ),
        ],
      ),
    );
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
  Widget jobappliedlist(Jobappliedpage jobslist, BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (jobslist.job_apply_status == '辞退/不採用')
          {print('not allowed')}
        else
          {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new JobData(job_id: jobslist.job_id))),
          }
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          children: [
            Container(
              height: 130,
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: CachedNetworkImage(
                        imageUrl: jobslist.logo_url,
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
                      //         image: NetworkImage(jobslist.logo_url),
                      //         fit: BoxFit.contain)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            widthFactor: 19.0,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  jobslist.job_post_date,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(jobslist.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  jobslist.occupation_description ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '勤務地 : ',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: jobslist.country_name,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 40,
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: Column(
                  //       // mainAxisAlignment: MainAxisAlignment.start,
                  //       children: <Widget>[
                  //         IconButton(
                  //           icon: const Icon(
                  //             Icons.star_border,
                  //             color: Colors.grey,
                  //           ),
                  //           onPressed: () {},
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Row(
                      children: [
                        for (var otherKeywords in jobslist.other_keywords)
                          if (otherKeywords.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Style.CustomColor.secondaryColor),
                              child: Text(otherKeywords,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                            ),
                        SizedBox(
                          width: 10,
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
                  // const Spacer(),
                  // if (jobslist.job_apply_status == '検討中')
                  Expanded(
                      flex: 1,
                      child: (jobslist.job_apply_status == '検討中' ||
                              jobslist.job_apply_status == '内定未請求' ||
                              jobslist.job_apply_status == '請求済' ||
                              jobslist.job_apply_status == '入金確認済')
                          ? Center(
                              child: FlatButton.icon(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.message,
                                  color: Style.CustomColor.iconColor,
                                ),
                                onPressed: () {
                                  _startChat(jobslist);
                                },
                                label: Text(
                                  'チャット開始',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            )),

                  Expanded(
                      flex: 1,
                      child: jobslist.job_apply_status == '検討中'
                          ? Center(
                              child: FlatButton.icon(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.thumb_down_alt,
                                  color: Style.CustomColor.iconColor,
                                ),
                                onPressed: () =>
                                    {changestatus(jobslist.job_apply_id)},
                                label: Text(
                                  '辞退',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            )
                          : ((jobslist.job_apply_status == '内定未請求' ||
                                  jobslist.job_apply_status == '請求済' ||
                                  jobslist.job_apply_status == '入金確認済')
                              ? Center(
                                  child: FlatButton.icon(
                                    color: Colors.white,
                                    icon: Icon(
                                      Icons.business_center_outlined,
                                      color: Colors.grey[400],
                                    ),
                                    onPressed: () => null,
                                    label: Text(
                                      '内定',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                    // disabledColor: Colors.grey[400],
                                    // disabledTextColor: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ))),

                  if (jobslist.job_apply_status == '辞退/不採用')
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text('辞退/不採用',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                      ),
                      // child: Center(
                      //   child: FlatButton.icon(
                      //     color: Colors.white,
                      //     icon: Icon(
                      //       Icons.message,
                      //       color: Colors.white,
                      //     ),
                      //     onPressed: () => null,
                      //     label: Text(
                      //       '辞退/不採用',
                      //       style:
                      //           TextStyle(fontSize: 14, color: Colors.grey),
                      //     ),
                      //     disabledColor: Colors.grey[50],
                      //     disabledTextColor: Colors.white,
                      //   ),
                      // ),
                    ),
                  // if (jobslist.job_apply_status == '内定未請求' ||
                  //     jobslist.job_apply_status == '請求済')
                  //   Expanded(
                  //     child: Center(
                  //       child: FlatButton.icon(
                  //         color: Colors.white,
                  //         icon: Icon(
                  //           Icons.message,
                  //           color: Style.CustomColor.iconColor,
                  //         ),
                  //         onPressed: () => null,
                  //         label: Text(
                  //           'チャット開始',
                  //           style: TextStyle(fontSize: 14, color: Colors.grey),
                  //         ),
                  //         disabledColor: Colors.grey[400],
                  //         disabledTextColor: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // if (jobslist.job_apply_status == '内定未請求' ||
                  //     jobslist.job_apply_status == '請求済' || jobslist.job_apply_status == '入金確認済')
                  //   Expanded(
                  //     child: Center(
                  //       child: FlatButton.icon(
                  //         color: Colors.white,
                  //         icon: Icon(
                  //           Icons.business_center_outlined,
                  //           color: Style.CustomColor.iconColor,
                  //         ),
                  //         onPressed: () => null,
                  //         label: Text(
                  //           '内定',
                  //           style: TextStyle(fontSize: 14, color: Colors.grey),
                  //         ),
                  //         disabledColor: Colors.grey[400],
                  //         disabledTextColor: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // if (jobslist.job_apply_status == '入金確認済')
                  //   Expanded(
                  //     child: Center(
                  //       child: FlatButton.icon(
                  //         color: Colors.white,
                  //         icon: Icon(
                  //           Icons.business_center_outlined,
                  //           color: Style.CustomColor.iconColor,
                  //         ),
                  //         onPressed: () => null,
                  //         label: Text(
                  //           '内定',
                  //           style: TextStyle(fontSize: 14, color: Colors.grey),
                  //         ),
                  //         disabledColor: Colors.grey[400],
                  //         disabledTextColor: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // if (jobslist.job_apply_status == '検討中')
                  //   Expanded(
                  //     child: Center(
                  //       child: FlatButton.icon(
                  //         color: Colors.white,
                  //         icon: Icon(
                  //           Icons.thumb_down_alt,
                  //           color: Style.CustomColor.iconColor,
                  //         ),
                  //         onPressed: () =>
                  //             {changestatus(jobslist.job_apply_id)},
                  //         label: Text(
                  //           '辞退',
                  //           style:
                  //               TextStyle(fontSize: 14, color: Colors.black87),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
