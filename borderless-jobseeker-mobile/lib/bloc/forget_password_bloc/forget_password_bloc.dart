import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(null);
  AuthRepository authRepository = AuthRepository();

  @override
  Stream<ForgetPasswordState> mapEventToState(
    ForgetPasswordEvent event,
  ) async* {
    if (event is ForgetButtonPressed) {
      try {
        yield ForgetPasswordInitial();
        final data = await authRepository.forgetPassword(
          event.email,
          event.routeName,
        );
        yield ForgetPasswordSuccess(data);
      } catch (error) {
        final msg = error.response.data['error'];
        yield ForgetPasswordFailure(error: msg.toString());
      }
    }
  }
}
