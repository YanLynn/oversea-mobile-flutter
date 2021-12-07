part of 'contactus_bloc.dart';

abstract class ContactusState extends Equatable {
  const ContactusState();

  @override
  List<Object> get props => [];
}

class ContactusInitial extends ContactusState {}

class ContactusLoading extends ContactusState {}

class ContactusSuccess extends ContactusState {}

class ContactusFail extends ContactusState {
  final String error;
  const ContactusFail({@required this.error});
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'ContactusFail { error: $error }';
}
