part of 'contactus_bloc.dart';

abstract class ContactusEvent extends Equatable {
  const ContactusEvent();

  @override
  List<Object> get props => [];
}

class ContactusButtonPressed extends ContactusEvent {
  final String corporateName;
  final String name;
  final String furiganaName;
  final String email;
  final String confirmEmail;
  final String inquiryDetails;
  final bool policy;

  const ContactusButtonPressed({
    @required this.corporateName,
    @required this.name,
    @required this.furiganaName,
    @required this.email,
    @required this.confirmEmail,
    @required this.inquiryDetails,
    @required this.policy,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        corporateName,
        name,
        furiganaName,
        email,
        confirmEmail,
        inquiryDetails,
        policy
      ];
  @override
  String toString() =>
      'ContactusButtonPressed {corporate_name: $corporateName, name:$name, furigana_name:$furiganaName, email:$email, confirm_email:$confirmEmail, inquiry_details:$inquiryDetails, policy: $policy}';
  // {
  //   // TODO: implement toString
  //   return super.toString();
  // }
// class ContentForm extends ContentEvent {}
}

class InitialState extends ContactusEvent {
  @override
  List<Object> get props => [];
}
