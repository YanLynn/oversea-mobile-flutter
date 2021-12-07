import 'dart:async';

import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.authRepository,
    @required this.authenticationBloc,
  })  : assert(authRepository != null),
        assert(authenticationBloc != null),
        super(null);

  // @override
  // LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await authRepository.login(
          event.email,
          event.password,
        );

        Apis.token = token['access_token'];
        Map usr = token['user'];
        authenticationBloc.add(LoggedIn(token: token['access_token']));
        await authRepository.persistUserData(usr);

        yield LoginSuccess();
      } catch (error) {
        final msg = error.response.data['msg'];
        yield LoginFailure(error: msg.toString());
      }
    }
  }
}
