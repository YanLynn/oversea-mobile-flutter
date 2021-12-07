import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/screens/jobappliedlist/jobappliedlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_form.dart';

class ApplicantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    return Scaffold(
        // appBar: AppBar(
        //     title: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
        //     centerTitle: true,
        //     backgroundColor: Style.CustomColor.mainColor),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return Container(
          child: Jobappliedlist(),
        );
        // return Scaffold(
        //   body: Center(
        //     child: FlatButton(
        //       child: Text('Logout'),
        //       color: Colors.blueAccent,
        //       textColor: Colors.white,
        //       onPressed: () => {
        //         BlocProvider.of<AuthenticationBloc>(context).add(
        //           LoggedOut(),
        //         )
        //       },
        //     ),
        //   ),
        // );
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