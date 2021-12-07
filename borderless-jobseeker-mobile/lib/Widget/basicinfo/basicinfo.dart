import 'package:borderlessWorking/bloc/basicinfo/basicinfo_bloc.dart';
import 'package:borderlessWorking/data/model/basicinfo.dart';
import 'package:borderlessWorking/data/repositories/basicinfo_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class Getbasicinfo extends StatefulWidget {
  // const Getbasicinfo({ Key? key }) : super(key: key);

  @override
  _GetbasicinfoState createState() => _GetbasicinfoState();
}

class _GetbasicinfoState extends State<Getbasicinfo> {
  Getjobseekerdetails _getjobseekerdetails = Getjobseekerdetails();
  final BasicinfoBloc _basicinfoBloc = BasicinfoBloc();

  @override
  void initState() {
    super.initState();
    _basicinfoBloc.add(Getbasicinfolist());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _basicinfoBloc,
        child: BlocBuilder<BasicinfoBloc, BasicinfoState>(
          builder: (context, state) {
            if (state is BasicinfoInitial) {
              // return buildLoading();
            } else if (state is BasicinfoSuccess) {
              List<Basicinfo> info = state.info;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: info.length,
                  itemBuilder: (context, position) {
                    return Jobseekerinfo(info[position], context);
                  });
            }
            return buildLoading();
          },
        ));
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
  Widget Jobseekerinfo(Basicinfo info, BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        //jobseeker_number
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              '求職者会員番号',
              style: TextStyle(
                color: Style.CustomColor.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13, top: 5,right: 13),
            child: Text(
              info.jobseeker_number,
              style: TextStyle(fontSize: 14),
            )),
        //jobseeker_number
        Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
      
        //jobseeker_name
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13),
            child: Text(
              '求職者氏名',
              style: TextStyle(
                color: Style.CustomColor.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            )),
        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13, top: 5,right: 13),
            child: Text(
              info.jobseeker_name,
              style: TextStyle(fontSize: 14),
            )),
        //jobseeker_name
         Divider(
          color: Colors.grey,
        ),
       SizedBox(height: 5),
        //furigana
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'フリガナ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (info.jobseeker_furigana_name_status == 1)
                Container(
                    color: Colors.orangeAccent,
                    padding: const EdgeInsets.all(3.0),
                    child: Text('非公開',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),
        

        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13),
            child: Text(
              info.jobseeker_furigana_name,
              style: TextStyle(fontSize: 14),
            )),
        //furigana
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //gender
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '性別',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (info.gender_status == 1)
                Container(
                    color: Colors.orangeAccent,
                    padding: const EdgeInsets.all(3.0),
                    child: Text('非公開',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),
        if (info.gender == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.gender,
                style: TextStyle(fontSize: 14),
              )),
        //gender
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //dob
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '生年月日',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (info.dob_status == 1)
                Container(
                    color: Colors.orangeAccent,
                    padding: const EdgeInsets.all(3.0),
                    child: Text('非公開',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),
        if (info.dob == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.dob,
                style: TextStyle(fontSize: 14),
              )),
        //dob
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //lang_name
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '母国語',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (info.language_name == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.language_name,
                style: TextStyle(fontSize: 14),
              )),
        //lang_name
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //country_name
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '現住所',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (info.current_address_status == 1)
                Container(
                    color: Colors.orangeAccent,
                    padding: const EdgeInsets.all(3.0),
                    child: Text('非公開',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),
        if (info.country_name == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13),
            child: Row(children: [
              Text(
                info.country_name,
                style: TextStyle(fontSize: 14),
              ),
              Text(','),
              if (info.only_country == 1) Text('') else Text(info.city_name)
              // )
            ]),
          ),
        //country_name
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //address
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '住所詳細',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  color: Style.CustomColor.pink,
                  padding: const EdgeInsets.all(3.0),
                  child: Text('運営管理者のみ閲覧可',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),
        if (info.address == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.address,
                style: TextStyle(fontSize: 14),
              )),
        //address
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //phone
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '電話番号',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  color: Style.CustomColor.pink,
                  padding: const EdgeInsets.all(3.0),
                  child: Text('運営管理者のみ閲覧可',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),

        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13,right: 13),
            child: Text(
              info.phone,
              style: TextStyle(fontSize: 14),
            )),
        //phone
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //email
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'メールアドレス',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  color: Style.CustomColor.pink,
                  padding: const EdgeInsets.all(3.0),
                  child: Text('運営管理者のみ閲覧可',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),

        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13,right: 13),
            child: Text(
              info.email,
              style: TextStyle(fontSize: 14),
            )),
        //email
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //skype
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'スカイプ名',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  color: Style.CustomColor.pink,
                  padding: const EdgeInsets.all(3.0),
                  child: Text('運営管理者のみ閲覧可',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white, fontSize: 13.0))),
            ],
          ),
        ),

        Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 13,right: 13),
            child: Text(
              info != null && info.skype_account != null
                  ? info.skype_account
                  : "未入力",
              style: TextStyle(fontSize: 14),
            )),
        //skype
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //final_education
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '最終学歴',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (info.final_education == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.final_education,
                style: TextStyle(fontSize: 14),
              )),
        //final_education
         Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 5),
        //current_situation
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '現在の状況',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Style.CustomColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (info.current_situation == null)
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13),
              child: Text(
                '未入力',
                style: TextStyle(fontSize: 14),
              ))
        else
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 13,right: 13),
              child: Text(
                info.current_situation,
                style: TextStyle(fontSize: 14),
              )),
        //current_situation
        SizedBox(
          height: 4,
        )
      ],
    )));
  }
}
