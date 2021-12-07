import 'package:borderlessWorking/Widget/jobdetails/jobdetails.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/api/apis.dart';
// import 'package:borderlessWorking/bloc/job_bloc/job_bloc.dart';
import 'package:borderlessWorking/data/model/job.dart';
import 'package:borderlessWorking/data/repositories/public_search_repositories.dart';
import 'package:borderlessWorking/screens/public_search/public_search_result.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobCard extends StatefulWidget {
  final jobs;
  final favJobLists;
  const JobCard({Key key, @required this.jobs, @required this.favJobLists})
      : super(key: key);

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  Apis apis = new Apis();

  @override
  void initState() {
    super.initState();
  }

  void addAndRemoveFavJob(jobId) async {
    if (widget.favJobLists.contains(jobId)) {
      await publicSearchRepo.addAndRemoveFavJob(jobId, 'remove');
      Apis.notificationCounterValueNotifer.value--;
    } else {
      await publicSearchRepo.addAndRemoveFavJob(jobId, 'add');
      Apis.notificationCounterValueNotifer.value++;
    }
    setState(() {
      if (widget.favJobLists.contains(jobId)) {
        widget.jobs.fav = '';
        widget.favJobLists.remove(jobId);
      } else {
        widget.favJobLists.add(jobId);
        widget.jobs.fav = 'fav';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (cxt, state) {
      return jobCard(widget.jobs, context, widget.favJobLists, state);
    });
  }

  final PublicSearchRepository publicSearchRepo = new PublicSearchRepository();
  PublicSearchResult searchResult = new PublicSearchResult();

  @override
  Widget jobCard(Job jobs, BuildContext context, favJobLists, state) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new JobData(job_id: jobs.job_id))),
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
                     margin: EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: jobs.logo_url,
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
                    // child: Container(
                    //   margin: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(jobs.logo_url),
                    //           fit: BoxFit.contain)),
                    // ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            widthFactor: 19.0,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  jobs.job_post_date,
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
                            child: Text(jobs.title ?? '',
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
                                  jobs.occupation_description ?? '',
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
                                        text: jobs.country_name,
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
                  if (state is AuthenticationUnauthenticated)
                    Container(width: 10),
                  if (state is AuthenticationAuthenticated)
                    Container(
                      width: 40,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: jobs.fav == 'fav'
                                  ? Icon(
                                      Icons.star_rounded,
                                      color: Colors.orange,
                                    )
                                  : Icon(
                                      Icons.star_border,
                                      color: Colors.black26,
                                    ),
                              onPressed: () {
                                addAndRemoveFavJob(jobs.job_id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                    child: Row(
                      children: [
                        for (var otherKeywords in jobs.other_keywords)
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
            // if (cardType == 'publicSearch')
          ],
        ),
      ),
    );
  }
}
