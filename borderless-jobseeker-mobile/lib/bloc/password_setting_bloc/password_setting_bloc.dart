import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/password_setting_repositories.dart';
import 'package:equatable/equatable.dart';

part 'password_setting_event.dart';
part 'password_setting_state.dart';

class PasswordSettingBloc
    extends Bloc<PasswordSettingEvent, PasswordSettingState> {
  final PasswordSettingRepository _passwordSettingRepository =
      PasswordSettingRepository();
  PasswordSettingBloc() : super(PasswordSettingInitial());

  @override
  Stream<PasswordSettingState> mapEventToState(
    PasswordSettingEvent event,
  ) async* {
    if (event is CheckPasswordButtonPressed) {
      yield PasswordSettingLoading();
      try {
        final data =
            await _passwordSettingRepository.checkPassword(event.password);
        yield PasswordSettingSuccess(data);
      } catch (error) {
        var msg = error.response.data['error'];
        yield PasswordSettingFailure(error: msg.toString());
      }
    }

    if (event is ChangePasswordButtonPressed) {
      yield PasswordSettingLoading();
      try {
        final data =
            await _passwordSettingRepository.changePassword(event.password);
        yield PasswordChangedSuccess(data);
      } catch (error) {
        var msg = error.response.data['error'];
        yield PasswordSettingFailure(error: msg.toString());
      }
    }

    if (event is CancelChangePassword) {
      yield PasswordChangedSuccess(null);
    }


  }
}
