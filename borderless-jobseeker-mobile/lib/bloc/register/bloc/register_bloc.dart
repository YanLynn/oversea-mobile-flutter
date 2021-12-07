import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/register_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository = RegisterRepository();
  RegisterBloc() : super(RegisterInitial());

  @override
  // ignore: override_on_non_overriding_member
  RegisterState get initialState => RegisterInitial();
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();
      try {
        final data = await registerRepository.register(
          event.jobseeker_name,
          event.jobseeker_furigana_name,
          event.dob,
          event.country_name,
          event.country_id,
          event.phone,
          event.email,
          event.password,
        );
        yield RegisterSuccessful();
        // Get.to(() => registersuccess());
      } catch (error) {
        yield RegisterFailure(error: error.toString());
      }
    }
    if (event is InitialState) {
      yield RegisterInitial();
    }
  }
}
