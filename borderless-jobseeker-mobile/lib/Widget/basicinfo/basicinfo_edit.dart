import 'package:borderlessWorking/bloc/basicinfo/basicinfo_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/basicinfo_lang.dart';
import 'package:borderlessWorking/data/model/getcity.dart';
import 'package:borderlessWorking/data/model/getcountry.dart';
import 'package:borderlessWorking/data/repositories/basicinfo_repositories.dart';
import 'package:borderlessWorking/data/repositories/getcountry_repositories.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Basicinfoedit extends StatefulWidget {
  // const Basicinfoedit({ Key? key }) : super(key: key);

  @override
  _BasicinfoeditState createState() => _BasicinfoeditState();
}

class _BasicinfoeditState extends State<Basicinfoedit> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Navigator.of(context).pop(context);
              // Navigator.of(context).popAndPushNamed('/profile');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new ExpansionTileCardDemo(saveSuccess: null)));
            },
          ),
          title: Text('基本情報', style: TextStyle(color: Colors.white)),
          backgroundColor: Style.CustomColor.mainColor,
          // title: Text("Carrer Edit"),
          // actions: [
          //   TextButton.icon(
          //     // onPressed: _onUpdateCarreerButtonPressed(),
          //     icon: Icon(Icons.save_rounded),
          //     label: Text('',
          //         style: TextStyle(color: Colors.white, fontSize: 12.0)),
          //   )
          // ],
        ),
        drawer: MyDrawer(Apis.profileImg, Apis.userName),
        backgroundColor: Colors.white,
        body: BlocProvider<BasicinfoBloc>(
          create: (context) => BasicinfoBloc()..add(InitialState()),
          child: Basicinfoeditform(),
        ));
    // Scaffold(
    //     appBar: AppBar(
    //       leading: IconButton(
    //         icon: Icon(Icons.close),
    //         onPressed: () {
    //           Navigator.of(context).popAndPushNamed('/profile');
    //         },
    //       ),
    //       // actions: <Widget>[
    //       //   IconButton(icon: Icon(Icons.save), onPressed: () {}),
    //       // ],
    //     ),
    //     backgroundColor: Colors.blueGrey,
    //     body: BlocProvider<BasicinfoBloc>(
    //       create: (context) => BasicinfoBloc()..add(InitialState()),
    //       child: new Form(
    //         key: _formKey,
    //         autovalidate: _validate,
    //         child: Basicinfoeditform(),
    //       ),
    //     ));
  }
}

class Basicinfoeditform extends StatefulWidget {
  // const Basicinfoeditform({ Key? key }) : super(key: key);

  @override
  _BasicinfoeditformState createState() => _BasicinfoeditformState();
}

class _BasicinfoeditformState extends State<Basicinfoeditform> {
  final _formKey = GlobalKey<FormState>();
  final Getjobseekerdetails _getjobseekerdetails = Getjobseekerdetails();
  final GetcountryRepository _getcountryRepository = GetcountryRepository();
  //controller
  final _jobseekernameController = TextEditingController();
  final _jobseekername = TextEditingController();
  final _jobseeker_furigana_nameController = TextEditingController();
  final _jobseeker_furigana_name_statusController = TextEditingController();
  final _gender_statusController = TextEditingController();
  final _dobController = TextEditingController();
  final _dob_statusController = TextEditingController();
  final _current_address_statusController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _skype_accountController = TextEditingController();
  final _final_educationController = TextEditingController();
  final _current_situationController = TextEditingController();
  final _city_nameController = TextEditingController();
  final _language_idController = TextEditingController();
  final _cnameController = TextEditingController();
  //controller
  bool privatestatus = false;
  bool genderstatus = false;
  bool dobstatus = false;
  bool currentaddressstatus = false;
  String _gender;
  String countryName;
  String education;
  String curpostion;
  String language_name;
  var isDisable = false;
  //String cityId;
  String cityName;
  List<Infolang> _langlist = List();
  List<Getcountry> _dataCountry = List();
  List<Getcity> _dataCity = List();
  var infocname;
  String tester = null;
  var finaleducation = [
    '最終学歴を選択',
    '大学（学士)',
    '短期大学',
    '大学院（修士）',
    '大学院（博士)',
    '専門学校',
    '高校',
    '高等専門学校',
    '中学校',
    'その他'
  ];
  var currentposition = [
    '現在の状況を選択',
    '会社員',
    '大学生/大学院生/専門学校',
    '語学留学生',
    '主婦',
    '経営者/自営業',
    '無職',
    '定年退職',
    'その他',
  ];
  //controller
  Future<void> getbasicinfo() async {
    final info = await _getjobseekerdetails.basicinfo();
    if (info.length > 1) {}
    _jobseekernameController.text = info[0].jobseeker_name;
    _jobseeker_furigana_nameController.text = info[0].jobseeker_furigana_name;
    var furigana_status = info[0].jobseeker_furigana_name_status;
    _jobseeker_furigana_name_statusController.text = furigana_status.toString();
    _gender = info[0].gender;
    _gender_statusController.text = info[0].gender_status.toString();
    var _dobstatus = info[0].dob_status;
    _dob_statusController.text = _dobstatus.toString();
    _dobController.text = info[0].dob;
    var current_address = info[0].current_address_status;
    _current_address_statusController.text = current_address.toString();
    _city_nameController.text = info[0].city_name;
    _language_idController.text = info[0].language_id;
    _addressController.text = info[0].address;
    _phoneController.text = info[0].phone;
    _emailController.text = info[0].email;
    _skype_accountController.text = info[0].skype_account;
    _final_educationController.text = info[0].final_education;
    _current_situationController.text = info[0].current_situation;
    countryName = info[0].country_name;
    _cnameController.text = info[0].country_name;
    privatestatus = info[0].jobseeker_furigana_name_status == 1 ? true : false;
    genderstatus = info[0].gender_status == 1 ? true : false;
    dobstatus = info[0].dob_status == 1 ? true : false;
    currentaddressstatus = info[0].current_address_status == 1 ? true : false;
    // radioItem = info[0].gender_status;
    education = info[0].final_education;
    curpostion = info[0].current_situation;

    print('object1 $education');
    print('object2 $curpostion');
    // language_name = info[0].language_id.toString();
    language_name = info[0].language_id;
    getcity(countryName, info[0].city_name);
    if (info[0].only_country == 1) {
      cityName = null;
    } else {
      cityName = info[0].city_name;
    }

    var test = info[0].country_name;
    setState(() {
      infocname = test;
    });

    // print(_jobseeker_furigana_name_statusController.text);
    // setState(() {
    //   _jobseekernameController.text = test;
    // });
  }

  //Getcountry_API
  void getcity(String idProvince, String cityname) async {
    final test = await _getcountryRepository.getcity(idProvince);
    setState(() {
      _dataCity = List();
      Getcity defCity = new Getcity(0, "", "都市を選択", "");
      _dataCity.add(defCity);
      test.forEach((data) {
        _dataCity.add(data);
        // if (cityname != null && data.city_name == cityname) {
        //   cityId = data.id.toString();
        //   _city_nameController.text = cityId;
        //   print('rrrr $cityId');
        // }
      });
    });
  }

  //Getcity_API
  void getcountry() async {
    final test = await _getcountryRepository.getcountry();
    setState(() {
      _dataCountry = List();
      Getcountry defCountry = new Getcountry(0, "", "国・地域を選択", "");
      _dataCountry.add(defCountry);
      test.forEach((data) {
        _dataCountry.add(data);
      });
    });
  }

  void langlist() async {
    final task = await _getjobseekerdetails.getlanglist();

    setState(() {
      _langlist = List();
      Infolang ttt = new Infolang(null, "母国語を選択");
      _langlist.add(ttt);
      task.forEach((data) {
        _langlist.add(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getbasicinfo();
    getcountry();
    langlist();
  }

  @override
  Widget build(BuildContext context) {
    _updatebuttonpressed() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      BlocProvider.of<BasicinfoBloc>(context).add(
        UpdateButtonPressed(
          jobseeker_name: _jobseekernameController.text,
          jobseeker_furigana_name: _jobseeker_furigana_nameController.text,
          jobseeker_furigana_name_status:
              _jobseeker_furigana_name_statusController.text,
          gender: _gender,
          gender_status: _gender_statusController.text,
          dob: _dobController.text,
          dob_status: _dob_statusController.text,
          current_address_status: _current_address_statusController.text,
          address: _addressController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          skype_account: _skype_accountController.text,
          final_education: education,
          current_situation: curpostion,
          city_name: cityName,
          // country_name: _cnameController.text,
          country_name: countryName,
          language_id: _language_idController.text,
        ),
      );
    }

    //form
    return BlocConsumer<BasicinfoBloc, BasicinfoState>(
      listener: (context, state) {
        if (state is UpdateSuccessful) {
          // Navigator.of(context).popAndPushNamed('/profile');
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new ExpansionTileCardDemo(saveSuccess: "保存しました。")));

          print('update success');
        } else if (state is UpdateFailure) {
          print('update Fails');
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("update Failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is UpdateLoading) {
          print('loading');
          return Center(child: CupertinoActivityIndicator());
        }
        return Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: [
                  //jobseekername
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Text(
                      '求職者氏名',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  Container(
                    height: 70,
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: '名前',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                      ),
                      controller: _jobseekernameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "求職者氏名は必須です";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 4),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'フリガナ',
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                            height: 28,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 5.0, left: 5),
                            // padding:
                            //     EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                            color: Style.CustomColor.yellow,
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Checkbox(
                                    checkColor:
                                        Colors.white, // color of tick Mark
                                    activeColor:
                                        Style.CustomColor.secondaryColor,
                                    value: privatestatus,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          privatestatus = true;
                                          _jobseeker_furigana_name_statusController
                                              .text = '1';
                                        } else {
                                          privatestatus = false;
                                          _jobseeker_furigana_name_statusController
                                              .text = '0';
                                        }
                                        print(
                                            _jobseeker_furigana_name_statusController
                                                .text);
                                      });
                                    },
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '非公開',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),

                  Container(
                    height: 70,
                    child: new TextFormField(
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: 'フリガナ',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _jobseeker_furigana_nameController,
                      onChanged: (value) {
                        setState(() {
                          _formKey.currentState.validate();
                        });
                      },
                      validator: (value) {
                        String patttern = r'(^[\u30a0-\u30ff ]*$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value.isEmpty) {
                          return "名前（フリガナ）は必須です";
                        } else if (!regExp.hasMatch(value)) {
                          return "全角カタカナで入力してください";
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 4),

                  Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '性別',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                              height: 28,
                              width: 100,
                              margin: EdgeInsets.only(bottom: 5.0, left: 5),
                              color: Style.CustomColor.yellow,
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Checkbox(
                                      checkColor:
                                          Colors.white, // color of tick Mark
                                      activeColor:
                                          Style.CustomColor.secondaryColor,
                                      value: genderstatus,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            genderstatus = true;
                                            _gender_statusController.text = '1';
                                          } else {
                                            genderstatus = false;
                                            _gender_statusController.text = '0';
                                          }
                                          print(_gender_statusController.text);
                                        });
                                      },
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '非公開',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      //genderstatus
                      //gender
                    ],
                  )),

                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      // flex: ,
                      child: ListTile(
                        title: Align(
                            child: new Text('男性'),
                            alignment: Alignment.topLeft),
                        leading: Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Style.CustomColor.mainColor),
                          value: '男性',
                          groupValue: _gender,
                          onChanged: (String value) {
                            setState(() {
                              _gender = value;
                              _gender_statusController.text = '0';
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      // flex: 1,
                      child: ListTile(
                        title: Align(
                            child: new Text('女性'),
                            alignment: Alignment.topLeft),
                        leading: Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Style.CustomColor.mainColor),
                          value: '女性',
                          groupValue: _gender,
                          onChanged: (String value) {
                            setState(() {
                              _gender = value;
                              _gender_statusController.text = '1';
                            });
                          },
                        ),
                      ),
                    ),
                  ]),

                  SizedBox(height: 4),
                  Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //dob
                          Text(
                            '生年月日',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 28,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 5.0, left: 5),
                            color: Style.CustomColor.yellow,
                            child: Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Checkbox(
                                    checkColor:
                                        Colors.white, // color of tick Mark
                                    activeColor:
                                        Style.CustomColor.secondaryColor,
                                    value: dobstatus,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == true) {
                                          dobstatus = true;
                                          _dob_statusController.text = '1';
                                        } else {
                                          dobstatus = false;
                                          _dob_statusController.text = '0';
                                        }
                                      });
                                    },
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '非公開',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      //dobstatus
                    ],
                  )),

                  Container(
                    height: 70,
                    child: new TextFormField(
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: '生年月日',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _dobController,
                    ),
                  ),

                  Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '現住所',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                              height: 28,
                              width: 100,
                              margin: EdgeInsets.only(bottom: 5.0, left: 5),
                              color: Style.CustomColor.yellow,
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Checkbox(
                                      checkColor:
                                          Colors.white, // color of tick Mark
                                      activeColor:
                                          Style.CustomColor.secondaryColor,
                                      value: currentaddressstatus,
                                      onChanged: (value) {
                                        setState(() {
                                          if (value == true) {
                                            currentaddressstatus = true;
                                            _current_address_statusController
                                                .text = '1';
                                          } else {
                                            currentaddressstatus = false;
                                            _current_address_statusController
                                                .text = '0';
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '非公開',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  )),

                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(5.0),
                      // color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(6.0),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.blueGrey)),
                                padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                margin: const EdgeInsets.only(right: 15.0),
                                width: 160,
                                height: 45,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("国・地域を選択"),
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
                                        if (cname == '国・地域を選択') {
                                          cname = null;
                                        }
                                        countryName = cname;
                                        // _cnameController.text = cname;
                                        print("countryname $cname");
                                        //cityId = null;
                                        cityName = null;
                                        // _city_nameController.text = null;
                                      });
                                      getcity(cname, null);
                                    },
                                  ),
                                ))),
                        Expanded(
                            child: Container(
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(6.0),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.blueGrey)),
                                padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                // margin: const EdgeInsets.only(right: 15.0),
                                width: 160,
                                height: 45,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("都市を選択"),
                                    //value: cityId,
                                    value: cityName,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                    items: _dataCity.map((city) {
                                      return DropdownMenuItem(
                                        value: city.city_name,
                                        //value: city.id.toString(),
                                        child: city.id != 0
                                            ? Text("  " + city.city_name)
                                            : Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    size: 35.0,
                                                  ),
                                                  Text("都市を選択"),
                                                ],
                                              ),
                                      );
                                    }).toList(),
                                    onChanged: (city) {
                                      setState(() {
                                        if (city == '都市を選択') {
                                          city = null;
                                        }
                                        // _city_nameController.text = city;
                                        //cityId = city;
                                        cityName = city;
                                      });
                                    },
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '※ 日本以外を選択した場合、都市は選択できません。',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  )),

                  //languages
                  SizedBox(height: 4),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Text(
                      '母国語',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(6.0),
                          color: Colors.white,
                          border: Border.all(color: Colors.blueGrey)),
                      padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                      // width: 300.0,
                      height: 45,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("母国語を選択"),
                          value: language_name,
                          // style: TextStyle(fontSize: 14, color: Colors.black54),
                          items: _langlist.map((lan) {
                            // return DropdownMenuItem(
                            //   child: Text(lan.language_name),
                            //   value: lan.id.toString(),
                            // );
                            return DropdownMenuItem(
                              value: lan.id.toString(),
                              child: lan.id != 0
                                  ? Text("  " + lan.language_name)
                                  : Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 35.0,
                                        ),
                                        Text("都市を選択"),
                                      ],
                                    ),
                            );
                          }).toList(),
                          onChanged: (lan) {
                            setState(() {
                              language_name = lan;
                              _language_idController.text = lan;
                              print("ddeee $lan");
                            });
                          },
                        ),
                      )),
                  SizedBox(height: 4),
                  Container(
                      child: Row(
                    children: [
                      Text(
                        '住所詳細 ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 10),
                          color: Style.CustomColor.pink,
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '運営管理者のみ閲覧可',
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )),
                    ],
                  )),

                  Container(
                    child: new TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: '住所詳細 ',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.white),
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                      ),
                      controller: _addressController,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            '電話番号  ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 5, left: 5),
                              color: Style.CustomColor.pink,
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                '運営管理者のみ閲覧可',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )),
                        ],
                      )),
                  Container(
                    height: 70,
                    child: new TextFormField(
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: '電話番号  ',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _phoneController,
                      //  onChanged: (value) {
                      //     setState(() {
                      //       _formKey.currentState.validate();
                      //     });
                      //   },
                      validator: (value) {
                        String patttern = r'(^[(0-9)+-]*$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value.isEmpty) {
                          return "電話番号は必須です";
                        } else if (!regExp.hasMatch(value)) {
                          return "半角数字+-スペースを使って入力してください";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  Container(
                      child: Row(
                    children: [
                      Text(
                        'メールアドレス   ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          color: Style.CustomColor.pink,
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '運営管理者のみ閲覧可',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )),
                    ],
                  )),

                  Container(
                    height: 70,
                    child: new TextFormField(
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
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
                          // borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _emailController,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(height: 4),
                  //skype
                  Container(
                      child: Row(
                    children: [
                      Text(
                        'スカイプ名',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 5, left: 5),
                          color: Style.CustomColor.pink,
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '運営管理者のみ閲覧可',
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          )),
                    ],
                  )),
                  Container(
                    height: 70,
                    child: new TextFormField(
                      // style: TextStyle(fontSize: 14, color: Colors.black54),
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // border: InputBorder.none,
                        hintText: 'スカイプ名',
                        hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)),
                        focusedBorder: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      controller: _skype_accountController,
                    ),
                  ),
                  //skype

                  //finaledutcation
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '最終学歴',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black, // red as border color
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("最終学歴を選択"),
                                  value: education,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  items: finaleducation.map((edu) {
                                    return DropdownMenuItem(
                                      child: Text(edu),
                                      value: edu,
                                    );
                                  }).toList(),
                                  onChanged: (edu) {
                                    setState(() {
                                      if (edu == '最終学歴を選択') {
                                        edu = null;
                                      }
                                      education = edu;
                                      // _final_educationController.text = edu;
                                      print("finaledu $edu");
                                    });
                                  },
                                ),
                              ))),
                    ],
                  ),
                  //finaledutcation
                  SizedBox(height: 4),
                  //curpos
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(bottom: 5, top: 10),
                    child: Text(
                      '現在の状況 ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(6.0),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black, // red as border color
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("現在の状況を選択"),
                                  value: curpostion,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  items: currentposition.map((curpos) {
                                    return DropdownMenuItem(
                                      child: Text(curpos),
                                      value: curpos,
                                    );
                                  }).toList(),
                                  onChanged: (curpos) {
                                    setState(() {
                                      if (curpos == '現在の状況を選択') {
                                        curpos = null;
                                      }
                                      curpostion = curpos;
                                      print("curpos $curpos");
                                    });
                                  },
                                ),
                              ))),
                    ],
                  ),
                  SizedBox(height: 20),

                  Padding(
                      padding: EdgeInsets.only(
                          top: 15.0, bottom: 10.0, left: 0, right: 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 45,
                              child: RaisedButton(
                                  elevation: 5.0,
                                  color: Style.CustomColor.secondaryColor,
                                  disabledColor: Style.CustomColor.mainColor,
                                  disabledTextColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  onPressed: _updatebuttonpressed,
                                  child: Text(
                                    "保存する",
                                    style: Style.Customstyles.customText,
                                  )),
                            )
                          ])),
                ]))));
      },
    );
  }
}
