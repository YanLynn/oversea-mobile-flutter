import 'package:borderlessWorking/Widget/message_alert.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/api/apiServices.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/api/chattingApiServices.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/Favourite/Fav_screen.dart';
import 'package:borderlessWorking/screens/applicant/applicants_screen.dart';
import 'package:borderlessWorking/screens/auth/drawerBar.dart';
import 'package:borderlessWorking/screens/home/home_screen.dart';
import 'package:borderlessWorking/screens/public_search/public_home.dart';
import 'package:borderlessWorking/screens/scout/scout_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicHomeScreen extends StatefulWidget {
  final String checkAlert;
  final int selectedIndex;
  final AuthRepository authRepository;
  List<dynamic> countryList;
  List<dynamic> occupationList;
  PublicHomeScreen(
      {Key key,
      @required this.authRepository,
      this.checkAlert,
      this.selectedIndex,
      this.countryList,
      this.occupationList})
      : super(key: key);

  @override
  _PublicHomeScreen createState() => _PublicHomeScreen(this.authRepository,this.checkAlert,
      this.selectedIndex, this.countryList, this.occupationList);
}

class _PublicHomeScreen extends State<PublicHomeScreen> with ChangeNotifier {
  String checkAlert;
  int _selectedIndex;
  final AuthRepository authRepository;
  List<dynamic> countryList;
  List<dynamic> occupationList;
  Apis apis = new Apis();
  int count = 0;

  // join active user
  joinUser() async {
    Apis.socket.connect();
    bool hasToken = await ApiService().hasToken();
    if (hasToken) {
      Map getCurrentUser = await authRepository.getUserData();
      Apis.socket.emit('join', getCurrentUser['id']);
      Apis.userData = getCurrentUser;

      Apis.userList = await ChatApiServices().getChatUserList();

      int sum = 0;
      Apis.userList.forEach((job) => {sum += job.unread});
      Apis.notiCountforHomeIcon.value = sum;
    }
  }

  _PublicHomeScreen(this.authRepository, this.checkAlert, this._selectedIndex, this.countryList,
      this.occupationList);
  @override
  List<Widget> _widgetOptions() => [
        HomePage(),
        PublicSerch(data: [countryList, occupationList]),
        Favouritelist(authRepository: authRepository),
        ApplicantsPage(),
        ScoutPage()
      ];
  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        Apis.loginPageType = 'fav';
      }
      if (index == 3) {
        Apis.loginPageType = 'apply';
      }
      if (index == 4) {
        Apis.loginPageType = 'scout';
      }
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    getFavCount();
    Apis.countryList = countryList;
    Apis.occupationList = occupationList;
    joinUser();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showAlert());
  }

  Future _showAlert() async {
    print("checkalert"+ this.checkAlert);
    print("hello");
    if (this.checkAlert != null && this.checkAlert != '') {
      DialogContent().infoAlert(context, Icon(Icons.check_circle_outline),
          this.checkAlert, Colors.greenAccent);
    }
  }

  getFavCount() async {
    bool hasToken = await ApiService().hasToken();
    if (hasToken) {
      count = await ApiService().getAllFavCount();
      Apis.notificationCounterValueNotifer.value = count;
      final info = await authRepository.info();
      Apis.profileImg = info["face_image_url"]; 
      Apis.userName = info["name"]; 
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = _widgetOptions();
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
          centerTitle: true,
          automaticallyImplyLeading: true,
        //   leading: Builder(builder: (context) => new IconButton(icon: new Icon(
        //   Icons.menu
        // ),onPressed:() async {
        //   print("hello");
        //   Scaffold.of(context).openDrawer();
        //   // bool hasToken = await ApiService().hasToken();
        //   // if (hasToken) {
        //   //   final info = await authRepository.info();
        //   //   profileImg = info["face_image_url"];          
        //   // }
        // })),

          backgroundColor: Style.CustomColor.mainColor,
          actions: <Widget>[
            Column(
              children: <Widget>[
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return ValueListenableBuilder(
                        valueListenable: Apis.notiCountforHomeIcon,
                        builder: (BuildContext context, int newNotiCounter,
                            Widget child) {
                          return Stack(
                            children: [
                              IconButton(
                                  onPressed: () => {
                                        Navigator.of(context)
                                            .pushNamed('/chat-lists')
                                      },
                                  icon: Icon(
                                    Icons.message_rounded,
                                   
                                  )),
                              if (newNotiCounter != 0)
                                Container(
                                  width: 36,
                                  height: 30,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 1),
                                  child: Container(
                                    width: 25,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFF0051),
                                        border: Border.all(
                                            color: Colors.white, width: 0)),
                                    child: Center(
                                      child: Text(
                                          newNotiCounter < 5
                                              ? newNotiCounter.toString()
                                              : '5+',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        });
                    // return IconButton(
                    //     icon: Icon(Icons.message_rounded),
                    //     onPressed: () {
                    //       Navigator.of(context).pushNamed('/chat-lists');
                    //     });
                  }
                  // if (state is AuthenticationUnauthenticated) {
                  //   return IconButton(
                  //       icon: Icon(EvaIcons.logIn),
                  //       onPressed: () {
                  //         Navigator.of(context).pushNamed('/login');
                  //       });
                  // }
                  else {
                    return Container();
                  }
                })
              ],
            )
          ],
        ),
        drawer: new MyDrawer((Apis.profileImg != null && Apis.profileImg != '') ? Apis.profileImg : '', 
        (Apis.userName != null && Apis.userName != '') ? Apis.userName : ''),
        body: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          builder: (BuildContext context, int newNotificationCounterValue,
              Widget child) {
            return Container(
              padding: EdgeInsets.only(top: 1.5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: 30), title: Text('ホーム')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search, size: 30), title: Text('求⼈検索')),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.star, size: 30), title: Text('お気に⼊り')),
                  BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          Icon(
                            Icons.star,
                            size: 30,
                          ),
                          if (newNotificationCounterValue != 0)
                            Container(
                              width: 36,
                              height: 30,
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(top: 1),
                              child: Container(
                                width: 25,
                                height: 18,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFF0051),
                                    border: Border.all(
                                        color: Colors.white, width: 0)),
                                child: Center(
                                  child: Text(
                                      newNotificationCounterValue.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                ),
                                // child: Padding(
                                //   padding: const EdgeInsets.all(3),
                                //   child: Text(
                                //     newNotificationCounterValue.toString(),
                                //     style: TextStyle(
                                //         fontSize: 10, color: Colors.white),
                                //   ),
                                // ),
                              ),
                            ),
                        ],
                      ),
                      title: Text('お気に⼊り')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work, size: 30), title: Text('応募中求⼈')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mark_as_unread, size: 30),
                      title: Text('スカウト')),
                ],
                currentIndex: _selectedIndex,
                backgroundColor: Style.CustomColor.mainColor,
                type: BottomNavigationBarType.fixed,
                elevation: 5.0,
                selectedItemColor: Style.CustomColor.secondaryColor,
                unselectedItemColor: Colors.white,
                onTap: _onItemTapped,
              ),
            );
          },
          valueListenable: Apis.notificationCounterValueNotifer,
        ));
  }
}
