import 'dart:io';

import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'bloc/auth_bloc/auth.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'data/repositories/auth_repositories.dart';

//Cannot connect "https" server or self-signed certificate server
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  final authRepository = AuthRepository();
  Apis.socket.on(
      "count-message",
      (data) => {
            Apis.userList.forEach((e) {
              if (e.scoutid_or_applyid == data['scoutid_or_applyid'] &&
                  e.type == data['type']) {
                Apis.notiCountforHomeIcon.value++;
                e.last_chat_time = data["created_at_time"];  
              } else {
                print('object');
              }
            }),
          });
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(authRepository: authRepository)
          ..add(AppStarted());
      },
      child: MyApp(authRepository: authRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  MyApp({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();
    return BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) => AuthenticationBloc(
              authRepository: authRepository,
            )..add(AppStarted()),
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            // navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'NotoSansJP',
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        }));
  }
}
