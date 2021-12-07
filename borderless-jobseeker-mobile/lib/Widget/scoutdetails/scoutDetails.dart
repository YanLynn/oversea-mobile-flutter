import 'package:borderlessWorking/Widget/scout/scout_card_widget.dart';
import 'package:borderlessWorking/bloc/scoutdetails/bloc/scoutdetails_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/jobdata.dart';
import 'package:borderlessWorking/data/model/jobdetails.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/data/repositories/jobdetails_repositories.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:timezone/data/latest.dart' as tz;

class ScoutDetails extends StatefulWidget {
  final int scoutId;
  final int jobid;
  ScoutDetails({this.scoutId, this.jobid});
  @override
  _ScoutDetailsState createState() =>
      _ScoutDetailsState(this.scoutId, this.jobid);
}

class _ScoutDetailsState extends State<ScoutDetails>
    with SingleTickerProviderStateMixin {
  final AuthRepository authRepository = AuthRepository();
  final ScoutdetailsBloc _newbloc = ScoutdetailsBloc();
  final int scoutId, jobid;
  _ScoutDetailsState(this.scoutId, this.jobid);
  GetjobdetailsRepository _getjobdetailsRepository = GetjobdetailsRepository();

  final List<Widget> myTabs = [
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
  ];

  TabController _tabController;

  Future<JobDataModel> jobData;
  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _newbloc.add(Getscoutdetails(scoutId.toString()));
    jobData = _getjobdetailsRepository.getJobData(jobid.toString());
    super.initState();
    tz.initializeTimeZones();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  _listItem() {
    return BlocProvider(
        create: (_) => _newbloc,
        child: BlocBuilder<ScoutdetailsBloc, ScoutdetailsState>(
          builder: (context, state) {
            if (state is ScoutdetailsInitial) {
              return buildLoading();
            } else if (state is Getscoutdetailssuccess) {
              List<Scout> scoutlist = state.scoutlist;
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: scoutlist.length,
                  itemBuilder: (context, position) {
                    return Column(children: [
                      scoutCard(scoutlist[position], context, 'details'),
                    ]);
                  });
            } else if (state is Scoutremovesuccess) {
              Future.delayed(const Duration(milliseconds: 0), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => new PublicHomeScreen(
                            authRepository: authRepository,
                            checkAlert: '',
                            selectedIndex: 4,
                            
                          )),
                );
              });
              // Future.delayed(Duration.zero, () {
              //   Navigator.push(
              //       context,
              //       new MaterialPageRoute(
              //           builder: (context) => new PublicHomeScreen(
              //                 authRepository: authRepository,
              //                 selectedIndex: 4,
              //               )));
              // });
            } else if (state is Scoutsuccess) {
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => new ScoutDetails(
                            scoutId: scoutId,
                            jobid: jobid,
                          )),
                );
              });
              // Future.delayed(Duration.zero, () {
              //   Navigator.push(
              //       context,
              //       new MaterialPageRoute(
              //           builder: (context) => new ScoutDetails(
              //                 scoutId: scoutId,
              //                 jobid: jobid,
              //               )));
              // });
            }
            return buildLoading();
          },
        ));
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
                            selectedIndex: 4,
                            
                          )));
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

  @override
  Widget _buildData(JobDataModel data) {
    final Image noImage = Image.asset("assets/images/img.png");
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
    return Scaffold(
      body: BlocProvider(
          create: (_) => _newbloc,
          child: BlocBuilder<ScoutdetailsBloc, ScoutdetailsState>(
            builder: (context, state) {
              if (state is ScoutdetailsInitial) {
                return buildLoading();
              } else if (state is Getscoutdetailssuccess) {
                List<Scout> scoutlist = state.scoutlist;
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: scoutlist.length,
                    itemBuilder: (context, position) {
                      return Column(children: [
                        scoutCard(scoutlist[position], context, 'details'),
                        //Jobdetails
                        Container(
                          margin: EdgeInsets.only(top: 10),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(color: Colors.white, blurRadius: 4.0)
                              ],
                              border: Border(
                                bottom: BorderSide(
                                    color: Style.CustomColor.secondaryColor,
                                    width: 3.0),
                              ),
                            ),
                            controller: _tabController,
                            labelColor: Colors.redAccent,
                            tabs: myTabs,
                          ),
                        ),
                        Center(
                          child: [
                            Column(
                              children: [
                                Container(
                                    child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    child: Column(children: [
                                      Container(
                                        child: Row(children: [
                                          if (job.updated == null)
                                            Text('')
                                          else
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                job.updated,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff4772bf),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          if (job.updated == null)
                                            Text('')
                                          else
                                            Container(
                                                margin: const EdgeInsets.only(
                                                  left: 5,top: 5,
                                                ),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  'に求人詳細が修正されています',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff4772bf),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                        ]),
                                      ),
                                      SizedBox(height: 10),
                                      //job_seekerno
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '求人番号',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Style
                                                  .CustomColor.secondaryColor),
                                        ),
                                      ),
                                      if (job.job_number == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.job_number,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                              color: Style
                                                  .CustomColor.secondaryColor),
                                        ),
                                      ),
                                      if (job.title == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.title,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                              color: Style
                                                  .CustomColor.secondaryColor),
                                        ),
                                      ),
                                      if (job.occupation_description == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(
                                              job.occupation_description,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
                                        ),
                                      //job_description
                                      SizedBox(height: 15),
                                      //employment_types
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text('雇用形態',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.employment_types == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.employment_types,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
                                        ),
                                      //employment_types
                                      SizedBox(height: 15),
                                      //jobdecribe
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text('仕事内容',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.job_description == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.job_description,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.qualification == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.qualification,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.allowance == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.allowance,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.job_start_date == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.job_start_date,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.job_location == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.job_location,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
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
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),
                                      if (job.message == null)
                                        Text('')
                                      else
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(job.message,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600])),
                                        ),
                                      SizedBox(height: 30),
                                      //message
                                    ]),
                                  )
                                ])),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 15),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[500]
                                                      .withOpacity(0.1),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      job.logo_url),
                                                  fit: BoxFit.contain))),
                                      //image
                                      SizedBox(height: 22),
                                      //recruiter_name
                                      Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 15, right: 15),
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
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                        child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Text(
                                                        '会員番号:',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Style
                                                                .CustomColor
                                                                .secondaryColor),
                                                      ),
                                                    )),
                                                    TextSpan(
                                                      text:
                                                          job.recruiter_number,
                                                      style: TextStyle(
                                                          color: Colors.black),
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
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(Icons.people,
                                                          size: 20),
                                                    )),
                                                    if (job.num_of_employees ==
                                                        null)
                                                      TextSpan(text: '')
                                                    else
                                                      TextSpan(
                                                          text: job
                                                              .num_of_employees,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    WidgetSpan(
                                                        child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 2),
                                                    )),
                                                    TextSpan(
                                                        text: '従業',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                      //recruiter_number
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        alignment: Alignment.centerLeft,
                                        // width: 390,
                                        // height: 350,
                                        color: Colors.grey[200],
                                        child: Column(children: [
                                          //establishment_date
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Text('設立年月日',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Style.CustomColor
                                                        .secondaryColor)),
                                          ),
                                          if (job.establishment_date == null)
                                            Text('')
                                          else
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                  job.establishment_date,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600])),
                                            ),
                                          //establishment_date

                                          //Representaive_name
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 15, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text('代表者氏名',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Style.CustomColor
                                                        .secondaryColor)),
                                          ),
                                          if (job.representative_name == null)
                                            Text('')
                                          else
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                  job.representative_name,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600])),
                                            ),
                                          //Representaive_name

                                          //business_des
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 13, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text('事業内容',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Style.CustomColor
                                                        .secondaryColor)),
                                          ),
                                          if (job.business_description == null)
                                            Text('')
                                          else
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(
                                                  job.business_description,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600])),
                                            ),
                                          //business_des
                                          //company_pr
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 15, top: 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text('会社PR等',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Style.CustomColor
                                                        .secondaryColor)),
                                          ),
                                          if (job.company_pr == null)
                                            Text('')
                                          else
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Text(job.company_pr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600])),
                                            ),
                                          //company_pr
                                        ]),
                                      ),
                                      //image
                                      //video
                                      SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        color: Colors.grey[200],
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text('関連画像',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Style.CustomColor
                                                          .secondaryColor)),
                                            ),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                margin: const EdgeInsets.only(
                                                    left: 13),
                                                child: Text('')),
                                            Column(
                                              children: [
                                                if (data.related_files.length ==
                                                    0)
                                                  Container(
                                                    // width: 500,
                                                    // height: 150,
                                                    child: Image.asset(
                                                      'assets/images/img.png',
                                                      width: 150,
                                                      height: 150,
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
                                                      animationCurve:
                                                          Curves.fastOutSlowIn,
                                                      animationDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  500),
                                                      dotSize: 6.0,
                                                      dotIncreasedColor: Style
                                                          .CustomColor
                                                          .secondaryColor,
                                                      dotBgColor:
                                                          Colors.transparent,
                                                      dotPosition: DotPosition
                                                          .bottomCenter,
                                                      dotVerticalPadding: 10.0,
                                                      showIndicator: true,
                                                      indicatorBgPadding: 7.0,
                                                      images: data.related_files
                                                          .map((e) {
                                                        return Builder(
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: (e.url !=
                                                                        null) // Only use the network image if the url is not null
                                                                    ?
                                                                    // Text(e.url)
                                                                    Image(
                                                                        image: NetworkImage(Apis.siteUrl +
                                                                            '/uploads/recruiters/images/${e.url}'),
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
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 20, left: 15),
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 0),
                                        child: Text('関連動画',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Style.CustomColor
                                                    .secondaryColor)),
                                      ),

                                      Container(
                                          color: Colors.grey[200],
                                           width: MediaQuery.of(context).size.width,
                                          child: job.video.contains(
                                                      'youtube-frame.jpg') ==
                                                  false
                                              ? Container(
                                                  color: Colors.grey[200],
                                                  margin: const EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      bottom: 20),
                                                  child: YoutubePlayerIFrame(
                                                    controller: _controller,
                                                    aspectRatio: 16 / 9,
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.grey[200],
                                                  child: Image.network(Apis
                                                          .siteUrl +
                                                      '/images/youtube-frame.jpg'))),
                                    ])),
                              ],
                            ),
                          ][_tabController.index],
                        ),
                        //Jobdetails
                      ]);
                    });
              } else if (state is Scoutremovesuccess) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => new PublicHomeScreen(
                              authRepository: authRepository,
                              checkAlert: '',
                              selectedIndex: 4,
                              
                            )),
                  );
                });
              } else if (state is Scoutsuccess) {
                Future.delayed(const Duration(milliseconds: 0), () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => new ScoutDetails(
                              scoutId: scoutId,
                              jobid: jobid,
                            )),
                  );
                });
              }
              return buildLoading();
            },
          )), //listview
    );
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
}
