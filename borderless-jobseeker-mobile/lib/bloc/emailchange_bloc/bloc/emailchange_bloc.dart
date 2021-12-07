import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/emailchange_repositories.dart';
import 'package:equatable/equatable.dart';

part 'emailchange_event.dart';
part 'emailchange_state.dart';

class EmailchangeBloc extends Bloc<EmailchangeEvent, EmailchangeState> {
  final EmailchangeRepository _emailchangeRepository = EmailchangeRepository();
  EmailchangeBloc() : super(EmailchangeInitial());

  @override
  Stream<EmailchangeState> mapEventToState(
    EmailchangeEvent event,
  ) async* {
    if (event is ChangeEmailButtonPressed) {
      yield EmailSettingLoading();
      try {
        final data = await _emailchangeRepository.changeemail(event.email);
        yield EmailChangedSuccess(data);
      } catch (error) {
        final msg = error.response.data['error'];
        yield EmailchangeFailure(error: msg.toString());
      }
    }
    if (event is Checkpassword) {
      try {
        final data =
            await _emailchangeRepository.checkPassword2(event.password);
        yield PasswordcheckSuccess(data);
      } catch (error) {
        final msg = error.response.data['error'];
        yield PasswordcheckFailure(passworderror: msg.toString());
      }
    }
    if (event is InitialState) {
      yield EmailchangeInitial();
    }
  }
}
