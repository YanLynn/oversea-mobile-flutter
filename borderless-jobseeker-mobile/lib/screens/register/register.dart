import 'package:borderlessWorking/bloc/register/bloc/register_bloc.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:borderlessWorking/data/repositories/register_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Formregister extends StatefulWidget {
  @override
  _FormregisterState createState() => _FormregisterState();
}

class _FormregisterState extends State<Formregister> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.CustomColor.mainColor,
        appBar: AppBar(
          backgroundColor: Style.CustomColor.mainColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc()..add(InitialState()),
          // child: Testing(),
          child: new Form(
            key: _formKey,
            autovalidate: _validate,
            child: Testing(),
          ),
        ));
  }
}

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final _formKey = GlobalKey<FormState>();
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  String password_check;
  final TextEditingController _confirmController = TextEditingController();
  final _jobseekernameController = TextEditingController();
  final _jobseekerfuriganaController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnameController = TextEditingController();
  final _cityController = TextEditingController();
  String countryName;
  String cityId;
  String postcodeErrorMessage;
  bool _obscureText = true;
  bool _obscureText1 = true;
  List<Getcountry> _dataCountry = List();
  List<Getcity> _dataCity = List();
  final RegisterRepository _registerRepository = RegisterRepository();

  mailcheck1(email) async {
    final error = await _registerRepository.mailcheck1(email);
    print(error);
    setState(() {
      postcodeErrorMessage = error;
    });
  }

  //Getcountry_API
  void getcity(String idProvince) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = List();
      Getcity defCity = new Getcity(0, "", "???????????????", "");
      _dataCity.add(defCity);
      test.forEach((data) {
        _dataCity.add(data);
      });
    });
    print("Data City : $test");
  }

  //Getcity_API
  void getcountry() async {
    final test = await _getcountryRepository.getcountry();
    setState(() {
      _dataCountry = List();
      Getcountry defCountry = new Getcountry(0, "", "?????????????????????", "");
      _dataCountry.add(defCountry);
      test.forEach((data) {
        _dataCountry.add(data);
      });
    });
    print("Data City : $test");
  }

  @override
  void initState() {
    super.initState();
    getcountry();
    _emailController.addListener(() {
      final mailInput = _emailController.value.text;
      if (mailInput.isNotEmpty) {
        mailcheck1(mailInput);
      }
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  Widget build(BuildContext context) {
    _onRegisterButtonPressed() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterButtonPressed(
          jobseeker_name: _jobseekernameController.text,
          jobseeker_furigana_name: _jobseekerfuriganaController.text,
          dob: _dobController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          password: _passwordController.text,
          country_name: _cnameController.text,
          country_id: _cityController.text,
        ),
      );
    }

    //form
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessful) {
          Navigator.of(context).pushNamed('/register-success-screen');
        } else if (state is RegisterFailure) {
          print('Fails');
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Register Failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          print('loading');
          return Center(child: CupertinoActivityIndicator());
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
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
                      "???????????????????????????",
                      style: Style.Customstyles.whiteh1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                //name
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '??????',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                Container(
                  height: 70,
                  child: new TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      hintText: '??????',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    controller: this._jobseekernameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '?????????????????????';
                      }
                    },
                  ),
                ),
                // SizedBox(height: 10),

                //furigana
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '??????(????????????)',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 70,
                  // padding: const EdgeInsets.all(3.0),
                  child: new TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '????????????',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // border: InputBorder.none,
                    ),
                    controller: _jobseekerfuriganaController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String patttern = r'(^[\u30a0-\u30ff ]*$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value.isEmpty) {
                        return "???????????????????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "?????????????????????????????????????????????";
                      }
                      return null;
                    },
                  ),
                ),

                // SizedBox(height: 10),

                //brithday
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ]),
                ),
                SizedBox(height: 4),
                Container(
                  height: 60,
                  // width: 60,
                  // padding: const EdgeInsets.all(3.0),
                  child: new TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // border: InputBorder.none,
                      hintText: '????????????',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    controller: _dobController,
                  ),
                ),

                // SizedBox(height: 10),

                //city
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                  ]),
                ),
                //dropdown
                Container(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(5.0),
                    // color: Colors.white,
                  ),
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // const Spacer(),
                        Expanded(
                            child: Container(
                                // width: 200,
                                padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                margin: const EdgeInsets.only(right: 15.0),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("?????????????????????"),
                                    value: countryName,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    items: _dataCountry.map((cname) {
                                      return DropdownMenuItem(
                                        child: Text(cname.country_name),
                                        value: cname.country_name,
                                      );
                                    }).toList(),
                                    onChanged: (cname) {
                                      setState(() {
                                        countryName = cname;
                                        _cnameController.text = cname;
                                        print("ddeee $cname");
                                        cityId = null;
                                        _cityController.text = null;
                                      });
                                      getcity(cname);
                                    },
                                  ),
                                ))),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                // width: 200,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("???????????????"),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    value: cityId,
                                    items: _dataCity.map((city) {
                                      return DropdownMenuItem(
                                        // child: Text(city.city_name),
                                        // value: city.id.toString(),
                                        value: city.id.toString(),
                                        child: city.id != 0
                                            ? Text("  " + city.city_name)
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    size: 35.0,
                                                  ),
                                                  Text("???????????????"),
                                                ],
                                              ),
                                      );
                                    }).toList(),
                                    onChanged: (city) {
                                      setState(() {
                                        _cityController.text = city;
                                        cityId = city;
                                      });
                                    },
                                  ),
                                ))),
                      ]),
                ),

                SizedBox(height: 30),
                //mobile
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            // padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                // SizedBox(height: 4),
                Container(
                  height: 80,
                  child: new TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '????????????',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    onChanged: (value) {
                      setState(() {
                        _formKey.currentState.validate();
                      });
                    },
                    validator: (value) {
                      String patttern = r'(^[(0-9)+-]*$)';
                      RegExp regExp = new RegExp(patttern);
                      if (value.length == 0) {
                        return "???????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "????????????+-????????????????????????????????????????????????";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),

                // SizedBox(height: 10),
                //email
                //mobile
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            // padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                // SizedBox(height: 4),
                Container(
                  height: 80,
                  child: new TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '?????????????????????',
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
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = new RegExp(pattern);
                      if (value.isEmpty) {
                        return "????????????????????????????????????";
                      } else if (!regExp.hasMatch(value)) {
                        return "?????????????????????????????????????????????????????????";
                      } else if (postcodeErrorMessage != null) {
                        return "????????????????????????????????????????????????????????????";
                      } else {
                        return null;
                      }
                    },
                    autocorrect: false,
                  ),
                ),
                // SizedBox(height: 10.0),

                //password
                //password
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '???????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),
                // SizedBox(height: 6),
                Container(
                  height: 80,
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: new BorderRadius.circular(5.0),
                  // ),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    decoration: new InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: _obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        iconSize: 16,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: '???????????????',
                      hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)),
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
                      password_check = value;
                      if (value.isEmpty) {
                        return "??????????????????????????????";
                      } else if (value.length < 8) {
                        return "??????????????????8????????????????????????";
                      } else {
                        return null;
                      }
                    },
                    obscureText: _obscureText,
                  ),
                ),
                //confirm_password
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    Column(children: [
                      Text(
                        '?????????????????????',
                        style: TextStyle(color: Colors.white),
                      )
                    ]),
                    Column(
                      children: [
                        Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(2.0),
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '??????',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ]),
                ),

                Container(
                  height: 80,
                  child: TextFormField(
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _toggle1,
                          icon: _obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          iconSize: 16,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '???????????????',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _confirmController,
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      obscureText: _obscureText1,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "????????????????????????????????????";
                        } else if (value != password_check) {
                          return "????????????????????????????????????";
                        } else {
                          return null;
                        }
                        ;
                      }),
                ),
                // SizedBox(height: 10),

                //password
                SizedBox(height: 6),
                // ignore: missing_required_param
                Container(
                  // margin: new EdgeInsets.symmetric(horizontal: 100.0),
                  child: RaisedButton(
                      child: Text(
                        '??????',
                        style: Style.Customstyles.customText,
                      ),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(15),
                      color: Style.CustomColor.secondaryColor,
                      textColor: Colors.white,
                      onPressed: _onRegisterButtonPressed),
                ),
                SizedBox(
                  height: 20,
                ),
              ])),
        );
      },
    );
    //form
  }
}
