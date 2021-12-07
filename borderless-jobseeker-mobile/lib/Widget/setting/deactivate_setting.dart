import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/deactivate_bloc/deactivate_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

import '../message_alert.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class DeactivateSetting extends StatefulWidget {
  @override
  _DeactivateSetting createState() => _DeactivateSetting();
}

class _DeactivateSetting extends State<DeactivateSetting> {
  final DeactivateBloc _bloc = DeactivateBloc();
  AuthRepository authRepository = AuthRepository();

  TextEditingController _passwordController;
   bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
 void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  void clearText() {
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeactivateBloc, DeactivateState>(listener:
        (context, state) async {
      if (state is DeactivateFailure) {
        DialogContent().infoAlert(
            context, Icon(Icons.error_outline), state.error, Colors.redAccent);
      }
      if (state is DeactivateSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
        Apis.profileImg = null;
        Apis.userName = null;
        await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => PublicHomeScreen(authRepository: authRepository, checkAlert: '退会処理が完了しました。', selectedIndex: 0)), (route) => false);
      }
    }, child:
        BlocBuilder<DeactivateBloc, DeactivateState>(builder: (context, state) {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            color: Color(0xFFDDDDDD),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      '退会',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ]))),
        Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            child: _deactivateForm(context, state)),
      ]);
    }));
  }

  Widget _deactivateForm(BuildContext context, state) {
    return new Center(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "パスワードを入力してください",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(2.0),
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      margin: const EdgeInsets.only(left: 10.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  controller: _passwordController,                 
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: _obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        iconSize: 16,
                      ),                    
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'パスワード',
                    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (value) {
                    Pattern pattern = r'.{8,}';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                      return "パスワードは必須です";
                    } else if (!regex.hasMatch(value)) {
                      return 'パスワードは8文字以上必要です';
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                   obscureText: _obscureText,
                  // obscureText: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        child: state is DeactivateLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 25.0,
                                        width: 25.0,
                                        child: CupertinoActivityIndicator(),
                                      )
                                    ],
                                  ))
                                ],
                              )
                            : RaisedButton(
                                elevation: 5.0,
                                color: Style.CustomColor.secondaryColor,
                                disabledColor: Style.CustomColor.mainColor,
                                disabledTextColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    showAlertDialog(context);
                                  }
                                },
                                child: Text(
                                  "次へ",
                                  style: Style.Customstyles.customText,
                                )),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  showAlertDialog(BuildContext context) {
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
        if (!formKey.currentState.validate()) {
          return;
        }
        Apis.socket.emit("logout-user", "logout");
        BlocProvider.of<DeactivateBloc>(context)
            .add(DeactivateButtonPressed(password: _passwordController.text));
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
            "本当に退会しますか。",
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
}
