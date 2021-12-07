import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/jobdata.dart';
import 'package:borderlessWorking/data/model/jobdetails.dart';
import 'package:borderlessWorking/data/repositories/jobdetails_repositories.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class JobData extends StatefulWidget {
  int job_id;
  JobData({this.job_id});
  @override
  _JobDataState createState() => _JobDataState(job_id: job_id);
}

class _JobDataState extends State<JobData> {
  final int job_id;

  _JobDataState({this.job_id});

  GetjobdetailsRepository _getjobdetailsRepository = GetjobdetailsRepository();

  Future<JobDataModel> jobData;
  bool isEnabled = true;
  var joblabel = '問合わせ/応募';
  var jobstatus;
  var scoutstatus;
  void getuser() async {
    Map user = await _getjobdetailsRepository.getUserData();
    // ignore: unused_local_variable
    var userid = user['id'];
    print('tester $userid');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(child: buildLoading());
      },
    );
    var jopapplied =
        await _getjobdetailsRepository.jobapplied(job_id.toString());
    Navigator.pop(context);
    getJobAppliedlist();
    getscoutlist();
  }

  //_getjob
  void getJobAppliedlist() async {
    final getjobappliedlist = await _getjobdetailsRepository.getjobappliedlist(
      job_id.toString(),
    );
    if (getjobappliedlist != null) {
      if (getjobappliedlist.length > 0) {
        var jobapply = getjobappliedlist[0];
        jobstatus = jobapply.job_apply_status;

        setState(() {
          if (jobstatus == '検討中') {
            joblabel = '問合わせ/応募中';
          }
          if (jobstatus == "請求済" ||
              jobstatus == "内定未請求" ||
              jobstatus == "入金確認済") {
            joblabel = '内定';
          }

          isEnabled = false;
        });
      }
    }

    print('joblist $jobstatus');
  }

  //getscout
  void getscoutlist() async {
    final getscoutstatus =
        await _getjobdetailsRepository.getscoutstatus(job_id.toString());
    if (getscoutstatus != null) {
      if (getscoutstatus.length > 0) {
        var scout = getscoutstatus[0];
        scoutstatus = scout.scout_status;
        setState(() {
          if (scoutstatus == '回答待ち' || scoutstatus == '興味あり') {
            joblabel = 'スカウトされています';
          }
          if (scoutstatus == '入金確認済' ||
              scoutstatus == '内定未請求' ||
              scoutstatus == '請求済') {
            joblabel = '内定';
          }
          isEnabled = false;
        });
      }
    }

    print('scoutstatus $scoutstatus');
  }

  ApiService apiService = ApiService();
  @override
  void initState() {
    jobData = _getjobdetailsRepository.getJobData(job_id.toString());
    loginState();
    super.initState();

    print('aimon $jobData');
  }

  void loginState() async {
    final bool hasToken = await apiService.hasToken();
    if (hasToken) {
      getJobAppliedlist();
      getscoutlist();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Style.CustomColor.mainColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('詳細', style: TextStyle(color: Colors.white)),
        ),
        body: DefaultTabController(
          length: 2,
          child: Container(
            child: FutureBuilder(
                future: jobData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    JobDataModel data = snapshot.data;

                    return _buildData(data);
                  } else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                }),
          ),
        ));
  }

  Widget _buildData(JobDataModel data) {
    final Image noImage = Image.asset("assets/images/default.png");
    Jobdetails job = data.detail;

    var youtubelink = job.video;
    var youtube = [];
    youtube = youtubelink.split('/embed/');
    YoutubePlayerController _controller;
    if (!job.video.contains('youtube-frame.jpg')) {
      _controller = YoutubePlayerController(
        initialVideoId: youtube[1],
        params: YoutubePlayerParams(
          startAt: Duration(seconds: 30),
          showControls: true,
          showFullscreenButton: true,
          autoPlay: false,
          
        ),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          constraints: BoxConstraints(maxHeight: 200.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Style.CustomColor.secondaryColor, width: 3.0),
              ),
            ),
            indicatorColor: Style.CustomColor.secondaryColor,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.red,
            tabs: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 30,
                child: Text(
                  '求人詳細',
                  style: TextStyle(
                    color: Style.CustomColor.secondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.only(top: 10),
                child: Text('企業プロフィール',
                    style: TextStyle(
                      color: Style.CustomColor.secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: [
              new SingleChildScrollView(
                child: Container(
                    child: Column(children: [
                  Container(
                    // margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(children: [
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                        if (state is AuthenticationAuthenticated) {
                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            alignment: Alignment.centerLeft,
                            child: RaisedButton(
                                textColor: Colors.white,
                                disabledColor: Colors.transparent,
                                color: Colors.transparent,
                                elevation: 0,
                                hoverElevation: 0,
                                focusElevation: 0,
                                highlightElevation: 0,
                                child: joblabel == '問合わせ/応募'
                                    ? Container(
                                        width: 400,
                                        height: 50,
                                        child: RaisedButton(
                                            elevation: 5.0,
                                            color: Style
                                                .CustomColor.secondaryColor,
                                            disabledColor:
                                                Style.CustomColor.mainColor,
                                            disabledTextColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text('問合わせ/応募'),
                                            textColor: Colors.white,
                                            onPressed: () {
                                              //delete dialog box
                                              Widget cancelButton =
                                                  RaisedButton(
                                                child: Text(
                                                  'いいえ',
                                                  style: Style
                                                      .Customstyles.customText,
                                                ),
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                color: Colors.grey,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                              );

                                              Widget continueButton =
                                                  RaisedButton(
                                                child: Text(
                                                  'はい',
                                                  style: Style
                                                      .Customstyles.customText,
                                                ),
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                color: Style
                                                    .CustomColor.secondaryColor,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  getuser();
                                                  Navigator.pop(context);
                                                },
                                              );

                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Center(
                                                  child: IconTheme(
                                                    data: new IconThemeData(
                                                        color: Style.CustomColor
                                                            .mainColor,
                                                        size: 35),
                                                    child: new Icon(Icons.info),
                                                  ),
                                                ),
                                                content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      if(jobstatus == '辞退/不採用' || scoutstatus == '不採用/辞退')
                                                         Container(
                                                        child: Text(
                                                          "この求人は以前に辞退/不採用となっていますがよろしいでしょうか。",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                      else
                                                      Container(
                                                        child: Text(
                                                          "求人に問合わせ/応募しますか。",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                actions: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        cancelButton,
                                                        SizedBox(width: 10),
                                                        continueButton,
                                                      ]),
                                                ],
                                              );
                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            }

                                            //end delete dialog

                                            ),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                            SizedBox(
                                              height: 45,
                                              child: RaisedButton(
                                                  textColor: Colors.white,
                                                  disabledColor:
                                                      Colors.transparent,
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  hoverElevation: 0,
                                                  focusElevation: 0,
                                                  highlightElevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: BorderSide(
                                                          color: Colors.grey)),
                                                  child: Text(joblabel,
                                                      style: TextStyle(
                                                          color: Color(
                                                              0XFFAAAAAA)))),
                                            )
                                          ]),
                                onPressed: isEnabled
                                    ? () async {
                                        //delete dialog box
                                        Widget cancelButton = RaisedButton(
                                          child: Text(
                                            'いいえ',
                                            style:
                                                Style.Customstyles.customText,
                                          ),
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
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
                                            style:
                                                Style.Customstyles.customText,
                                          ),
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          padding: const EdgeInsets.all(10),
                                          color:
                                              Style.CustomColor.secondaryColor,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            getuser();
                                            Navigator.pop(context);
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: Center(
                                            child: IconTheme(
                                              data: new IconThemeData(
                                                  color: Style
                                                      .CustomColor.mainColor,
                                                  size: 35),
                                              child: new Icon(Icons.info),
                                            ),
                                          ),
                                          content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "求人に問合わせ/応募しますか。",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          actions: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
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

                                    //end delete dialog

                                    : null),
                          );
                        }
                        if (state is AuthenticationUnauthenticated) {
                          return Container(child: Text(' '));
                        }
                        return Center(child: CupertinoActivityIndicator());
                      }),
                      Container(
                        child: Row(children: [
                          if (job.updated == null)
                            Container(
                                margin: const EdgeInsets.only(left: 0, top: 0),
                                child: Text(' '))
                          else
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                job.updated,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff4772bf),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          if (job.updated == null)
                            Text(' ')
                          else
                            Container(
                                margin: const EdgeInsets.only(
                                  left: 5,
                                ),
                                alignment: Alignment.topCenter,
                                child: Text(
                                  'に求人詳細が修正されています',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff4772bf),
                                      fontWeight: FontWeight.bold),
                                ))
                        ]),
                      ),
                      if (job.updated != null) SizedBox(height: 10),
                      //job_seekerno
                        Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '求人番号',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Style.CustomColor.secondaryColor),
                        ),
                      ),
                      if (job.job_number == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.job_number,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //job_seekerno
                      SizedBox(height: 15),
                      //job_title
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '求人タイトル',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Style.CustomColor.secondaryColor),
                        ),
                      ),
                      if (job.title == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.title,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //job_title
                      SizedBox(height: 15),
                      //job_description
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '職種',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Style.CustomColor.secondaryColor),
                        ),
                      ),
                      if (job.occupation_description == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.occupation_description,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //job_description
                      SizedBox(height: 15),
                      //employment_types
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('雇用形態',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.employment_types == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.employment_types,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //employment_types
                      SizedBox(height: 15),
                      //jobdecribe
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('仕事内容',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.job_description == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.job_description,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //jobdecribe
                      SizedBox(height: 15),
                      //quali
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('応募資格・語学力',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.qualification == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.qualification,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //quali
                      SizedBox(height: 15),
                      //location
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('給与・待遇・ビザサポート',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.allowance == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.allowance,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //location
                      SizedBox(height: 15),
                      //job_start_date
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('勤務開始日',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.job_start_date == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.job_start_date,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //job_start_date
                      SizedBox(height: 15),
                      //location
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('勤務地詳細',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.job_location == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.job_location,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //location
                      SizedBox(height: 15),
                      //message
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        alignment: Alignment.centerLeft,
                        child: Text('求職者へのメッセージ ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Style.CustomColor.secondaryColor)),
                      ),
                      if (job.message == null)
                        Text('')
                      else
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(job.message,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ),
                      //message
                      SizedBox(height: 20),
                    ]),
                  )
                ])),
              ),
              //Recruiter
              new SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(children: [
                        //image
                        Container(
                            padding: EdgeInsets.all(5),
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300],
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[500].withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(job.logo_url),
                                    fit: BoxFit.contain))),

                        //image
                        SizedBox(height: 22),
                        //recruiter_name
                        Center(
                          child: Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: Text(
                                job.recruiter_name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              )),
                        ),

                        //recruiter_name
                        SizedBox(height: 10),
                        //recrutier_number
                        Container(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                          child: Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          '会員番号:',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Style
                                                  .CustomColor.secondaryColor),
                                        ),
                                      )),
                                      TextSpan(
                                        text: job.recruiter_number,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                // em_number
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                          child: Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(Icons.people, size: 20),
                                      )),
                                      if (job.num_of_employees == null)
                                        TextSpan(text: '')
                                      else
                                        TextSpan(
                                            text: job.num_of_employees,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      WidgetSpan(
                                          child: Container(
                                        padding: EdgeInsets.only(right: 2),
                                      )),
                                      TextSpan(
                                          text: '従業',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        //recruiter_number
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          alignment: Alignment.centerLeft,
                          // width: 390,
                          // height: 350,
                          color: Colors.grey[200],
                          child: Column(children: [
                            //establishment_date
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              alignment: Alignment.centerLeft,
                              child: Text('設立年月日',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Style.CustomColor.secondaryColor)),
                            ),
                            if (job.establishment_date == null)
                              Text('')
                            else
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(job.establishment_date,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600])),
                              ),
                            //establishment_date

                            //Representaive_name
                            Container(
                              margin: const EdgeInsets.only(left: 15, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text('代表者氏名',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Style.CustomColor.secondaryColor)),
                            ),
                            if (job.representative_name == null)
                              Text('')
                            else
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(job.representative_name,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600])),
                              ),
                            //Representaive_name

                            //business_des
                            Container(
                              margin: const EdgeInsets.only(left: 13, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text('事業内容',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Style.CustomColor.secondaryColor)),
                            ),
                            if (job.business_description == null)
                              Text('')
                            else
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(job.business_description,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600])),
                              ),
                            //business_des
                            //company_pr
                            Container(
                              margin: const EdgeInsets.only(left: 15, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Text('会社PR等',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Style.CustomColor.secondaryColor)),
                            ),
                            if (job.company_pr == null)
                              Text('')
                            else
                              Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Text(job.company_pr,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[600])),
                              ),
                            //company_pr
                          ]),
                        ),
                        //image
                        //video
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          color: Colors.grey[200],
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(left: 15),
                                child: Text('関連画像',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Style.CustomColor.secondaryColor)),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 13),
                                  child: Text('')),
                              Column(
                                children: [
                                  if (data.related_files.length == 0)
                                    Container(
                                      // width: 500,
                                      // height: 150,
                                      child: Image.asset(
                                        'assets/images/default.png',
                                      ),
                                    )
                                  else
                                    Center(
                                        child: SizedBox(
                                      height: 150.0,
                                      width: 300.0,
                                      child: Carousel(
                                        boxFit: BoxFit.cover,
                                        autoplay: true,
                                        animationCurve: Curves.fastOutSlowIn,
                                        animationDuration:
                                            Duration(milliseconds: 500),
                                        dotSize: 6.0,
                                        dotIncreasedColor:
                                            Style.CustomColor.secondaryColor,
                                        dotBgColor: Colors.transparent,
                                        dotPosition: DotPosition.bottomCenter,
                                        dotVerticalPadding: 10.0,
                                        showIndicator: true,
                                        indicatorBgPadding: 7.0,
                                        images: data.related_files.map((e) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: (e.url !=
                                                          null) // Only use the network image if the url is not null
                                                      ?
                                                      // Text(e.url)
                                                      Image(
                                                          image: NetworkImage(
                                                              Apis.siteUrl+'/uploads/recruiters/images/${e.url}'),
                                                        )
                                                      : noImage);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          color: Colors.grey[200],
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(top: 20, bottom: 20, left: 15),
                          margin: const EdgeInsets.only(top: 20, bottom: 0),
                          child: Text('関連動画',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Style.CustomColor.secondaryColor)),
                        ),

                        Container(
                            color: Colors.grey[200],
                            width: MediaQuery.of(context).size.width,
                            child: job.video.contains('youtube-frame.jpg') ==
                                    false
                                ? Container(
                                    color: Colors.grey[200],
                                    margin: const EdgeInsets.only(
                                        left: 15, right: 15, bottom: 20),
                                    child: YoutubePlayerIFrame(
                                      controller: _controller,
                                      aspectRatio: 16 / 9,
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey[200],
                                    child: Image.network(
                                        Apis.siteUrl+'/images/youtube-frame.jpg'))),
                      ])))
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
}
