import 'package:borderlessWorking/Widget/slide.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Builder(builder: (context) {
            if (orientation.index == Orientation.landscape.index) {
              return Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(slideList[index].imageUrl))),
              );
            } else {
              return Container(
                width: 362,
                height: 272,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(slideList[index].imageUrl))),
              );
            }
          }),
        ),
      ],
    );
  }
}
