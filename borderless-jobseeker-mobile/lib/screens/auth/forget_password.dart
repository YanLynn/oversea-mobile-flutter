
import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Style.CustomColor.mainColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Style.CustomColor.mainColor,
        body: BlocProvider(
          create: (context) => ForgetPasswordBloc(),
          child: ForgetPassword(),
        ));
  }
}

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _emailController;
  String _error;

  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  _onButtonPressed() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    BlocProvider.of<ForgetPasswordBloc>(context).add(
      ForgetButtonPressed(
        email: _emailController.text,
      ),
    );
  }

  void clearText() {
    _emailController.clear();
  }

  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordFailure) {
          _error = state.error;
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("${state.error}"),
          // ));
        }
        if (state is ForgetPasswordSuccess) {
          Navigator.of(context).pushNamed('/forget-pass-success-screen');
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("${state.success}"),
          // ));          
        }
      },
      child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: SingleChildScrollView(
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        //height: 130.0,
                        // padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Image.asset(
                          'assets/images/overseajob_logo.png',
                          height: 100,
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Center(
                        child: Text(
                          "求職者会員パスワード再設定",
                          style: Style.Customstyles.whiteh1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Column(children: [
                          Text(
                            'メールアドレス',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                      ]),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: 'メールアドレス',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _emailController,
                      autocorrect: false,
                      validator: (value) => EmailValidator.validate(value)
                          ? null
                          : "メールアドレスの形式が正しくありません",
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 45,
                            child: state is ForgetPasswordInitial
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        borderRadius: BorderRadius.circular(5)),
                                    onPressed: _onButtonPressed,
                                    child: Text(
                                      "送信",
                                      style: Style.Customstyles.customText,
                                    )),
                          ),
                          // Container(
                          //     padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         new GestureDetector(
                          //           onTap: () {
                          //             // Get.back();
                          //           },
                          //           child: new Text(
                          //             "Go Back",
                          //             style: TextStyle(
                          //                 color: Style.CustomColor.titleColor,
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 12.0),
                          //           ),
                          //         )
                          //       ],
                          //     )),
                          if(_error!= null) 
                          AlertMessage().message(_error, Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
