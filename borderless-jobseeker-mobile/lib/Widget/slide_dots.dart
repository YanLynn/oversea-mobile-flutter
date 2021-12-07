import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Style.CustomColor.secondaryColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
