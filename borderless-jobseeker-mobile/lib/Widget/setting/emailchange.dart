import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/bloc/emailchange_bloc/bloc/emailchange_bloc.dart';
import 'package:borderlessWorking/data/repositories/emailchange_repositories.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Emailsetting extends StatefulWidget {
  const Emailsetting({Key key}) : super(key: key);

  @override
  _EmailsettingState createState() => _EmailsettingState();
}

class _EmailsettingState extends State<Emailsetting> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  Widget build(BuildContext context) {
    return BlocProvider<EmailchangeBloc>(
      create: (context) => EmailchangeBloc()..add(InitialState()),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            color: Color(0xFFDDDDDD),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      'メールアドレス変更',
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
          child: new Form(
            key: _formKey,
            autovalidate: _validate,
            child: updateform(),
          ),
        )
      ]),
    );
  }
}

class updateform extends StatefulWidget {
  const updateform({Key key}) : super(key: key);

  @override
  _updateformState createState() => _updateformState();
}

class _updateformState extends State<updateform> {
  final _formKey = GlobalKey<FormState>();
  final EmailchangeRepository _emailchangeRepository = EmailchangeRepository();
  // final EmailchangeBloc _bloc = EmailchangeBloc();
  TextEditingController _passController;
  TextEditingController _emailController;
  var username;
  var usermail;
  var postcodeErrorMessage;
  bool _obscureText = true;
  String passerror;
  String emailerror;
  String _error;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void clearText() {
    _passController.clear();
    _emailController.clear();
    this.emailerror = '';
  }

  void getuser() async {
    Map user = await _emailchangeRepository.getUserData();
    var name = user['name'];
    var email = user['email'];
    setState(() {
      username = name;
      usermail = email;
    });

    print("name $name email $email");
  }

  @override
  void initState() {
    super.initState();
    _passController = TextEditingController();
    _emailController = TextEditingController();
    getuser();
  }

  @override
  Widget build(BuildContext context) {
    _emailchange() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      BlocProvider.of<EmailchangeBloc>(context)
          .add(Checkpassword(_passController.text));
      // if ((passerror == null || passerror == '') &&
      //     (_emailController.text != null && _emailController.text != "")) {
      //   BlocProvider.of<EmailchangeBloc>(context).add(
      //     ChangeEmailButtonPressed(_emailController.text),
      //   );
      // }
    }

    return BlocConsumer<EmailchangeBloc, EmailchangeState>(
      listener: (context, state) {
        if (state is EmailChangedSuccess) {
          DialogContent().infoAlert(context, Icon(Icons.check_circle_outline),
              '入力されたメールアドレス宛に確認用のメールを送付しました。', Colors.greenAccent);
          setState(() {
            clearText();
          });
          print('emailchange success');
        } else if (state is EmailchangeFailure) {
          print('emailchange Fails');
          // _successalert(context);
          emailerror = '${state.error}';
          if (state.error == 'null') {
            // _error = "サーバとの通信に失敗しました";
            DialogContent().infoAlert(context, Icon(Icons.error_outline),
                "サーバとの通信に失敗しました", Colors.redAccent);
          } else {
            _error = '${state.error}';
          }
        }
        if (state is PasswordcheckFailure) {
          print('psw Fails');
          passerror = '${state.passworderror}';
        }
        if (state is PasswordcheckSuccess) {
          passerror = '';
          BlocProvider.of<EmailchangeBloc>(context).add(
            ChangeEmailButtonPressed(_emailController.text),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Column(children: [
                        Row(children: [
                          Text('求職者名'),
                          Container(
                              margin: const EdgeInsets.only(left: 61),
                              child: Text('$username')),
                        ]),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(children: [
                            Text('メールアドレス'),
                            Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text('$usermail')),
                          ]),
                        )
                      ])),
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
                        margin: const EdgeInsets.only(left: 10.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    controller: _passController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "パスワードは必須です";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _obscureText,
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
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  if (passerror == null)
                    Text(' ')
                  else
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          passerror,
                          style: TextStyle(color: Colors.red),
                        )),
                  SizedBox(height: 4),
                     Row(
                    children: [
                      Text(
                        "新しいメールアドレス",
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
                    controller: _emailController,
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
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'メールアドレス',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  if (emailerror == null)
                    Text(' ')
                  else if (emailerror == 'null')
                    Text(' ')
                  else
                    Container(
                        margin: const EdgeInsets.only(top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          emailerror,
                          style: TextStyle(color: Colors.red),
                        )),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 45,
                          child: state is EmailSettingLoading
                              ? Center(child: CupertinoActivityIndicator())
                              : RaisedButton(
                                  elevation: 5.0,
                                  color: Style.CustomColor.secondaryColor,
                                  disabledColor: Style.CustomColor.mainColor,
                                  disabledTextColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  onPressed: _emailchange,
                                  child: Text(
                                    "次へ",
                                    style: Style.Customstyles.customText,
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
//EmailsettingLoading
