import 'package:borderlessWorking/Widget/scout/scout_card_widget.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/scouted_list_bloc/scouted_list_bloc.dart';
import 'package:borderlessWorking/data/model/scout.dart';
import 'package:borderlessWorking/data/repositories/scout_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:timezone/data/latest.dart' as tz;

class ScoutedList extends StatefulWidget {
  @override
  _ScoutedListState createState() => _ScoutedListState();
}

class _ScoutedListState extends State<ScoutedList> {
  final ScoutedListBloc _bloc = ScoutedListBloc();
  final ScoutRepository _scoutRepository = ScoutRepository();
  List _total = [
    {"total": 0, "unread_count": 0}
  ];
  List<Scout> scoutedList = [];

  void getCountAndTotal() async {
    final data = await _scoutRepository.getScoutedListTotal();
    setState(() {
      _total[0]["unread_count"] = data[0]["unread_count"];
      _total[0]["total"] = data[0]["total"];
    });
  }

  @override
  void initState() {
    _bloc.add(GetList());
    super.initState();
    getCountAndTotal();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          // decoration: BoxDecoration(
          //   color: Style.CustomColor.grey,
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 0.0,
            ),
            child: 
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 10, 9, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "スカウトを受けている求人",
                      style: TextStyle(
                        color: Style.CustomColor.secondaryColor, 
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5.0, 0, 0, 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                "未読 " +
                    _total[0]["unread_count"].toString() +
                    " 件 (全 " +
                    _total[0]["total"].toString() +
                    " 件)",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 14),
              ),
                  ),
                ),
              ],
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              // leading: Text(
              //   "スカウトを受けている求人 未読 " +
              //       _total[0]["unread_count"].toString() +
              //       " 件 (全 " +
              //       _total[0]["total"].toString() +
              //       " 件)",
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyText2
              //       .copyWith(fontSize: 14),
              // ),
            // ),
          ),
        ),
        Expanded(
            child: BlocProvider(
          create: (context) => BlocProvider.of<AuthenticationBloc>(context),
          child: item(context),
        ))
      ]),
    );
  }

  Widget item(context) {
    return BlocProvider<ScoutedListBloc>(
        create: (_) => _bloc,
        child: BlocListener<ScoutedListBloc, ScoutedListState>(
          listener: (context, state) {
            if (state is ScoutedListSuccess) {
              scoutedList = state.scoutedList;
              getCountAndTotal();
            }
          },
          child: BlocBuilder<ScoutedListBloc, ScoutedListState>(
            builder: (context, state) {
              if (state is ScoutedListInitial || state is ActionLoading) {
                return buildLoading();
              }
              if(scoutedList.length == 0) {
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Text("データがありません")),
                );
              }
              return LazyLoadScrollView(
                onEndOfPage: () => _bloc.add(GetList()),
                scrollOffset: 0,
                child: ListView.builder(
                    itemCount: scoutedList.length,
                    itemBuilder: (context, position) {
                      return scoutCard(scoutedList[position], context, 'list');
                    }),
              );
            },
          ),
        ));
  }
}

Widget buildLoading() => Center(child: CupertinoActivityIndicator());
