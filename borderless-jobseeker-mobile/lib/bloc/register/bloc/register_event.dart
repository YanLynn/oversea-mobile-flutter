part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent
{
    final String jobseeker_name;
    final String jobseeker_furigana_name;
    final String dob;
    final String country_name;
    final String country_id;
    final String phone;
    final String email;
    final String password;

    const RegisterButtonPressed({
         @required this.jobseeker_name,
         @required this.jobseeker_furigana_name,
         @required this.dob,
         @required this.country_name, 
         @required this.country_id,
         @required this.phone,
         @required this.email,
         @required this.password,
    });

      @override
      List<Object> get props => [jobseeker_name,jobseeker_furigana_name,dob,country_name,country_id,phone,email,password];

      @override
      String toString() =>
      'RegisterButtonPressed {jobseeker_name: $jobseeker_name, jobseeker_furigana_name: $jobseeker_furigana_name,dob: $dob,country_name: $country_name,country_id: $country_id,phone: $phone, email: $email, password: $password }';
}

class InitialState extends RegisterEvent {
  @override
  List<Object> get props => [];
}
