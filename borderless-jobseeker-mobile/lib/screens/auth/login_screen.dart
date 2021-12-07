import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:flutter/material.dart';
import 'login_form.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;

class LoginScreen extends StatelessWidget {
  final AuthRepository authRepository;

  LoginScreen({Key key, @required this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.CustomColor.mainColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).pushNamed('/');
          },
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Style.CustomColor.mainColor,
      body: LoginForm(
          authRepository: authRepository
        ),
      // body: BlocProvider(
      //   create: (context) {
      //     return LoginBloc(
      //       authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      //       authRepository: authRepository,
      //     );
      //   },
      //   child: LoginForm(
      //     authRepository: authRepository,
      //   ),
      // ),
    );
  }
}
