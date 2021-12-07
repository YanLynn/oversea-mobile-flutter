import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class ForgetPasswordSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.CustomColor.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            new Image.asset(
                              'assets/images/overseajob_logo.png',
                              height: 100,
                            ),
                        ],
                      )),
                      SizedBox(height: 50),

                      Container(
                        padding: const EdgeInsets.all(15.0),
                        // decoration: BoxDecoration(
                        //   border: Border.all( color: Colors.grey, ),
                        //   color: Style.CustomColor.bodyColor,
                        //   borderRadius: BorderRadius.circular(5.0),
                        // ),
                        child: Column(children: [
                          Center(
                            child: Text(
                              '会員パスワード再設定',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              'ご入力されたメールアドレス宛にメールを送信しましたので、ご確認ください。',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Style.CustomColor.secondaryColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 40.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/');
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Style.CustomColor.secondaryColor,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: new Text(
                                "トップページへ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],),
                      ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
