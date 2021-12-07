import 'package:borderlessWorking/Widget/favourite/favouriteList_widget.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth_bloc.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/screens/auth/login_form.dart';

class Favouritelist extends StatefulWidget {
  final AuthRepository authRepository;
  Favouritelist({Key key, @required this.authRepository}) : super(key: key);
  @override
  _Favouritelist createState() => _Favouritelist(this.authRepository);
}

class _Favouritelist extends State<Favouritelist> {
  final AuthRepository authRepository;
  _Favouritelist(this.authRepository);
  bool clicked = false;

  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (clicked) {
      return LoginScreen(authRepository: authRepository);
    } else {
      return Scaffold(body:
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return Column(children: <Widget>[
            Expanded(child: Container(child: FavouriteCard()))
          ]);
        }
        if (state is AuthenticationUnauthenticated) {
          // return GettingStartedScreen();
          return LoginForm(authRepository: authRepository);
        }
        return buildLoading();
      }));
    }
  }

  Widget buildLoading() => Center(child: CupertinoActivityIndicator());
}
