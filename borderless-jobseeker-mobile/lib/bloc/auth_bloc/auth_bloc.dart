import 'dart:async';
import 'package:borderlessWorking/data/api/apis.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_screen.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({@required this.authRepository})
      : assert(authRepository != null),
        super(null);
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      // await authRepository.deleteToken();
      final bool hasToken = await authRepository.hasToken();
      if (hasToken) {
        Apis.token = await authRepository.getToken();
        Map user = await authRepository.getUserData();

        final info = await authRepository.info();
        var userData = {...user, ...info};

        yield AuthenticationAuthenticated(userData);
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authRepository.persistToken(event.token);
      Map user = await authRepository.getUserData();
      final info = await authRepository.info();
      var userData = {...user, ...info};
      yield AuthenticationAuthenticated(userData);
    }

    if (event is LoginFormReturn) {
      yield LoginPage();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      Apis.notificationCounterValueNotifer.value = 0;
      await authRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
