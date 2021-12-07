import 'package:borderlessWorking/Widget/jobCard/jobCard_widget.dart';
import 'package:borderlessWorking/bloc/job_bloc/job_bloc.dart';
import 'package:borderlessWorking/bloc/jobappliedlist/bloc/jobappliedlist_bloc.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _buildList(),
    ));
  }
  // _buildList()

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
  Widget _buildList() {
    return Column(
      children: [searchInput(), Expanded(child: JobList())],
    );
  }
}

class searchInput extends StatelessWidget {
  final AuthRepository authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       filled: true,
        //       fillColor: Colors.white,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(20.0),
        //       ),
        //       hintText: 'キーワードで絞り込む',
        //       hintStyle: TextStyle(color: Colors.grey),
        //       prefixIcon: Icon(Icons.search),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 9, 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("求人　新着順",
                    style: TextStyle(
                        color: Style.CustomColor.secondaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
            //   decoration: BoxDecoration(
            //       color: Colors.blue[700],
            //       borderRadius: BorderRadius.all(Radius.circular(7.0))),
            //   child: RaisedButton.icon(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           new MaterialPageRoute(
            //               builder: (context) => new PublicHomeScreen(
            //                     authRepository: authRepository,
            //                     selectedIndex: 1,
            //                     countryList: [],
            //                     occupationList: [],
            //                   )));
            //       // Navigator.of(context).pushNamed('/public-home', arguments: null);
            //     },
            //     icon: Icon(Icons.group_work),
            //     label: Text(
            //       '職種や勤務地から探す',
            //       style: Style.Customstyles.customText,
            //     ),
            //     elevation: 2.0,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     padding: const EdgeInsets.all(15),
            //     color: Style.CustomColor.secondaryColor,
            //     textColor: Style.CustomColor.bodyColor,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  final JobBloc _jobBloc = JobBloc();
  List<Job> jobs = [];
  List<Job> jobList = [];
  List<dynamic> favjobidList = [];
  void initState() {
    super.initState();
    _jobBloc.add(GetJobList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
          create: (_) => _jobBloc,
          child: BlocListener<JobBloc, JobState>(listener: (cxt, state) {
            if (state is JobSuccess) {
              jobs = state.jobs;
              jobList = jobs;
              jobList
                  .map((x) => {
                        if (x.fav != "") {favjobidList.add(x.job_id)}
                      })
                  .toList();
            }
          }, child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobInitial || state is JoblistLoading) {
                return buildLoading();
              }
              if (jobList.length == 0) {
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Text("データがありません")),
                );
              }
              return LazyLoadScrollView(
                  onEndOfPage: () => _jobBloc.add(GetJobList()),
                  // scrollOffset: 0,
                  child: ListView.builder(
                      itemBuilder: (context, position) {
                        return JobCard(
                            jobs: jobList[position], favJobLists: favjobidList);
                        // return jobCard(jobList[position], context, []);
                      },
                      // separatorBuilder: (context, index) => Divider(),
                      itemCount: jobList.length));
            },
          ))),
    );
  }
}

Widget buildLoading() => Center(child: CupertinoActivityIndicator());
