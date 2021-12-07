import 'package:borderlessWorking/Widget/jobCard/jobCard_widget.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/repositories/public_search_repositories.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class PublicSearchResult extends StatefulWidget {
  final jobsData;

  const PublicSearchResult({Key key, this.jobsData}) : super(key: key);

  @override
  _PublicSearchResultState createState() => _PublicSearchResultState();
}

PublicSearchRepository publicsearchRepo = new PublicSearchRepository();

class _PublicSearchResultState extends State<PublicSearchResult> {
  int page = 1;
  @override
  bool noData = false;
  void initState() {
    super.initState();
    if (widget.jobsData[0].length != 0) {
      this.noData = true;
    }
  }

  Widget build(BuildContext context) {
    List<Job> list = widget.jobsData[0];
    List favjobidList = widget.jobsData[1];
    var searchData = widget.jobsData[2];

    void _onLoadData() async {
      page++;
      List<Job> result = await publicsearchRepo.getJobs(page, searchData);
      setState(() {
        if (result.length == 0) {
          page--;
        } else {
          list.addAll(result);
          favjobidList = [];
          list
              .map((x) => {
                    if (x.fav != '') {favjobidList.add(x.job_id)}
                  })
              .toList();
          widget.jobsData[1] = favjobidList;
        }
      });
    }

    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Style.CustomColor.mainColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('検索結果', style: TextStyle(color: Colors.white)),
        ),
     
      body: noData
          ? LazyLoadScrollView(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return JobCard(
                      jobs: list[position], favJobLists: favjobidList);
                },
                itemCount: list.length,
              ),
              onEndOfPage: _onLoadData)
          : Container(
              child: Center(child: Text("検索条件に合致するデータがみつかりません")),
            ),
    );
  }
}
