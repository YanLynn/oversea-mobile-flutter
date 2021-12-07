import 'package:borderlessWorking/Widget/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Container(           
        child: Padding(
      padding:
          const EdgeInsets.only(right: 320),
      child: ClipRRect(
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(0),
        //     bottomRight: Radius.circular(15),
        //     topLeft: Radius.circular(15),
        //     topRight: Radius.circular(15)),
        child: Container(
           width: MediaQuery.of(context).size.width ,
          // color: Color(0xFFC2C6C7),
          child: Stack(
            children: <Widget>[
              SpinKitThreeBounce(
                color: Colors.blue,
                size: SizeConfig.safeBlockVertical * 0.3.h,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
