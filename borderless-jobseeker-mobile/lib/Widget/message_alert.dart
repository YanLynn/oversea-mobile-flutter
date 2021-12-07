import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class DialogContent {
  infoAlert(BuildContext context, iconType, msg, color) {
    Widget okButton = RaisedButton(
      child: Text(
        '閉じる',
        style: Style.Customstyles.customText,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(10),
      color: Colors.grey,
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: IconTheme(
              data: new IconThemeData(color: color, size: 35),
              child: iconType,
            ),
          ),
          content: new Text(
            "$msg",
            textAlign: TextAlign.center,
          ),
          actions: [Center(child: okButton)],
        );
      },
    );
  }
}

class AlertMessage {
  message(msg, color) {
    return Center(
        child: Container(
          // padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(top: 15.0),
          // decoration: BoxDecoration(
          //   border: Border.all(color: color),
          // ),
          child: Text('$msg',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                // shadows: <Shadow>[
                //   Shadow(
                //     offset: Offset(1.0, 1.0),
                //     blurRadius: 4.0,
                //     color: Colors.black38,
                //   ),
                //   Shadow(
                //     offset: Offset(1.0, 1.0),
                //     blurRadius: 4.0,
                //     color: Colors.black38,
                //   ),
                // ],
              )),
        ));
  }
}
