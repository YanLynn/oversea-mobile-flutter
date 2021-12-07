import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:borderlessWorking/data/repositories/contactus_repositories.dart';
import 'package:borderlessWorking/screens/contactus/contactusSuccess_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'contactus_event.dart';
part 'contactus_state.dart';

class ContactusBloc extends Bloc<ContactusEvent, ContactusState> {
  final ContactusRepository contactusRepository = ContactusRepository();
  ContactusBloc() : super(ContactusInitial());

  @override
  Stream<ContactusState> mapEventToState(
    ContactusEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ContactusButtonPressed) {
      try {
        yield ContactusLoading();
        final data = await contactusRepository.contactus(
            event.corporateName,
            event.name,
            event.furiganaName,
            event.email,
            event.confirmEmail,
            event.inquiryDetails,
            event.policy);
        yield ContactusSuccess();
      } catch (error) {
        yield ContactusFail(error: error.toString());
      }
    }
    if (event is InitialState) {
      yield ContactusInitial();
    }
  }
}
