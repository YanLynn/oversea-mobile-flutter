import 'package:borderlessWorking/Widget/scout/scouted_list_widget.dart';
import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoutPage extends StatelessWidget {
  AuthRepository authRepository = AuthRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is AuthenticationAuthenticated) {
        return Container(
          child: ScoutedList(),
        );
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
