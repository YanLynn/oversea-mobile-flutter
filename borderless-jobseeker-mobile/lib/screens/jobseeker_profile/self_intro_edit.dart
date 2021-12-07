import 'dart:io';
import 'dart:math';
import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/bloc/jobseeker_profile_bloc/jobseeker_profile_bloc.dart';
import 'package:borderlessWorking/data/repositories/jobseeker_profile_repositories.dart';
import 'package:borderlessWorking/screens/home/home_screen.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class JobseekerProfile extends StatefulWidget {
  @override
  _JobseekerProfileState createState() => _JobseekerProfileState();
}

class _JobseekerProfileState extends State<JobseekerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Navigator.of(context).popAndPushNamed('/profile');
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new ExpansionTileCardDemo(saveSuccess: null)));
            },
          ),
          title: Text('スカウト待ち⼈材検索⽤⾃⼰紹介', style: TextStyle(color: Colors.white)),
          backgroundColor: Style.CustomColor.mainColor,
        ),
        body: BlocProvider<JobseekerProfileBloc>(
          create: (context) => JobseekerProfileBloc()..add(InitialState()),
          child: SelfIntroEdit(),
        ));
  }
}

class SelfIntroEdit extends StatefulWidget {
  @override
  _SelfIntroEditState createState() => _SelfIntroEditState();
}

class _SelfIntroEditState extends State<SelfIntroEdit> {
  List data = null;

  String youtubeError = '';
  bool deleteFaceImage = false;
  JobseekerProfileRepository jobseekerRepo = new JobseekerProfileRepository();
  String radioItem;
  // String aa = "assets/images/work1.png";
  File _image;
  List files = [];
  List<String> deleteRelatedImages = [];

  final _videoController = TextEditingController();
  final _selfprController = TextEditingController();

  List<File> images = [];
  List imagesData = [];
  FilePickerResult result;
  String _error = 'No Error Dectected';
  var width;
  var height;
  var netWorkImage;
  var hashedFile = [];
  var relatedImages = [];

  var entry = {
    'file': File,
    'url': '',
    'file_url': '',
    'file_type': "photo",
    'user_type': "jobseeker",
  };

  Future<File> urlToFile(String imageUrl) async {
    imageUrl =
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fimages%2Fthings%2Fbook&psig=AOvVaw3ofozYMjvuLDkLiDn1bmd8&ust=1626844029853000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCNDt57Pw8PECFQAAAAAdAAAAABAI';
    var rng = new Random();

    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;

    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.jpeg');

    http.Response response = await http.get(imageUrl);

    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  getFile(String url) async {}

  getSelfIntroDetails() async {
    data = await jobseekerRepo.getSelfIntroDetails();

    relatedImages = data[0].selfIntro['related_images'];
    this.images = [];
    List<File> tempList = [];
    for (var i = 0; i < relatedImages.length; i++) {
      http.Response responseData = await http.get(relatedImages[i]['file_url']);
      var uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      var tempDir = await getTemporaryDirectory();
      File file;
      var ram = new DateTime.now().microsecondsSinceEpoch;
      file = await File('${tempDir.path}/${relatedImages[i]['url']}?cache$ram')
          .writeAsBytes(buffer.asUint8List(
              byteData.offsetInBytes, byteData.lengthInBytes));

      tempList.add(file);
    }

    setState(() {
      _videoController.text = data[0].selfIntro['video'];
      _selfprController.text = data[0].selfIntro['self_pr'];
      radioItem = data[0].selfIntro['face_image_private_status'].toString();

      netWorkImage = data[0].selfIntro['face_image_url'];
      relatedImages = data[0].selfIntro['related_images'];

      this.images = tempList;
      this.hashedFile = data[0].hashedFile;
    });
  }

  @override
  void initState() {
    super.initState();
    getSelfIntroDetails();
  }

  Widget build(BuildContext context) {
    _imgFromCamera() async {
      deleteFaceImage = false;
      File image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    _imgFromGallery() async {
      deleteFaceImage = false;
      File image = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    deleteRelatedImage(index) {
      setState(() {
        var path = this.images[index].path;
        var filename = path.split('cache/')[1].toString();

        if (filename.contains('file_picker')) {
          filename = filename.split('file_picker/')[1];
        }
        var name = filename.split('.')[0];
        for (var i = 0; i < relatedImages.length; i++) {
          if (relatedImages[i]['url'].contains(name)) {
            this.relatedImages.removeAt(i);
          }
        }
        for (var i = 0; i < this.files.length; i++) {
          if (this.files[i]['file_url'].contains(name)) {
            this.files.removeAt(i);
          }
        }

        this.images.removeAt(index);
        this.deleteRelatedImages.add(name);
      });
    }

    Widget buildGridView() {
      return GridView.count(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        childAspectRatio: 1.1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        padding: EdgeInsets.all(0.0),
        crossAxisCount: 2,
        children: List.generate(images.length, (index) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.file(
                File(images[index].path),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    deleteRelatedImage(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    }

    Future<void> loadAssets() async {
      List<File> resultList = [];
      String error = 'No Error Detected';
      try {
        result = await FilePicker.platform.pickFiles(allowMultiple: true);

        if (result != null) {
          resultList = result.files.map((path) => File(path.path)).toList();
        }
      } on Exception catch (e) {
        error = e.toString();
      }

      if (!mounted) return;

      setState(() {
        if (images.length == 4) {
          setState(() {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              DialogContent().infoAlert(context, Icon(Icons.error_outline),
                  'アップロードできる画像数を超えています。', Colors.red);
            });
          });
        } else {
          this.imagesData = [];
          for (var i = 0; i < resultList.length; i++) {
            if (images.length < 4) {
              images.add(resultList[i]);
              imagesData.add(result.files[i]);
            }
          }
          List<String> taken = [];
          for (var rm in relatedImages) {
            taken.add(rm['url'].split('.')[0].toString());
          }

          var availables =
              this.hashedFile.where((x) => !taken.contains(x)).toList();

          imagesData.toList().asMap().forEach((index, multiFile) async {
            var file = await MultipartFile.fromFile(multiFile.path,
                filename: multiFile.name);
            var filename = availables[index];
            var ext = multiFile.name.split('.')[1];

            var entry = {
              'file': file,
              'url': filename + '.' + ext,
              'file_url': multiFile.path,
              'file_type': 'photo',
              'user_type': 'jobseeker',
            };

            files.add(entry);
          });
        }
        // images = resultList;
        // imagesData = result.files;
        // if (resultList.length + this.relatedImages.length > 4) {
        //   AlertMessage().message("only choose 4 images", Colors.red);
        // } else {
        //   List<String> taken = [];
        //   for (var rm in relatedImages) {
        //     taken.add(rm['url'].split('.')[0].toString());
        //   }

        //   var availables =
        //       this.hashedFile.where((x) => !taken.contains(x)).toList();

        //   imagesData.toList().asMap().forEach((index, multiFile) async {
        //     var file = await MultipartFile.fromFile(multiFile.path,
        //         filename: multiFile.name);
        //     var filename = availables[index];
        //     var ext = multiFile.name.split('.')[1];

        //     var entry = {
        //       'file': file,
        //       'url': filename + '.' + ext,
        //       'file_url': multiFile.path,
        //       'file_type': 'photo',
        //       'user_type': 'jobseeker',
        //     };

        //     files.add(entry);
        //   });
        // }

        _error = error;
      });
    }

    deleteFacImage() {
      setState(() {
        this.deleteFaceImage = true;
        this._image = null;
        this.netWorkImage = null;
      });
    }

    _onUpdateSelfIntroButtonPressed() async {
      if (_videoController.text != null && _videoController.text != '') {
        RegExp regExp = RegExp(
            r'http(?:s?):\/\/(?:www\.)?youtu(?:be\.com\/watch\?v=|\.be\/)([\w\-\_]*)(&(amp;)?‌​[\w\?‌​=]*)?');
        String matches = regExp.stringMatch(_videoController.text);
        if (matches == null) {
          setState(() {
            youtubeError = 'URLの形式が正しくありません';
          });
        } else {
          youtubeError = '';
          BlocProvider.of<JobseekerProfileBloc>(context).add(
            UpdateSelfIntroButtonPressed(
              video: _videoController.text,
              selfpr: _selfprController.text,
              faceimageprivatestatus: radioItem,
              deletefacimage: deleteFaceImage,
              faceimage: _image,
              deleterelatedimages: deleteRelatedImages,
              relatedimages: files,
            ),
          );
        }
      } else {
        youtubeError = '';
        BlocProvider.of<JobseekerProfileBloc>(context).add(
          UpdateSelfIntroButtonPressed(
            video: _videoController.text,
            selfpr: _selfprController.text,
            faceimageprivatestatus: radioItem,
            deletefacimage: deleteFaceImage,
            faceimage: _image,
            deleterelatedimages: deleteRelatedImages,
            relatedimages: files,
          ),
        );
      }
    }

    return BlocConsumer<JobseekerProfileBloc, JobseekerProfileState>(
      listener: (context, state) {
        if (state is UpdateSelfIntroSuccess) {
          // Navigator.of(context).popAndPushNamed('/profile');
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new ExpansionTileCardDemo(saveSuccess: "保存しました。")));
        } else if (state is JobseekerProfileFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("サーバとの通信に失敗しました"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is JobseekerProfileLoading || data == null) {
          return buildLoading();
        }
        return new Row(children: <Widget>[
          Expanded(
            child: Form(
                child: ListView(children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFF347).withOpacity(0.28),
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 0.0, top: 0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      // TextSpan(
                      //   text: "Click ",
                      // ),
                      WidgetSpan(
                        child: Icon(
                          Icons.info,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: "「希望職種・希望勤務地→希望条件」「語学レベル→経験・資格」にて設定してください。",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Style.CustomColor.grey,
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 0.0, top: 0),
                child: Text(
                  '顔写真',
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: const EdgeInsets.only(bottom: 0.0, top: 0),
                child: Text(
                  '※ JPG、JPEG、PNGいずれかの形式の画像をアップロード可能です。',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                      child: Column(children: [
                    RaisedButton.icon(
                      color: Colors.grey[200],
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Style.CustomColor.secondaryColor,
                      ),
                      onPressed: () {
                        _showPicker(context);
                      },
                      label: Text(
                        'ファイルを選択',
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ]))),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              if (_image != null)
                                CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey[300],
                                  
                                  child: _image != null
                                      ? CircleAvatar(
                                         radius: 80,
                                        backgroundImage: FileImage(_image),
                                         backgroundColor: Colors.transparent,
                                       
                                          // child: Image.file(
                                          //   _image,
                                          //      width: double.infinity,
                                          //   // height: 115,
                                          //   // fit: BoxFit.fill,
                                          // ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                              width: double.infinity,
                                          
                                          child: Icon(
                                            Icons.photo,
                                            color: Colors.grey[500],
                                            size: 50,
                                          ),
                                        ),
                                ),
                              if (_image == null)
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: netWorkImage != null
                                      ? CircleAvatar(
                                         radius: 80,
                                          backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(netWorkImage))
                                      // ClipRRect(
                                      //     borderRadius:
                                      //         BorderRadius.circular(80),
                                      //     child: Image.network(
                                      //       netWorkImage,
                                      //       width: double.infinity,                                            
                                      //       fit: BoxFit.fill,
                                      //     ),
                                      //   )
                                      : Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(60)),
                                          width: 110,
                                          height: 110,
                                          child: Icon(
                                            Icons.photo,
                                            color: Colors.grey[500],
                                            size: 50,
                                          ),
                                        ),
                                ),

                              Positioned(
                                top: 10,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    deleteFacImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),                             
                            ],
                          ),
                        ),
                        SizedBox(width: 25.0),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'TOPページでの写真公開可否',
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            RadioListTile(
                              activeColor: Style.CustomColor.mainColor,
                              dense: true,
                              groupValue: radioItem,
                              title: Text('公開'),
                              value: '1',
                              onChanged: (val) {
                                setState(() {
                                  radioItem = val;
                                });
                              },
                            ),
                            RadioListTile(
                              activeColor: Style.CustomColor.mainColor,
                              dense: true,
                              groupValue: radioItem,
                              title: Text('非公開'),
                              value: '0',
                              onChanged: (val) {
                                setState(() {
                                  radioItem = val;
                                });
                              },
                            ),
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(bottom: 20,left: 45,top: 0),
              //     child: RawMaterialButton(
              //   onPressed: () {
              //     _showPicker(context);
              //   },
              //   elevation: 2.0,
              //   fillColor: Color(0xFFF5F6F9),
              //   child: Icon(
              //     Icons.camera_alt_outlined,
              //     color: Colors.blue,
              //   ),
              //   padding: EdgeInsets.all(10.0),
              //   // shape: CircleBorder(),
              // )),
              Container(
                decoration: BoxDecoration(
                  color: Style.CustomColor.grey,
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 0.0, top: 0),
                child: Text(
                  '関連画像',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 15.0, top: 0),
                child: Text(
                  '※ JPG、JPEG、PNGいずれかの形式の画像を4枚までアップロード可能です。',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  child: Column(
                    children: [
                      RaisedButton.icon(
                        color: Colors.grey[200],
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Style.CustomColor.secondaryColor,
                        ),
                        onPressed: loadAssets,
                        label: Text(
                          'ファイルを選択',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      buildGridView(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Style.CustomColor.grey,
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 0.0, top: 0),
                child: Text(
                  '関連動画',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  'YouTubeURL',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: new TextFormField(
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '',
                    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                  ),
                  controller: _videoController,
                  autocorrect: false,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  youtubeError.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Style.CustomColor.grey,
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 0.0, top: 15),
                child: Text(
                  '⾃⼰PR、海外で勤務したい理由等',
                  // textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 15.0),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: new TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  // style: TextStyle(fontSize: 14, color: Colors.black54),
                  decoration: new InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '',
                    hintStyle: TextStyle(color: Color(0xffc1c1c1)),
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue)),
                  ),
                  controller: _selfprController,
                  autocorrect: false,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: 30.0, bottom: 20.0, left: 15, right: 15),
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
                          onPressed: _onUpdateSelfIntroButtonPressed,
                          child: Text(
                            "保存する",
                            style: Style.Customstyles.customText,
                          )),
                    )
                  ],
                ),
              ),
            ])),
          )
        ]);
      },
    );
  }
}
