import 'package:borderlessWorking/bloc/carrer_bloc/carrer_bloc.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/model/career-update.dart';
import 'package:borderlessWorking/data/model/carrer_details.dart';
import 'package:borderlessWorking/data/model/employment_type.dart';
import 'package:borderlessWorking/data/model/position.dart';
import 'package:borderlessWorking/data/repositories/carrer_repositories.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:borderlessWorking/screens/home/home_screen.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class CarrerEdit extends StatefulWidget {
  @override
  _CarrerEditState createState() => _CarrerEditState();
}

class _CarrerEditState extends State<CarrerEdit> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

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
          title: Text('経歴', style: TextStyle(color: Colors.white)),
          backgroundColor: Style.CustomColor.mainColor,
          // title: Text("Carrer Edit"),
        ),
        drawer: MyDrawer(Apis.profileImg, Apis.userName),
        backgroundColor: Colors.white,
        body: BlocProvider<CarrerBloc>(
          create: (context) => CarrerBloc()..add(InitialState()),
          // child: Testing(),
          child: EditPage(),
          // new Form(
          //   key: _formKey,
          //   autovalidate: _validate,
          //   child: Testing(),
          // ),
        ));
  }
}

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _carrerRepository = new CarrerRepository();
  final _formKey = GlobalKey<FormState>();

  var education_status = ['ステータスを選択', '卒業', '卒業予定', '中退'];
  var finaleducation = [
    '学位を選択',
    '大学（学士)',
    '短期大学',
    '大学院（修士）',
    '大学院（博士',
    '専門学校',
    '高校',
    '高等専門学校',
    '中学校',
    'その他'
  ];

  var yearArr = ['年'];
  var monthArr = [
    '月',
    '1 月',
    '2 月',
    '3 月',
    '4 月',
    '5 月',
    '6 月',
    '7 月',
    '8 月',
    '9 月',
    '10 月',
    '11 月',
    '12 月'
  ];

  var to_year = [
    {
      'isDisable': true,
    }
  ];

  var to_month = [
    {
      'isDisable': true,
    }
  ];

  var educations = [
    {
      'id': 0,
      'school_name': "",
      'subject': "",
      'degree': '学位を選択',
      'from_year': '年',
      'from_month': '月',
      'to_year': '年',
      'to_month': '月',
      'education_status': 'ステータスを選択'
    }
  ];

  var experiences = [
    {
      'id': 0,
      'private_status': 0,
      'job_location': "",
      'current': 0,
      'from_year': '年',
      'from_month': '月',
      'to_year': '年',
      'to_month': '月',
      'position_id': 0,
      'employment_type_id': 0,
      'main_duty': ""
    }
  ];

  var carrers = {
    'num_of_experienced_companies': "",
    'last_annual_income': "",
    'last_currency': '通貨単位を選択',
  };

  var from_year_error = [
    {
      'error': '',
    }
  ];

  var from_month_error = [
    {
      'error': '',
    }
  ];

  List<TextEditingController> _subjectController = [];
  List<TextEditingController> _schoolnameController = [];
  List<TextEditingController> _joblocationController = [];
  List<TextEditingController> _maindutyController = [];
  final _numofexpcompanies = new TextEditingController();
  final _finalannualIncome = new TextEditingController();
  List<bool> _privateStatusOne = [];
  List<bool> _privateStatusTwo = [];
  List<bool> _current = [];
  var isDisable = false;

  void changeValue(int i) {
    if (_current[i] == true) {
      if (this.experiences[i]['from_year'] != '年') {
        this.from_year_error[i]['error'] = '';
      } else {
        this.from_year_error[i]['error'] = 'error';
      }
      if (this.experiences[i]['from_month'] != '月') {
        this.from_month_error[i]['error'] = '';
      } else {
        this.from_month_error[i]['error'] = 'error';
      }
      this.to_year[i]['isDisable'] = true;
      this.to_month[i]['isDisable'] = true;
    } else {
      if (this.experiences[i]['from_year'] == '年' &&
          this.experiences[i]['from_month'] == '月') {
        this.to_year[i]['isDisable'] = true;
        this.to_month[i]['isDisable'] = true;
      } else if (this.experiences[i]['from_year'] != '年' ||
          this.experiences[i]['from_month'] != '月') {
        this.to_year[i]['isDisable'] = false;
        this.to_month[i]['isDisable'] = false;
      }
      this.from_year_error[i]['error'] = '';
      this.from_month_error[i]['error'] = '';
    }
  }

  void isDisableOrNot(int i) {
    if (_current[i] == false) {
      if (this.experiences[i]['from_year'] == '年' &&
          this.experiences[i]['from_month'] == '月') {
        this.to_year[i]['isDisable'] = true;
        this.to_month[i]['isDisable'] = true;
      } else if (this.experiences[i]['from_year'] != '年' ||
          this.experiences[i]['from_month'] != '月') {
        this.to_year[i]['isDisable'] = false;
        this.to_month[i]['isDisable'] = false;
      }
      this.from_year_error[i]['error'] = '';
      this.from_month_error[i]['error'] = '';
    } else if (_current[i] == true) {
      this.experiences[i]['to_year'] = '年';
      this.experiences[i]['to_month'] = '月';
      this.to_year[i]['isDisable'] = true;
      this.to_month[i]['isDisable'] = true;
      if (this.experiences[i]['from_year'] == '年') {
        this.from_year_error[i]['error'] = 'error';
      }
      if (this.experiences[i]['from_month'] == '月') {
        this.from_month_error[i]['error'] = 'error';
      }
    }
  }

  List<Position> _positions = List();
  List<EmploymentType> _employment_types = List();
  List<String> _isolist = List();
  List<CareerModel> _positions_requireList = List();

  void getCarrerRequiredList() async {
    final data = await _carrerRepository.getCarrerRequiredList();

    setState(() {
      _positions = List();
      Position pos = new Position(0, "ポジションを選択");
      _positions.add(pos);
      data[0].positions.forEach((data) {
        _positions.add(data);
      });

      _employment_types = List();
      EmploymentType emp = new EmploymentType(0, "雇用形態を選択");
      _employment_types.add(emp);
      data[0].employment_types.forEach((data) {
        _employment_types.add(data);
      });

      _isolist = List();
      _isolist.add('通貨単位を選択');
      data[0].iso_list.forEach((data) {
        _isolist.add(data);
      });
    });
  }

  void getCarrerDetails() async {
    List data = await _carrerRepository.getCarrerList();
    if (data[0].educations.length != 0) {
      this.educations.removeAt(0);
      this._schoolnameController.removeAt(0);
      this._subjectController.removeAt(0);
    }
    var year, month;
    setState(() {
      data[0].educations.toList().asMap().forEach((index, element) {
        if (element['degree'] == null) {
          element['degree'] = "学位を選択";
        }
        if (element['from_year'] == null) {
          element['from_year'] = '年';
        } else {
          year = 1920 + element['from_year'];
          element['from_year'] = year.toString() + ' 年';
        }
        if (element['from_month'] == null) {
          element['from_month'] = "月";
        } else {
          month = 12 + element['from_month'];
          element['from_month'] = month.toString() + ' 月';
        }
        if (element['to_year'] == null) {
          element['to_year'] = '年';
        } else {
          year = 1920 + element['to_year'];
          element['to_year'] = year.toString() + ' 年';
        }
        if (element['to_month'] == null) {
          element['to_month'] = "月";
        } else {
          month = 12 + element['to_month'];
          element['to_month'] = month.toString() + ' 月';
        }
        if (element['education_status'] == null) {
          element['education_status'] = "ステータスを選択";
        }

        this._schoolnameController.add(TextEditingController());
        this._schoolnameController[index].text = element['school_name'];
        this._subjectController.add(TextEditingController());
        this._subjectController[index].text = element['subject'];

        this.educations.add({
          'id': element['id'],
          'school_name': element['school_name'],
          'subject': element['subject'],
          'degree': element['degree'],
          'from_year': element['from_year'],
          'from_month': element['from_month'],
          'to_year': element['to_year'],
          'to_month': element['to_month'],
          'education_status': element['education_status']
        });
      });

      if (data[0].experiences.length != 0) {
        this.experiences.removeAt(0);
        this._maindutyController.removeAt(0);
        this._joblocationController.removeAt(0);
        this._privateStatusOne.removeAt(0);
        this._privateStatusTwo.removeAt(0);
        this._current.removeAt(0);
        this.from_year_error.removeAt(0);
        this.from_month_error.removeAt(0);
        this.to_month.removeAt(0);
        this.to_year.removeAt(0);
      }

      data[0].experiences.toList().asMap().forEach((index, element) {
        if (element['from_year'] == null) {
          element['from_year'] = '年';
        } else {
          year = 1920 + element['from_year'];
          element['from_year'] = year.toString() + ' 年';
        }
        if (element['from_month'] == null) {
          element['from_month'] = "月";
        } else {
          month = 12 + element['from_month'];
          element['from_month'] = month.toString() + ' 月';
        }
        if (element['to_year'] == null) {
          element['to_year'] = '年';
        } else {
          year = 1920 + element['to_year'];
          element['to_year'] = year.toString() + ' 年';
        }
        if (element['to_month'] == null) {
          element['to_month'] = "月";
        } else {
          month = 12 + element['to_month'];
          element['to_month'] = month.toString() + ' 月';
        }
        if (element['current'] == 1) {
          _current.add(true);
        } else {
          _current.add(false);
        }
        if (element['private_status'] == 1) {
          _privateStatusOne.add(true);
          _privateStatusTwo.add(false);
        } else if (element['private_status'] == 2) {
          _privateStatusTwo.add(true);
          _privateStatusOne.add(false);
        } else {
          _privateStatusOne.add(false);
          _privateStatusTwo.add(false);
        }
        this.from_month_error.add({'error': ''});
        this.from_year_error.add({'error': ''});

        this.to_year.add({
          'isDisable': true,
        });
        this.to_month.add({
          'isDisable': true,
        });

        this._maindutyController.add(TextEditingController());
        this._maindutyController[index].text = element['main_duty'];
        this._joblocationController.add(TextEditingController());
        this._joblocationController[index].text = element['job_location'];

        this.experiences.add({
          'id': element['id'],
          'private_status': element['private_status'],
          'job_location': element['job_location'],
          'current': element['current'],
          'from_year': element['from_year'],
          'from_month': element['from_month'],
          'to_year': element['to_year'],
          'to_month': element['to_month'],
          'position_id': element['position_id'],
          'employment_type_id': element['employment_type_id'],
          'main_duty': element['main_duty']
        });
        isDisableOrNot(index);
        this._numofexpcompanies.text =
            (data[0].carrers['num_of_experienced_companies']).toString();
        this._finalannualIncome.text = data[0].carrers['last_annual_income'];

        this.carrers['num_of_experienced_companies'] =
            data[0].carrers['num_of_experienced_companies'].toString();
        this.carrers['last_annual_income'] =
            data[0].carrers['last_annual_income'];
        if (data[0].carrers['last_currency'] == null) {
          this.carrers['last_currency'] = '通貨単位を選択';
        } else {
          this.carrers['last_currency'] = data[0].carrers['last_currency'];
        }
      });
    });
  }

  List<CarrerDetail> _carrers = List();
  void getCarrerList() async {
    final data = await _carrerRepository.getCarrerList();
    setState(() {
      _carrers = List();

      data.forEach((data) {
        _carrers.add(data);
      });
    });
    print("Position : $data");
  }

  void inIt() async {
    _schoolnameController.add(TextEditingController());
    _subjectController.add(TextEditingController());

    _joblocationController.add(TextEditingController());
    _maindutyController.add(TextEditingController());
    _privateStatusOne.add(false);
    _privateStatusTwo.add(false);
    _current.add(false);

    DateTime today = DateTime.now();
    var year = (today.year - 1919);
    for (int i = 1; i <= year; i++) {
      yearArr.add((1920 + i).toString() + ' 年');
    }
  }

  @override
  void initState() {
    super.initState();
    inIt();
    getCarrerRequiredList();
    getCarrerDetails();
  }

  Widget build(BuildContext context) {
    _addEducation() {
      setState(() {
        _schoolnameController.add(TextEditingController());
        _subjectController.add(TextEditingController());

        this.educations.add({
          'id': 0,
          'school_name': "",
          'subject': "",
          'degree': '学位を選択',
          'from_year': '年',
          'from_month': '月',
          'to_year': '年',
          'to_month': '月',
          'education_status': 'ステータスを選択'
        });
      });
    }

    void _removeEducation(int i) {
      setState(() {
        if (this.educations.length > 1) {
          this._schoolnameController.removeAt(i);
          this._subjectController.removeAt(i);
          this.educations.removeAt(i);
        }
      });
    }

    _addExperience() {
      setState(() {
        _joblocationController.add(TextEditingController());
        _maindutyController.add(TextEditingController());
        _privateStatusOne.add(false);
        _privateStatusTwo.add(false);
        _current.add(false);

        this.to_year.add({
          'isDisable': true,
        });
        this.to_month.add({
          'isDisable': true,
        });

        this.from_year_error.add({
          'error': '',
        });

        this.from_month_error.add({
          'error': '',
        });

        this.experiences.add({
          'id': 0,
          'private_status': 0,
          'job_location': "",
          'current': 0,
          'from_year': '年',
          'from_month': '月',
          'to_year': '年',
          'to_month': '月',
          'position_id': 0,
          'employment_type_id': 0,
          'main_duty': ""
        });
      });
    }

    void _removeExperience(int i) {
      setState(() {
        if (this.experiences.length > 1) {
          this._joblocationController.removeAt(i);
          this._maindutyController.removeAt(i);
          this._privateStatusOne.removeAt(i);
          this._privateStatusTwo.removeAt(i);
          this._current.removeAt(i);
          this.to_year.removeAt(i);
          this.to_month.removeAt(i);
          this.from_year_error.removeAt(i);
          this.from_month_error.removeAt(i);
          this.experiences.removeAt(i);
        }
      });
    }

    _onUpdateCarreerButtonPressed() {
      for (var i = this.experiences.length - 1; i >= 0; i--) {
        if (from_year_error[i]['error'] != '' ||
            from_month_error[i]['error'] != '') {
          return;
        }
        this.experiences[i]['job_location'] = _joblocationController[i].text;
        this.experiences[i]['main_duty'] = _maindutyController[i].text;

        if (this.experiences.length != 1) {
          if ((this.experiences[i]['job_location'] == null ||
                  this.experiences[i]['job_location'] == '') &&
              this.experiences[i]['from_year'] == '年' &&
              this.experiences[i]['from_month'] == '月' &&
              this.experiences[i]['to_year'] == '年' &&
              this.experiences[i]['to_month'] == '月' &&
              this.experiences[i]['position_id'] == 0 &&
              this.experiences[i]['employment_type_id'] == 0 &&
              (this.experiences[i]['main_duty'] == null ||
                  this.experiences[i]['main_duty'] == '' &&
                      this.experiences[i]['private_status'] == 0) &&
              (this.experiences[i]['current'] == false ||
                  this.experiences[i]['current'] == 0) &&
              this.from_year_error[i]['error'] == '' &&
              this.from_month_error[i]['error'] == '') {
            this._joblocationController.removeAt(i);
            this._maindutyController.removeAt(i);
            this._privateStatusOne.removeAt(i);
            this._privateStatusTwo.removeAt(i);
            this._current.removeAt(i);
            this.to_year.removeAt(i);
            this.to_month.removeAt(i);
            this.from_year_error.removeAt(i);
            this.from_month_error.removeAt(i);
            this.experiences.removeAt(i);
          }
        }
      }

      for (var i = this.educations.length - 1; i >= 0; i--) {
        if (educations[i]['degree'] == '学位を選択') {
          educations[i]['degree'] = null;
        }
        if (educations[i]['from_year'] == '年') {
          educations[i]['from_year'] = null;
        }
        if (educations[i]['to_year'] == '年') {
          educations[i]['to_year'] = null;
        }
        if (educations[i]['from_month'] == '月') {
          educations[i]['from_month'] = null;
        }
        if (educations[i]['to_month'] == '月') {
          educations[i]['to_month'] = null;
        }
        if (educations[i]['education_status'] == 'ステータスを選択') {
          educations[i]['education_status'] = null;
        }
        this.educations[i]['school_name'] = _schoolnameController[i].text;
        this.educations[i]['subject'] = _subjectController[i].text;

        if (this.educations.length != 1) {
          if ((this.educations[i]['school_name'] == null ||
                  this.educations[i]['school_name'] == '') &&
              (this.educations[i]['degree'] == '学位を選択' ||
                  this.educations[i]['degree'] == '') &&
              (this.educations[i]['subject'] == null ||
                  this.educations[i]['subject'] == '') &&
              this.educations[i]['from_year'] == '年' &&
              this.educations[i]['to_year'] == '年' &&
              this.educations[i]['from_month'] == '月' &&
              this.educations[i]['to_month'] == '月' &&
              this.educations[i]['education_status'] == 'ステータスを選択') {
            this._schoolnameController.removeAt(i);
            this._subjectController.removeAt(i);
            this.educations.removeAt(i);
          }
        }
      }

      if (this.carrers['last_currency'] == '通貨単位を選択') {
        this.carrers['last_currency'] = null;
      }
      this.carrers['num_of_experienced_companies'] = _numofexpcompanies.text;
      this.carrers['last_annual_income'] = _finalannualIncome.text;

      BlocProvider.of<CarrerBloc>(context).add(
        UpdateCarrerButtenPressed(
            educations: educations, experiences: experiences, carrers: carrers),
      );
    }

    //formupdateCarrer
    return BlocConsumer<CarrerBloc, CarrerState>(
      listener: (context, state) {
        if (state is UpdateCarrerSuccess) {
          // Navigator.of(context).popAndPushNamed('/profile');
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new ExpansionTileCardDemo(saveSuccess: "保存しました。")));
        } else if (state is CarrerFail) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("career Failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CarrerLoading) {
          print('loading');
          return buildLoading();
        }

        return Container(
          margin: const EdgeInsets.all(0.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("学歴"),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          _addEducation();
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: <Widget>[
                    for (int i = 0; i < this.educations.length; i++)
                      Column(
                        //ROW 1
                        children: [
                          // Container(
                          //     child: new RaisedButton(
                          //   onPressed: () => _removeEducation(i),
                          //   child: new Text('X close'),
                          // )),

                          SizedBox(height: 4),
                          // schoolname
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Column(children: [
                                  Text(
                                    '学校名',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ]),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 60,
                            // padding: const EdgeInsets.all(3.0),
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: '学校名を入力',
                                hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                                fillColor: Colors.white,
                                filled: true,
                                // border: InputBorder.none,
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              controller: _schoolnameController[i],
                            ),
                          ),
                          SizedBox(height: 10),

                          //subject
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  '学部学科',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                          SizedBox(height: 4),
                          Container(
                            // height: 60,
                            // padding: const EdgeInsets.all(3.0),
                            child: new TextFormField(
                              decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: '学部学科を入力',
                                hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                                fillColor: Colors.white,
                                filled: true,
                                // border: InputBorder.none,
                                border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0)),
                              ),
                              controller: _subjectController[i],
                            ),
                          ),
                          SizedBox(height: 10),

                          //degree
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  '学位',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),

                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      margin: const EdgeInsets.only(right: 0.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          disabledHint:
                                              isDisable ? null : Text('学位を選択'),
                                          hint: Text("学位を選択"),
                                          value: educations[i]['degree'],
                                          items: finaleducation.map((edu) {
                                            if (edu != null) {
                                              return DropdownMenuItem(
                                                child: Text(edu),
                                                value: edu,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: isDisable
                                              ? null
                                              : (degree) {
                                                  setState(() {
                                                    educations[i]['degree'] =
                                                        degree;
                                                  });
                                                },
                                        ),
                                      ))),
                            ],
                          ),
                          SizedBox(height: 10),

                          //fromyear  frommonth
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  '在籍期間',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  'から*',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                          Row(
                            children: [
                              Column(children: [
                                Container(
                                    width: 160,
                                    height: 45,
                                    decoration: new BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      border: Border.all(
                                        color:
                                            Colors.grey, // red as border color
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    margin: const EdgeInsets.only(right: 15.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text("年"),
                                        value: educations[i]['from_year'],
                                        items: yearArr.map((year) {
                                          if (year != null) {
                                            return DropdownMenuItem(
                                              child: Text(year),
                                              value: year,
                                            );
                                          }
                                        }).toList(),
                                        onChanged: (year) {
                                          setState(() {
                                            educations[i]['from_year'] = year;
                                          });
                                        },
                                      ),
                                    ))
                              ]),
                              Column(
                                children: [
                                  Container(
                                      width: 160,
                                      height: 45,
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("月"),
                                          value: educations[i]['from_month'],
                                          items: monthArr.map((month) {
                                            if (month != null) {
                                              return DropdownMenuItem(
                                                child: Text(month),
                                                value: month,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (month) {
                                            setState(() {
                                              educations[i]['from_month'] =
                                                  month;
                                            });
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  'まで*',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),

                          //toyear tomonth
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 160,
                                      height: 45,
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("年"),
                                          value: educations[i]['to_year'],
                                          items: yearArr.map((year) {
                                            if (year != null) {
                                              return DropdownMenuItem(
                                                child: Text(year),
                                                value: year,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (year) {
                                            setState(() {
                                              educations[i]['to_year'] = year;
                                            });
                                          },
                                        ),
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: 160,
                                      height: 45,
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("月"),
                                          value: educations[i]['to_month'],
                                          items: monthArr.map((month) {
                                            if (month != null) {
                                              return DropdownMenuItem(
                                                child: Text(month),
                                                value: month,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (month) {
                                            setState(() {
                                              educations[i]['to_month'] = month;
                                            });
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),

                          //status
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  'ステータス',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          hint: Text("ステータスを選択"),
                                          value: educations[i]
                                              ['education_status'],
                                          items: education_status.map((status) {
                                            if (status != null) {
                                              return DropdownMenuItem(
                                                child: Text(status),
                                                value: status,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (status) {
                                            setState(() {
                                              educations[i]
                                                  ['education_status'] = status;
                                            });
                                          },
                                        ),
                                      ))),
                            ],
                          ),
                          SizedBox(height: 20),
                          //crossbutton
                          if (this.educations.length != 1)
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeEducation(i),
                              ),
                            ),
                          if (this.educations.length != 1)
                            Divider(
                              color: Colors.grey,
                            ),
                          // if (this.educations.length != 1)
                          //   Container(
                          //     child: Align(
                          //       alignment: Alignment.topRight,
                          //       child: CircleAvatar(
                          //           radius: 15.0,
                          //           backgroundColor: Colors.grey,
                          //           child: new TextButton(
                          //             onPressed: () => _removeEducation(i),
                          //             child: Icon(Icons.close,
                          //                 color: Colors.white, size: 15.0),
                          //           )),
                          //     ),
                          //   ),
                        ],
                      ),
                  ]),
                ),
                //addEducationButton
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     ElevatedButton(
                //       onPressed: _addEducation,
                //       child:
                //           Text('+ 追加する', style: TextStyle(color: Colors.white)),
                //       style: ButtonStyle(
                //           foregroundColor:
                //               MaterialStateProperty.all<Color>(Colors.white),
                //           backgroundColor:
                //               MaterialStateProperty.all<Color>(Colors.grey),
                //           shape:
                //               MaterialStateProperty.all<RoundedRectangleBorder>(
                //                   RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(5.0),
                //                       side: BorderSide(color: Colors.grey)))),
                //     ),
                //   ],
                // ),

                SizedBox(height: 20),
// -------------------------------------Experiences----------------------------------------------

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  decoration: BoxDecoration(color: Colors.black12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("職歴"),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: () {
                          _addExperience();
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: <Widget>[
                    //num_of_exp_companies
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Column(children: [
                            Text(
                              '経験社数',
                              style: TextStyle(color: Colors.black),
                            )
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 60,
                      // padding: const EdgeInsets.all(3.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: '経験社数を入力',
                          hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                          fillColor: Colors.white,
                          filled: true,
                          // border: InputBorder.none,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                        ),
                        controller: _numofexpcompanies,
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Style.CustomColor.grey,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(bottom: 15.0, top: 0),
                  child: Text(
                    '勤務先',
                    // textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(children: <Widget>[
                      for (int i = 0; i < this.experiences.length; i++)
                        Column(
                          //ROW 1
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Column(children: [
                                    Text(
                                      '経験社数',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ]),
                                ],
                              ),
                            ),

                            SizedBox(height: 4),

                            //private_status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor:
                                          Colors.white, // color of tick Mark
                                      activeColor:
                                          Style.CustomColor.secondaryColor,
                                      value: _privateStatusOne[i],
                                      onChanged: (value) {
                                        setState(() {
                                          _privateStatusOne[i] = value;
                                          _privateStatusTwo[i] = false;
                                          if (value == true) {
                                            experiences[i]['private_status'] =
                                                1;
                                          } else {
                                            experiences[i]['private_status'] =
                                                0;
                                          }
                                        });
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '非公開に',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor:
                                          Colors.white, // color of tick Mark
                                      activeColor:
                                          Style.CustomColor.secondaryColor,
                                      value: _privateStatusTwo[i],
                                      onChanged: (value) {
                                        setState(() {
                                          _privateStatusTwo[i] = value;
                                          _privateStatusOne[i] = false;
                                          if (value == true) {
                                            experiences[i]['private_status'] =
                                                2;
                                          } else {
                                            experiences[i]['private_status'] =
                                                0;
                                          }
                                        });
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '企業名のみ非公開に',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 4),

                            //job-location
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Column(children: [
                                  Text(
                                    '企業名',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ]),
                              ]),
                            ),
                            Container(
                              height: 60,
                              // padding: const EdgeInsets.all(3.0),
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: '勤務先を入力',
                                  hintStyle:
                                      TextStyle(color: Color(0xffc1c1c1)),

                                  fillColor: Colors.white,
                                  filled: true,
                                  // border: InputBorder.none,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                ),
                                controller: _joblocationController[i],
                              ),
                            ),
                            SizedBox(height: 10),

                            //current
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Column(children: [
                                    Text(
                                      '在籍期間',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  checkColor:
                                      Colors.white, // color of tick Mark
                                  activeColor: Style.CustomColor.secondaryColor,
                                  value: _current[i],
                                  onChanged: (value) {
                                    setState(() {
                                      _current[i] = value;
                                      if (value == true) {
                                        // to_year[i]['isDisable'] = true;
                                        // to_month[i]['isDisable'] = true;
                                        experiences[i]['current'] = 1;
                                      } else {
                                        // to_year[i]['isDisable'] = false;
                                        // to_month[i]['isDisable'] = false;
                                        experiences[i]['current'] = 0;
                                      }
                                      isDisableOrNot(i);
                                    });
                                  },
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '現在も在籍中',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),
                            //fromyear  frommonth
                             Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  'から*',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors
                                              .grey, // red as border color
                                        ),
                                      ),
                                      padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      width: 160,
                                      height: 45,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          // hint: Text("年"),
                                          value: experiences[i]['from_year'],
                                          items: yearArr.map((year) {
                                            if (year != null) {
                                              return DropdownMenuItem(
                                                child: Text(year),
                                                value: year,
                                              );
                                            }
                                          }).toList(),
                                          onChanged: (year) {
                                            setState(() {
                                              _formKey.currentState.validate();
                                              experiences[i]['from_year'] =
                                                  year;
                                              changeValue(i);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    // if (from_year_error[i]['error'] != '')
                                      Container(
                                        height: 18,
                                        child: RichText(
                                              text: TextSpan(
                                                text: from_year_error[i]['error'] != '' ? '開始年を入力してください': '',
                                                style: TextStyle(color: Colors.red,fontSize: 13),
                                              ),
                                            ),
                                      ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .grey, // red as border color
                                          ),
                                        ),
                                         padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                                        width: 160,
                                        height: 45,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            // hint: Text("月"),
                                            value: experiences[i]['from_month'],
                                            items: monthArr.map((month) {
                                              if (month != null) {
                                                return DropdownMenuItem(
                                                  child: Text(month),
                                                  value: month,
                                                );
                                              }
                                            }).toList(),
                                            onChanged: (month) {
                                              setState(() {
                                                experiences[i]['from_month'] =
                                                    month;
                                                changeValue(i);
                                              });
                                            },
                                          ),
                                        )),
                                    // if (from_month_error[i]['error'] != '')
                                  Container(
                                    height: 18,
                                    child: RichText(
                                            text: TextSpan(
                                              text: from_month_error[i]['error'] != '' ? '開始月を入力してください' : '',
                                              style: TextStyle(color: Colors.red,fontSize: 13),
                                            ),
                                          ),
                                  ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            //toyear tomonth
                             Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(children: [
                              Column(children: [
                                Text(
                                  'まで*',
                                  style: TextStyle(color: Colors.black),
                                )
                              ]),
                            ]),
                          ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .grey, // red as border color
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 6, 0),
                                        margin:
                                            const EdgeInsets.only(right: 15.0),
                                        width: 160,
                                        height: 45,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            disabledHint: to_year[i]
                                                    ['isDisable']
                                                ? null
                                                : Text('年'),
                                            hint: Text("年"),
                                            value: experiences[i]['to_year'],
                                            items: yearArr.map((year) {
                                              if (year != null) {
                                                return DropdownMenuItem(
                                                  child: Text(year),
                                                  value: year,
                                                );
                                              }
                                            }).toList(),
                                            onChanged: to_year[i]['isDisable']
                                                ? null
                                                : (year) {
                                                    setState(() {
                                                      experiences[i]
                                                          ['to_year'] = year;
                                                    });
                                                  },
                                          ),
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .grey, // red as border color
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        width: 160,
                                        height: 45,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            disabledHint: to_year[i]
                                                    ['isDisable']
                                                ? null
                                                : Text('月'),
                                            hint: Text("月"),
                                            value: experiences[i]['to_month'],
                                            items: monthArr.map((month) {
                                              if (month != null) {
                                                return DropdownMenuItem(
                                                  child: Text(month),
                                                  value: month,
                                                );
                                              }
                                            }).toList(),
                                            onChanged: to_month[i]['isDisable']
                                                ? null
                                                : (month) {
                                                    setState(() {
                                                      experiences[i]
                                                          ['to_month'] = month;
                                                    });
                                                  },
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            //positions
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Column(children: [
                                  Text(
                                    'ポジション',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ]),
                              ]),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .grey, // red as border color
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            // hint: Text("ポジションを選択"),
                                            value: experiences[i]
                                                ['position_id'],
                                            items: _positions.map((pos) {
                                              return DropdownMenuItem(
                                                child: Text(pos.position_name),
                                                value: pos.id,
                                              );
                                            }).toList(),
                                            onChanged: (pos) {
                                              setState(() {
                                                experiences[i]['position_id'] =
                                                    pos;
                                              });
                                            },
                                          ),
                                        ))),
                              ],
                            ),
                            SizedBox(height: 10),

                            //employment_types
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Column(children: [
                                  Text(
                                    '雇用形態',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ]),
                              ]),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors
                                                .grey, // red as border color
                                          ),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            isExpanded: true,
                                            // hint: Text("雇用形態を選択"),
                                            value: experiences[i]
                                                ['employment_type_id'],
                                            items: _employment_types.map((emp) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                    emp.employment_type_name),
                                                value: emp.id,
                                              );
                                            }).toList(),
                                            onChanged: (emp) {
                                              setState(() {
                                                experiences[i]
                                                        ['employment_type_id'] =
                                                    emp;
                                              });
                                            },
                                          ),
                                        ))),
                              ],
                            ),
                            SizedBox(height: 10),

                            //main_duty
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Column(children: [
                                  Text(
                                    '主な業務内容',
                                    style: TextStyle(color: Colors.black),
                                  )
                                ]),
                              ]),
                            ),
                            Container(
                              // padding: const EdgeInsets.all(3.0),
                              child: new TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                decoration: new InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: '例）リーダーとしてメンバーをまとめ上げました。',
                                  hintStyle:
                                      TextStyle(color: Color(0xffc1c1c1)),

                                  fillColor: Colors.white,
                                  filled: true,
                                  // border: InputBorder.none,
                                  border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0)),
                                ),
                                controller: _maindutyController[i],
                              ),
                            ),
                            //crossbutton
                            if (this.experiences.length != 1)
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _removeExperience(i),
                                ),
                              ),
                            if (this.experiences.length != 1)
                              Divider(
                                color: Colors.grey,
                              ),
                            SizedBox(height: 10),
                          ],
                        ),

                      //addExperienceButton
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisSize: MainAxisSize.max,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: _addExperience,
                      //       child: Text('+ 追加する',
                      //           style: TextStyle(color: Colors.white)),
                      //       style: ButtonStyle(
                      //           foregroundColor:
                      //               MaterialStateProperty.all<Color>(
                      //                   Colors.white),
                      //           backgroundColor:
                      //               MaterialStateProperty.all<Color>(
                      //                   Colors.grey),
                      //           shape: MaterialStateProperty.all<
                      //                   RoundedRectangleBorder>(
                      //               RoundedRectangleBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(5.0),
                      //                   side: BorderSide(color: Colors.grey)))),
                      //     ),
                      //   ],
                      // ),

                      SizedBox(height: 20),
                    ])),

                // Final annual income
                Container(
                  decoration: BoxDecoration(
                    color: Style.CustomColor.grey,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(bottom: 15.0, top: 0),
                  child: Text(
                    '職歴',
                    // textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(children: [
                        Column(children: [
                          Text(
                            '最終年収',
                            style: TextStyle(color: Colors.black),
                          )
                        ]),
                      ]),
                    ),
                    Container(
                      height: 60,
                      // padding: const EdgeInsets.all(3.0),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: '金額を入力',
                          hintStyle: TextStyle(color: Color(0xffc1c1c1)),

                          fillColor: Colors.white,
                          filled: true,
                          // border: InputBorder.none,
                          border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                        ),
                        controller: _finalannualIncome,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey, // red as border color
                                  ),
                                ),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text("通貨単位を選択"),
                                    value: carrers['last_currency'],
                                    items: _isolist.map((iso) {
                                      if (iso != null) {
                                        return DropdownMenuItem(
                                          child: Text(iso),
                                          value: iso,
                                        );
                                      }
                                    }).toList(),
                                    onChanged: (iso) {
                                      setState(() {
                                        carrers['last_currency'] = iso;
                                      });
                                    },
                                  ),
                                ))),
                      ],
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 10.0, left: 10, right: 10),
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
                                onPressed: _onUpdateCarreerButtonPressed,
                                child: Text(
                                  "保存する",
                                  style: Style.Customstyles.customText,
                                )),
                          )
                        ])),

                SizedBox(height: 30),
              ])),

          // ignore: missing_required_param
        );
      },
    );
    //form
  }
}
