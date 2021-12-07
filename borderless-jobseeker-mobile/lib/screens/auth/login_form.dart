import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/Widget/sizeConfig.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/login_bloc/login_bloc.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:sizer/sizer.dart';
import 'package:borderlessWorking/data/api/apis.dart';

class LoginForm extends StatefulWidget {
  final AuthRepository authRepository;
  LoginForm({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(authRepository);
}

class _LoginFormState extends State<LoginForm> {
  final AuthRepository authRepository;
  _LoginFormState(this.authRepository);
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // _onLoginButtonPressed() {
  //   if (!_formKey.currentState.validate()) {
  //     return;
  //   }
  //   BlocProvider.of<LoginBloc>(context).add(
  //     LoginButtonPressed(
  //       email: _usernameController.text,
  //       password: _passwordController.text,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Style.CustomColor.mainColor,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationAuthenticated) {
            if (Apis.loginPageType == 'home') {
              Navigator.of(context).pushNamed('/');
            } else if (Apis.loginPageType == 'scout') {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PublicHomeScreen(
                            authRepository: authRepository,
                            checkAlert: '',
                            selectedIndex: 4,
                            
                          )));
            } else if (Apis.loginPageType == 'apply') {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PublicHomeScreen(
                            authRepository: authRepository,
                            checkAlert: '',
                            selectedIndex: 3,
                            
                          )));
            } else if (Apis.loginPageType == 'fav') {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PublicHomeScreen(
                            authRepository: authRepository,
                            checkAlert: '',
                            selectedIndex: 2,
                            
                          )));
            }
          }
        },

        // MultiBlocListener(
        // listeners: [
        //   BlocListener<LoginBloc, LoginState>(
        //     listener: (context, state) {
        //       if (state is LoginFailure) {
        //         // DialogContent().infoAlert(context, Icon(Icons.error_outline),
        //         //     state.error, Colors.redAccent);
        //       }
        //     },
        //   ),
        //   BlocListener<AuthenticationBloc, AuthenticationState>(
        //     listener: (context, state) {
        //       if (state is AuthenticationAuthenticated) {
        //         Navigator.of(context).pushNamed('/');
        //       }
        //     },
        //   ),
        // ],
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authRepository: authRepository,
          ),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Container(
                  color: Style.CustomColor.mainColor,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (Apis.loginPageType == 'home')
                                      new Image.asset(
                                        'assets/images/overseajob_logo.png',
                                        // width: SizeConfig.safeBlockHorizontal * 8.5.w,
                                        // height: SizeConfig.safeBlockVertical * 2.h,
                                        height: 100,
                                      ),
                                  ],
                                )),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 1.2.h,
                            ),
                            Align(
                              child: Center(
                                child: Text(
                                  "求職者会員ログイン",
                                  style: Style.Customstyles.whiteh1,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 0.3.h,
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
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                // border: InputBorder.none,
                                hintText: 'メールアドレス',
                                hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              controller: _usernameController,
                              onChanged: (value) {
                                setState(() {
                                  _formKey.currentState.validate();
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "メールアドレスが入力されていません";
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'メールアドレスの形式が正しくありません';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 0.3.h,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Column(children: [
                                  Text(
                                    'パスワード',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                              ]),
                            ),
                            // Container(
                            //     padding: EdgeInsets.only(bottom: 10, right: 255),
                            //     child: Text(
                            //       "パスワード",
                            //       style: TextStyle(
                            //           color: Style.CustomColor.titleColor,
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: SizeConfig.safeBlockHorizontal * 2.sp),
                            //     )),
                            TextFormField(
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                              decoration: new InputDecoration(
                                hintText: 'パスワード',
                                hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                                suffixIcon: IconButton(
                                  onPressed: _toggle,
                                  icon: _obscureText
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  iconSize: 16,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightBlue)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              controller: _passwordController,
                              onChanged: (value) {
                                setState(() {
                                  _formKey.currentState.validate();
                                });
                              },
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
                              obscureText: _obscureText,
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 0.5.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: new InkWell(
                                child: new Text(
                                  "パスワードをお忘れですか︖",
                                  style: TextStyle(
                                    color: Style.CustomColor.titleColor,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/forget-password');
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 45,
                                    child: state is LoginLoading
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .safeBlockHorizontal *
                                                        0.5.h,
                                                    width: SizeConfig
                                                            .safeBlockVertical *
                                                        0.5.h,
                                                    child:
                                                        CupertinoActivityIndicator(),
                                                  )
                                                ],
                                              ))
                                            ],
                                          )
                                        : Container(
                                            child: RaisedButton(
                                                elevation: 5.0,
                                                color: Style
                                                    .CustomColor.secondaryColor,
                                                disabledColor:
                                                    Style.CustomColor.mainColor,
                                                disabledTextColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                // onPressed: _onLoginButtonPressed,
                                                onPressed: () {
                                                  if (!_formKey.currentState
                                                      .validate()) {
                                                    return;
                                                  }
                                                  BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .add(
                                                    LoginButtonPressed(
                                                      email: _usernameController
                                                          .text,
                                                      password:
                                                          _passwordController
                                                              .text,
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "ログイン",
                                                  style: Style
                                                      .Customstyles.customText,
                                                )),
                                          ),
                                  ),
                                  SizedBox(
                                    height:
                                        SizeConfig.safeBlockVertical * 0.2.h,
                                  ),
                                  if (state is LoginFailure)
                                    AlertMessage()
                                        .message(state.error, Colors.red),
                                  SizedBox(
                                    height: SizeConfig.safeBlockVertical * 2.h,
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          bottom: 0.0, top: 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   "Don't have an account?",
                                          //   style: TextStyle(
                                          //     color: Colors.black45,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontSize:
                                          //         SizeConfig.safeBlockHorizontal * 2.sp,
                                          //   ),
                                          // ),
                                          // Padding(
                                          //   padding: EdgeInsets.only(right: 5.0),
                                          // ),
                                          GestureDetector(
                                              onTap: () {                                                
                                                        Navigator.of(context)
                                      .pushNamed('/register');
                                              },
                                              child: Text(
                                                "新規登録はこちら",
                                                style: TextStyle(
                                                  color: Style
                                                      .CustomColor.titleColor,
                                                ),
                                              ))
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
