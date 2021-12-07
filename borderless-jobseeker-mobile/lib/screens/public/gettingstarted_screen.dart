import 'dart:async';
import 'package:borderlessWorking/Widget/slide_dots.dart';
import 'package:borderlessWorking/Widget/slide_item.dart';
import 'package:borderlessWorking/Widget/slide.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_screen.dart';
import 'package:borderlessWorking/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class GettingStartedScreen extends StatefulWidget {
  GettingStartedScreen({Key key}) : super(key: key);
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  AuthRepository authRepository = AuthRepository();
  _GettingStartedScreenState();
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 200), curve: Curves.easeIn);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  bool clicked = false;
  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _portraitMode();
        } else {
          return _landscapeMode();
        }
      },
    );
  }

  Widget _portraitMode() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) => SlideItem(i),
                  ),
                  Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ]),
                ],
              )),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LoginScreen(authRepository: authRepository))),
                    },
                    child: Text(
                      'ログイン',
                      style: Style.Customstyles.customText,
                    ),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(15),
                    color: Style.CustomColor.secondaryColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                    onPressed: () => {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => Formregister())),
                    },
                    child: Text(
                      '新規会員登録',
                      style: Style.Customstyles.colorText,
                    ),
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    color: Style.CustomColor.white,
                    textColor: Style.CustomColor.secondaryColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _landscapeMode() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) => SlideItem(i),
                  ),
                  Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ]),
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                      minWidth: 200.0,
                      child: RaisedButton(
                        onPressed: () =>
                            {Navigator.of(context).popAndPushNamed('/login')},
                        child: Text(
                          'ログイン',
                          style: Style.Customstyles.customText,
                        ),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(15),
                        color: Style.CustomColor.secondaryColor,
                        textColor: Colors.white,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ButtonTheme(
                      minWidth: 200.0,
                      child: RaisedButton(
                        onPressed: () => {
                          Navigator.of(context).popAndPushNamed('/register')
                        },
                        child: Text(
                          '新規会員登録',
                          style: Style.Customstyles.colorText,
                        ),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(15),
                        color: Style.CustomColor.white,
                        textColor: Style.CustomColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
