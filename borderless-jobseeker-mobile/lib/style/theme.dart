import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/////////////////////for color //////////////
class CustomColor {
  const CustomColor();

  /// custom color
  static const Color bodyColor = Color(0xFFE4ECF3);

  static const Color mainColor = const Color(0xFF91AABE);
  //for appbar, bottomnavigationbar, appbar-title

  static const Color successGreen = const Color(0xFF49B15B);
  //for success and active online and chatting

  static const Color secondaryColor = const Color(0xFF0C3E65);
  //for loginbuttons, active icons,

  static const Color clearall = const Color(0xFFB4B6B8);
  //for clear-all button

  static const Color bordercolor = const Color(0xFF707070);
  //for border color

  static const Color chatbox = const Color(0xFFDFE9F2);
  //for chatbox color

  static const Color radio = const Color(0xFF6085A3);
  //for radio and checkbox color

  static const Color iconColor = const Color(0xFF5B5555);
  //for icon color

  static const Color txtColor = const Color(0xFF707070);
  //for txt color

  static const Color loginGradientStart = const Color(0xFF59499E);
  static const Color loginGradientEnd = const Color(0xFF59499E);
  static const Color thirdColor = const Color(0xFFFFD684);
  static const Color fourthColor = const Color(0xFF8FDCFF);
  static const Color elementBack = const Color(0xfff1efef);
  static const Color titleColor = const Color(0xFF0C3E65);
  static const Color subTitle = const Color(0xFFa4adbe);
  static const Color textMain = const Color(0xFF848484);
  static const Color greyBack = const Color(0xFFced4db);
  static const Color grey = const Color(0xFFECECEC);
  static const Color greylight = const Color(0xFFe5e5e5);
  static const Color greyForm = const Color(0xFFcaced4);
  static const Color white = const Color(0xFFFFFFFF);
  static const Color red = const Color(0xFFE74C3C);
  static const Color pink = const Color(0XFFCC7694);
  static const Color blue = const Color(0XFF0071b4);
  static const Color yellow = const Color(0xFFFBAA0A);

  static const Color orange = const Color(0xFFff6348);
  static const Color strongGrey = const Color(0xFFced4db);
  static const Color black = const Color(0xFF000000);
  static const Color secondBlack = const Color(0xFF515C6F);
  static const Color facebookBlue = const Color(0xFF1877f2);

  static const primaryGradient = const LinearGradient(
    colors: const [Color(0xFF5BC0FF), Color(0xFF0063FF)],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const cardGradient = const LinearGradient(
    colors: const [Color(0xFF1e3c72), Color(0xFF2a5298)],
    stops: const [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/////////////////////for style //////////////
class Customstyles {
  static TextStyle defaultTxt = TextStyle(color: CustomColor.black);
  static TextStyle defaultlbl = TextStyle(color: Colors.white);
  static TextStyle h1 = defaultTxt.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    height: 22 / 18,
  );
  static TextStyle lighth1 = defaultTxt.copyWith(
    fontSize: 18.0,
    height: 22 / 18,
  );
  static TextStyle whiteh1 = defaultlbl.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    height: 22 / 18,
  );
  static TextStyle h4 = TextStyle(
    color: CustomColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    height: 22 / 18,
  );
  static TextStyle p = defaultTxt.copyWith(
    fontSize: 14.0,
  );
  static TextStyle label = defaultlbl.copyWith(
    fontSize: 14.0,
  );
  static TextStyle error = defaultTxt.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.red,
  );
  static TextStyle customText =
      TextStyle(color: CustomColor.white, fontFamily: 'Meiryo', fontSize: 14);

  static TextStyle colorText = TextStyle(
      color: CustomColor.secondaryColor, fontFamily: 'Meiryo', fontSize: 14);

  static TextStyle customTitle = TextStyle(
      color: CustomColor.secondaryColor,
      fontFamily: 'Meiryo',
      fontWeight: FontWeight.bold,
      fontSize: 16);
  static InputDecoration input = InputDecoration(
    fillColor: Colors.white,
    focusColor: Colors.grey,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 5.0,
      ),
    ),
    border: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
  );

  //hnint to use job card (decoration: Style.Styles.cardBoxDecoration,)
  static BoxDecoration cardBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 3.0,
        offset: Offset(0, 1),
      ),
    ],
  );

  static BoxDecoration titleCardBoxDecoration = BoxDecoration(
    color: Color(0xFFe5e5e5),
    borderRadius: BorderRadius.circular(2.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 3.0,
      ),
    ],
  );
  static BoxDecoration privateBoxDecoration = BoxDecoration(
    color: Color(0xFFFBAA0A),
  );
  static BoxDecoration viewBoxDecoration = BoxDecoration(
    color: CustomColor.pink,
  );
  static BoxDecoration numberBoxDecoration = BoxDecoration(
    color: CustomColor.secondaryColor,
    borderRadius: BorderRadius.circular(5.0),
  );
  static BoxDecoration borderBoxDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: CustomColor.bordercolor,
      width: 1.0,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(5.0),
  );
  static BoxDecoration wrapperBoxDecoration = BoxDecoration(
    color: Color(0xFFe5e5e5),
    borderRadius: BorderRadius.circular(5.0),
    boxShadow: [
      BoxShadow(
        color: Colors.white,
        blurRadius: 0.0,
      ),
    ],
  );
}

class FormInput {
  static TextStyle textStyle = TextStyle(
      fontSize: 14.0,
      color: CustomColor.elementBack,
      fontWeight: FontWeight.bold);

  static InputDecoration emailTextInput = InputDecoration(
    prefixIcon: Icon(Icons.email_outlined, color: CustomColor.secondBlack),
    enabledBorder: OutlineInputBorder(
        borderSide: new BorderSide(color: CustomColor.iconColor),
        borderRadius: BorderRadius.circular(10.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: new BorderSide(color: CustomColor.elementBack),
        borderRadius: BorderRadius.circular(10.0)),
    contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
    labelText: "E-Mail",
    hintStyle: TextStyle(
        fontSize: 12.0, color: Color(0xffc1c1c1), fontWeight: FontWeight.w500),
    labelStyle: TextStyle(
        fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
  );

  static InputDecoration passwordTextInput = InputDecoration(
      // fillColor: Colors.background,
      prefixIcon: Icon(
        Icons.lock_clock_outlined,
        color: CustomColor.secondBlack,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: CustomColor.iconColor),
          borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: CustomColor.elementBack),
          borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
      labelText: "Password",
      hintStyle: TextStyle(
          fontSize: 12.0,
          color: Color(0xffc1c1c1),
          fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
          fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500));
}
