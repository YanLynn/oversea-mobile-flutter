import 'package:borderlessWorking/Widget/jobdetails/jobdetails.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth_bloc.dart';
import 'package:borderlessWorking/bloc/favouritejobs_bloc/favouritejobs_bloc.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/favouritejobs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:sizer/sizer.dart';

class FavouriteCard extends StatefulWidget {
  // final AuthRepository authRepository;
  // FavouriteCard({Key key, @required this.authRepository}) : super(key: key);
  @override
  _FavouriteCard createState() => _FavouriteCard();
}

class _FavouriteCard extends State<FavouriteCard> {
  // final AuthRepository authRepository;
  // _FavouriteCard(this.authRepository);
  bool clicked = false;

  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }

  final FavouritejobsBloc _favBloc = FavouritejobsBloc();
  List<FavouritejobsModel> _favList = [];
  List<FavouritejobsModel> _favListData = [];
  String filterText = '';
  @override
  void initState() {
    _favBloc.add(GetFavList());
    super.initState();
    getFavCount();
    _favList = _favListData;
  }

  int count = 0;
  getFavCount() async {
    bool hasToken = await ApiService().hasToken();
    if (hasToken) {
      count = await ApiService().getAllFavCount();
      Apis.notificationCounterValueNotifer.value = count;
    }
  }

  Widget _searchBar() {
    // final _filterText = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(2.h),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'キーワードを入力してください',
          hintStyle: TextStyle(color: Color(0xffc1c1c1)),
          prefixIcon: Icon(Icons.search),
          // suffix: GestureDetector(
          //   onTap: () {
          //     _filterText.clear();
          //   },
          //   child: Icon(Icons.clear),
          // )
        ),
        onChanged: (text) {
          _filterList(text);
        },
      ),
    );
  }

  _filterList(String filterText) {
    List<FavouritejobsModel> _result = [];

    _result = _favListData.where((x) {
      final String _title = (x?.title ?? "").toLowerCase();
      final String _jobDe = (x?.occupation_description ?? "").toLowerCase();
      final String _countryName = (x?.country_name ?? "").toLowerCase();

      return _title.contains(filterText.toLowerCase()) ||
          _jobDe.contains(filterText.toLowerCase()) ||
          _countryName.contains(filterText.toLowerCase());
    }).toList();

    setState(() {
      this.filterText = filterText;
      this._favList = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 9, 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("お気に入り求人検索",
                  style: TextStyle(
                      color: Style.CustomColor.secondaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
              child: Container(
            child: BlocProvider(
                create: (_) => _favBloc,
                child: BlocListener<FavouritejobsBloc, FavouritejobsState>(
                  listener: (context, state) => {
                    if (state is FavouritejobsSuccess)
                      {
                        _favListData = state.favouritejobs,
                        _favList = _favListData
                      }
                  },
                  child: BlocBuilder<FavouritejobsBloc, FavouritejobsState>(
                      // ignore: missing_return
                      builder: (cxt, state) {
                    if (state is FavouritejobsInitial) {
                      return buildLoading();
                    } else if (state is RemoveFavouritejobsLoading) {
                      return buildLoading();
                    } else if (state is FavouritejobsSuccess) {
                      return Container(
                        child: Column(
                          children: [
                            _searchBar(),
                            if (_favList.length == 0)
                              Text('お気に入り求人はありません')
                            else
                              Expanded(
                                  child: ListView.builder(
                                itemCount: _favList.length,
                                itemBuilder: (cxt, position) {
                                  return item(
                                      _favList[position], context, state);
                                },
                              ))
                          ],
                        ),
                      );
                    }
                  }),
                )),
          ))
        ]);
      }

      return buildLoading();
    }));
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());

  Widget item(FavouritejobsModel model, BuildContext context, state) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new JobData(job_id: model.job_id))),
      },
      // actionPane: SlidableDrawerActionPane(),

      child: Card(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
        clipBehavior: Clip.antiAlias,
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
                        imageUrl: model.logo_url,
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
                      //         image: NetworkImage(model.logo_url),
                      //         fit: BoxFit.contain)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 0),
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
                                  model.job_post_date,
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
                            child: Text(model.title ?? '',
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
                                  model.occupation_description ?? '',
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
                                alignment: Alignment.bottomLeft,
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
                                        text: model.country_name,
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
                  Container(
                    width: 40,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              deleteAlertDialog(context, model.job_id);
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
                        if (model.other_keywords.isNotEmpty)
                          _keywordList(model, context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//delete dialog box
  deleteAlertDialog(BuildContext context, jobID) {
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
        _favBloc.add(RemoveFavList(id: jobID));
        Apis.notificationCounterValueNotifer.value--;
        Navigator.of(context).pop();
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
            "削除しますか。",
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

  Widget _keywordList(FavouritejobsModel post, BuildContext context) {
    return Row(
      children: [
        for (var otherKeywords in post.other_keywords)
          if (otherKeywords.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Style.CustomColor.secondaryColor),
              child: Text(otherKeywords,
                  style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
      ],
    );
  }
}
