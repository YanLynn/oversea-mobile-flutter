import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Registersuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.CustomColor.bodyColor,
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
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/success.png',
                        height: 160,
                      ),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Text(
                        'この度は求職者会員としてご登録いただきありがとうございます',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Style.CustomColor.secondaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      '現在、仮登録の状態です。ご入力いただいたメールアドレス宛にご本人様確認用のメールをお送りいたしました。 メール本文内のURLをクリックすると、会員登録完了となります。',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Style.CustomColor.secondaryColor,
                        fontSize: 20,
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
