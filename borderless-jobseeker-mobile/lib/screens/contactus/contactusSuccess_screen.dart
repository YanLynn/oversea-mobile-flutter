
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class ContactusSuccessScreen extends StatefulWidget {
  @override
  _ContactusSuccessScreenState createState() => _ContactusSuccessScreenState();
}

class _ContactusSuccessScreenState extends State<ContactusSuccessScreen> {
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
                    Text(
                      'お問い合わせありがとうございました。',
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
