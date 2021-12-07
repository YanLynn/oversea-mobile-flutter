import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'deactivate_event.dart';
part 'deactivate_state.dart';

class DeactivateBloc extends Bloc<DeactivateEvent, DeactivateState> {
  DeactivateBloc() : super(null);
  AuthRepository authRepository = AuthRepository();
  @override
  Stream<DeactivateState> mapEventToState(
    DeactivateEvent event,
  ) async* {
    if (event is DeactivateButtonPressed) {
      yield DeactivateLoading();
      try {
        final deactivate = await authRepository.deactivate(
          event.password,
        );
        yield DeactivateSuccess();
        await authRepository.deleteToken();
      } catch (error) {
        var msg = '';
        if (error.response.data['msg'] == null) {
          msg = error.response.data['error'];
        } else {
          msg = error.response.data['msg'];
        }
        yield DeactivateFailure(error: msg.toString());
      }
    }
  }
}
