import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/bloc/password_setting_bloc/password_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
// import 'package:fluttertoast/fluttertoast.dart';

class PasswordSetting extends StatefulWidget {
  @override
  _PasswordSettingState createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  final PasswordSettingBloc _bloc = PasswordSettingBloc();

  TextEditingController _cPwController;
  TextEditingController _pwController;
  TextEditingController _pwConfirmController;
  final formKey = GlobalKey<FormState>();
  String password_check;
  bool _visible1 = true;
  bool _visible2 = true;
  bool _visible3 = true;
  String _error;

  void initState() {
    _bloc.add(InitialState());
    super.initState();
    _cPwController = TextEditingController();
    _pwController = TextEditingController();
    _pwConfirmController = TextEditingController();
  }

  // void clearText() {
  //   _cPwController.clear();
  //   _pwController.clear();
  //   _pwConfirmController.clear();
  // }

  void _toggle1() {
    setState(() {
      _visible1 = !_visible1;
    });
  }

  void _toggle2() {
    setState(() {
      _visible2 = !_visible2;
    });
  }

  void _toggle3() {
    setState(() {
      _visible3 = !_visible3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordSettingBloc>(
        create: (_) => _bloc,
        child: BlocListener<PasswordSettingBloc, PasswordSettingState>(
            listener: (context, state) {
          if (state is PasswordChangedSuccess && state.msg != null) {
            DialogContent().infoAlert(context, Icon(Icons.check_circle_outline),
                state.msg, Colors.greenAccent);
            _error = null;
          }
          if (state is PasswordSettingFailure) {
            if (state.error == 'null') {
              // _error = "サーバとの通信に失敗しました";
              DialogContent().infoAlert(context, Icon(Icons.error_outline),
                  "サーバとの通信に失敗しました", Colors.redAccent);
            } else {
              _error = '${state.error}';
            }
          }
        }, child: BlocBuilder<PasswordSettingBloc, PasswordSettingState>(
                builder: (context, state) {
          return Container(
              child: Container(
            color: Color(0xFFDDDDDD),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xFFDDDDDD),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            'パスワード変更',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  // Container(
                  //   child: Row(children: [
                  //     Expanded(
                  //       child: Text(
                  //         ' パスワード変更',
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: const TextStyle(
                  //           fontSize: 18.0,
                  //           color: Colors.black87,
                  //         ),
                  //       ),
                  //     ),
                  //   ]),
                  // ),
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      child: state is PasswordSettingSuccess
                          ? _changePwForm(context, state)
                          : (state is PasswordChangedSuccess
                              ? _checkCurrentPwForm(context, state)
                              : _checkCurrentPwForm(context, state))),
                ],
              ),
            ),
          ));
        })));
  }

  Widget _checkCurrentPwForm(BuildContext context, state) {
    return new Center(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "現在のパスワードを入力してください",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(2.0),
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      margin: const EdgeInsets.only(left: 15.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  controller: _cPwController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _toggle3,
                      icon: _visible3
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      iconSize: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'パスワード',
                    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                    contentPadding: const EdgeInsets.all(15),
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
                  obscureText: _visible3,
                ),
                if (_error != null && _error != '')
                  Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _error,
                        style: TextStyle(color: Colors.red),
                      )),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        child: state is PasswordSettingLoading
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                                elevation: 5.0,
                                color: Style.CustomColor.secondaryColor,
                                disabledColor: Style.CustomColor.mainColor,
                                disabledTextColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                onPressed: () {
                                  if (!formKey.currentState.validate()) {
                                    return;
                                  }
                                  _error = null;
                                  BlocProvider.of<PasswordSettingBloc>(context)
                                      .add(
                                    CheckPasswordButtonPressed(
                                        _cPwController.text),
                                  );
                                },
                                child: Text(
                                  "次へ",
                                  style: Style.Customstyles.customText,
                                )),
                      ),
                    ],
                  ),
                ),
                // if (state is PasswordSettingFailure)
                //   DialogContent(msg: state.error, color: Colors.redAccent)
                // else if (state is PasswordChangedSuccess)
                //   DialogContent(msg: state.msg, color: Colors.greenAccent)
              ],
            )));
  }

  Widget _changePwForm(BuildContext context, state) {
    return new Center(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "新しいパスワードを入力してください",
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
                  controller: _pwController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _toggle1,
                      icon: _visible1
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
                    password_check = value;
                    if (value.isEmpty) {
                      return "パスワードは必須です";
                    } else if (value.length < 8) {
                      return "パスワードは8文字以上必要です";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: _visible1,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Text(
                      "もう一度パスワードを入力してください",
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
                  controller: _pwConfirmController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _toggle2,
                      icon: _visible2
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
                    if (value.isEmpty) {
                      return "パスワードが一致しません";
                    } else if (value != password_check) {
                      return "パスワードが一致しません";
                    } else {
                      return null;
                    }
                  },
                  autocorrect: false,
                  obscureText: _visible2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        child: state is PasswordSettingLoading
                            ? Center(child: CircularProgressIndicator())
                            : Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: SizedBox(
                                        height: 45,
                                        child: RaisedButton(
                                            elevation: 5.0,
                                            color: Colors.grey,
                                            disabledColor:
                                                Style.CustomColor.mainColor,
                                            disabledTextColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            onPressed: () {
                                              // clearText();
                                              _cPwController.clear();
                                              _pwController.clear();
                                              _pwConfirmController.clear();
                                              // _checkCurrentPwForm(context, state);
                                              // setState(() {
                                              //   state = PasswordChangedSuccess;
                                              // });
                                              BlocProvider.of<
                                                          PasswordSettingBloc>(
                                                      context)
                                                  .add(
                                                CancelChangePassword(),
                                              );
                                            },
                                            child: Text(
                                              "戻る",
                                              style: (TextStyle(
                                                  color: Colors.white)),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: SizedBox(
                                        height: 45,
                                        child: RaisedButton(
                                            elevation: 5.0,
                                            color:
                                                Style.CustomColor.secondaryColor,
                                            disabledColor:
                                                Style.CustomColor.mainColor,
                                            disabledTextColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            onPressed: () {
                                              if (!formKey.currentState
                                                  .validate()) {
                                                return;
                                              }
                                              // clearText();
                                              _cPwController.clear();
                                      
                                              BlocProvider.of<
                                                          PasswordSettingBloc>(
                                                      context)
                                                  .add(
                                                ChangePasswordButtonPressed(
                                                    _pwController.text),
                                              );
                                            },
                                            child: Text(
                                              "変更",
                                              style:
                                                  Style.Customstyles.customText,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
