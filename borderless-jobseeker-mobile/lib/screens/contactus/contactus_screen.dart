
import 'package:borderlessWorking/bloc/contactUs_bloc/contactus_bloc.dart';
import 'package:borderlessWorking/screens/public/privacypolicy_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactusScreen extends StatefulWidget {
  @override
  _ContactusScreenState createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.CustomColor.mainColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // actions: [
        //     IconButton(
        //         icon: Icon(EvaIcons.logOutOutline),
        //         onPressed: () {
        //           BlocProvider.of<AuthenticationBloc>(context).add(
        //             LoggedOut(),
        //           );
        //         })
        //   ],
      ),
      body: BlocProvider<ContactusBloc>(
        create: (context) => ContactusBloc()..add(InitialState()),
        child: ContactusForm(),
      ),
    );
  }
}

class ContactusForm extends StatefulWidget {
  @override
  _ContactusFormState createState() => _ContactusFormState();
}

class _ContactusFormState extends State<ContactusForm> {
  final _formKey = GlobalKey<FormState>();
  String emailCheck;
  final _corporateNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _furiganaNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmEmailController = TextEditingController();
  final _inquiryDetailsController = TextEditingController();
  bool _policyCheck = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    _contactusButton() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      BlocProvider.of<ContactusBloc>(context).add(
        ContactusButtonPressed(
            corporateName: _corporateNameController.text,
            name: _nameController.text,
            furiganaName: _furiganaNameController.text,
            email: _emailController.text,
            confirmEmail: _confirmEmailController.text,
            inquiryDetails: _inquiryDetailsController.text,
            policy: _policyCheck),
      );
    }

    return BlocConsumer<ContactusBloc, ContactusState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ContactusSuccess) {
          Navigator.of(context).pushNamed('/contactus-success-screen');
        } else if (state is ContactusFail) {
          print('fails');
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Contact us form failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ContactusLoading) {
          print('loading');
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          color: Style.CustomColor.mainColor,
          width: double.infinity,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  // minHeight: viewportConstraints.maxHeight,
                  ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/overseajob_logo.png',
                      height: 100,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Center(
                        child: Text(
                          "お問い合わせフォーム",
                          style: Style.Customstyles.whiteh1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "企業団体名",
                      style: Style.Customstyles.label,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '入力してください',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: this._corporateNameController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "お名前",
                          style: Style.Customstyles.label,
                        ),
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '必要',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '入力してください',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'お名前は必須です';
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "お名前(フリガナ)",
                          style: Style.Customstyles.label,
                        ),
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '必要',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '全角カタカナで入力してください',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _furiganaNameController,
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      validator: (value) {
                        String patttern = r'(^[\u30a0-\u30ff ]*$)';
                        RegExp regExp = RegExp(patttern);
                        if (value.isEmpty) {
                          return "お名前(フリガナ) は必須です";
                        } else if (!regExp.hasMatch(value)) {
                          return "全角カタカナで入力してください";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "メールアドレス",
                          style: Style.Customstyles.label,
                        ),
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '必要',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      validator: (value) {
                        emailCheck = value;
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                        RegExp regExp = new RegExp(pattern);
                        if (value.isEmpty) {
                          return "メールアドレスは必須です";
                        } else if (!regExp.hasMatch(value)) {
                          return "メールアドレスの形式が正しくありません";
                        } else {
                          return null;
                        }
                      },
                      autocorrect: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "メールアドレス(確認)",
                          style: Style.Customstyles.label,
                        ),
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '必要',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'メールアドレス(確認)',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _confirmEmailController,
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'メールアドレス(確認)は必須です';
                        } else if (value != emailCheck) {
                          return 'メールアドレスが一致しません';
                        } else {
                          return null;
                        }
                      },
                      autocorrect: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "お問い合わせ内容詳細",
                      style: Style.Customstyles.label,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      // maxLength: 1000,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '入力してください',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _inquiryDetailsController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white, // color of tick Mark
                          activeColor: Style.CustomColor.secondaryColor,
                          value: _policyCheck,
                          onChanged: (value) {
                            setState(() {
                              _policyCheck = value;
                            });
                          },
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'プライバシーポリシー',
                                style: TextStyle(
                                  color: Style.CustomColor.white,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                PrivacyPolicyPage()));
                                  },
                              ),
                              TextSpan(
                                text: 'に同意',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // margin: new EdgeInsets.symmetric(horizontal: 100.0),
                      child: RaisedButton(
                        child: Text(
                          '確認',
                          style: Style.Customstyles.customText,
                        ),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(15),
                        color: Style.CustomColor.secondaryColor,
                        textColor: Colors.white,
                        onPressed: _policyCheck ? _contactusButton : null,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
