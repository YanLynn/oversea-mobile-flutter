import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/style/theme.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

Widget buildLoading() => Center(child: CupertinoActivityIndicator());

Widget item(List model, List<String> langlist, BuildContext context) {
  @override
  var youtubelink = model[0].selfIntroDetails.video;
  var youtube;
  YoutubePlayerController _controller;
  if (youtubelink != null) {
    if (youtubelink.contains('embed/')) {
      youtube = youtubelink.split('embed/')[1];
    } else {
      youtube = 'Jjase8-PQ_w&list=RDJjase8-PQ_w&index=1';
    }

    _controller = YoutubePlayerController(
      initialVideoId: youtube,
      params: YoutubePlayerParams(
        autoPlay: false,
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  } else {
    _controller = YoutubePlayerController(
      initialVideoId: 'Jjase8-PQ_w&list=RDJjase8-PQ_w&index=1',
      params: YoutubePlayerParams(
        autoPlay: false,
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  String imageUrl = model[0].selfIntro['face_image_url'].toString();
  final Image noImage = Image.asset("assets/images/default.png");

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }

  selfPr() {
    if (model[0].selfIntroDetails.self_pr == null ||
        model[0].selfIntroDetails.self_pr == '') {
      return '';
    } else {
      return model[0].selfIntroDetails.self_pr;
    }
  }

  desiredLocaton(int i) {
    if (i == 1) {
      if (model[0].selfIntroDetails.desired_location_1 == null ||
          model[0].selfIntroDetails.desired_location_1 == '') {
        return '未入力';
      } else {
        return model[0].selfIntroDetails.desired_location_1;
      }
    }
    if (i == 2) {
      if (model[0].selfIntroDetails.desired_location_2 == null ||
          model[0].selfIntroDetails.desired_location_2 == '') {
        return '未入力';
      } else {
        return model[0].selfIntroDetails.desired_location_2;
      }
    }
    if (i == 3) {
      if (model[0].selfIntroDetails.desired_location_3 == null ||
          model[0].selfIntroDetails.desired_location_3 == '') {
        return '未入力';
      } else {
        return model[0].selfIntroDetails.desired_location_3;
      }
    }
  }

  return Container(
      child: SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Column(
      children: [
        //image label
        // Container(
        //   margin: const EdgeInsets.only(left: 15, top: 10),
        //   alignment: Alignment.centerLeft,
        //   child: Text('関連画像',
        //       style: TextStyle(
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold,
        //           color: Style.CustomColor.secondaryColor)),
        // ),
        //image url
        // Padding(
        //     padding: EdgeInsets.only(top: 10, bottom: 20),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.max,
        //       children: <Widget>[
        //         Container(
        //           width: 130,
        //           height: 130,
        //           child: Align(
        //             alignment: Alignment.bottomCenter,
        //             child: Image.network(imageUrl, fit: BoxFit.contain),
        //           ),
        //         ),
        //       ],
        //     )),
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Style.CustomColor.grey,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "スカウト待ち人材検索用自己紹介",
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.bold),
            ),
          ),
        ),
        //image slider
        Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          // color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text('関連画像',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Style.CustomColor.secondaryColor)),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 13),
                  child: Text('')),
              Column(
                children: [
                  if (imageUrl.length == 0)
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
                      width: MediaQuery.of(context).size.width,
                      child: Carousel(
                          boxFit: BoxFit.contain,
                          autoplay: true,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 500),
                          dotSize: 6.0,
                          dotIncreasedColor: Style.CustomColor.secondaryColor,
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.bottomCenter,
                          dotVerticalPadding: 10.0,
                          showIndicator: true,
                          indicatorBgPadding: 7.0,
                          images: [
                            NetworkImage(imageUrl),
                            for (int i = 0;
                                i < model[0].selfIntro['related_images'].length;
                                i++)
                              NetworkImage(model[0].selfIntro['related_images']
                                  [i]['file_url']),
                          ]),
                    )),
                ],
              ),
            ],
          ),
        ),
        //end image slider
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        //youtube label
        Container(
          margin: const EdgeInsets.only(left: 15, top: 20,bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text('関連動画',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Style.CustomColor.secondaryColor)),
        ),

        youtubelink != null
            ? Container(
                color: Colors.grey[200],
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: YoutubePlayerIFrame(
                  controller: _controller,
                  aspectRatio: 16 / 9,
                ),
              )
            : Container(
               margin: const EdgeInsets.only(bottom: 20),
                color: Colors.grey[200],
                child:
                    Image.network(Apis.siteUrl + '/images/youtube-frame.jpg')),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),

        //occupation_name
        Container(
          margin:
              const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
          child: Row(
            children: [
              Container(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '希望職種',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Style.CustomColor.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (model[0].selfIntroDetails.occupation_name.length > 0)
                        for (int i = 0;
                            i <
                                model[0]
                                    .selfIntroDetails
                                    .occupation_name
                                    .length;
                            i++)
                          Text(
                            model[0].selfIntroDetails.occupation_name[i],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: CustomColor.txtColor,
                            ),
                          ),
                      if (model[0].selfIntroDetails.occupation_name.length ==
                              0 &&
                          (model[0]
                                      .selfIntroDetails
                                      .desired_occupation_status ==
                                  0 ||
                              model[0]
                                      .selfIntroDetails
                                      .desired_industry_status ==
                                  null))
                        Text(
                          '未入力',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black87,
                          ),
                        ),
                      if (model[0].selfIntroDetails.desired_occupation_status ==
                          1)
                        Text(
                          'こだわらない',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black87,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),

        //desired_location
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Style.CustomColor.grey,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "希望勤務地",
              style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 10),
          child: Row(
            children: [
              Container(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '第一希望',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Style.CustomColor.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                desiredLocaton(1),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: CustomColor.txtColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '第二希望',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Style.CustomColor.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                desiredLocaton(2),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: CustomColor.txtColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '第三希望',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Style.CustomColor.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                desiredLocaton(3),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: CustomColor.txtColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                      // Text(
                      //   desiredLocaton(1),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: const TextStyle(
                      //     fontSize: 15.0,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                      // Text(
                      //   desiredLocaton(2),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: const TextStyle(
                      //     fontSize: 15.0,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                      // Text(
                      //   desiredLocaton(3),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: const TextStyle(
                      //     fontSize: 15.0,
                      //     color: Colors.black87,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),

        //language
        Container(
          margin:
              const EdgeInsets.only(left: 15, top: 10, bottom: 20, right: 15),
          child: Row(
            children: [
              Container(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '語学レベル',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Style.CustomColor.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (langlist.length > 0)
                        for (int i = 0; i < langlist.length; i++)
                          Text(
                            langlist[i],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                            ),
                          ),
                      if (langlist.length == 0)
                        Text(
                          '未入力',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Style.CustomColor.titleColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        //self_pr
        Container(
          margin:
              const EdgeInsets.only(left: 15, top: 10, bottom: 0, right: 15),
          child: Row(
            children: [
              Container(
                child: Container(
                  // decoration: myBoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '自己PR、海外で勤務したい理由等',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Style.CustomColor.titleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(left: 15, bottom: 20, top: 10, right: 15),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: CustomColor.grey,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    // decoration: myBoxDecoration(),
                    child: Container(
                      child: Text(
                        selfPr(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}
