part of 'basicinfo_bloc.dart';

abstract class BasicinfoEvent extends Equatable {
  const BasicinfoEvent();

  @override
  List<Object> get props => [];
}
class Getbasicinfolist extends BasicinfoEvent {
  @override
  List<Object> get props => null;
}

class UpdateButtonPressed extends BasicinfoEvent
{
    final String jobseeker_name;
    final String jobseeker_furigana_name;
    final String jobseeker_furigana_name_status;
    final String gender;
    final String gender_status;
    final String dob;
    final String dob_status;
    final String current_address_status;
    final String address;
    final String phone;
    final String email;
    final String skype_account;
    final String final_education;
    final String current_situation;
    final String city_name;
    final String country_name;
    final String language_id;

    const UpdateButtonPressed({
     @required this.jobseeker_name,
     @required this.jobseeker_furigana_name,
     @required this.jobseeker_furigana_name_status,
     @required this.gender,
     @required this.gender_status,
     @required this.dob,
     @required this.dob_status,
     @required this.current_address_status,
     @required this.address,
     @required this.phone,
     @required this.email,
     @required this.skype_account,
     @required this.final_education,
     @required this.current_situation,
     @required this.city_name,
    @required this.country_name,
     @required this.language_id,
    });

      @override
      List<Object> get props => [jobseeker_name,jobseeker_furigana_name,jobseeker_furigana_name_status,gender,gender_status,dob,dob_status,current_address_status,address,email,phone,skype_account,final_education,current_situation,city_name,country_name,language_id];

      @override
      String toString() =>
      'RegisterButtonPressed {jobseeker_name: $jobseeker_name, jobseeker_furigana_name: $jobseeker_furigana_name,jobseeker_furigana_name_status: $jobseeker_furigana_name_status, gender: $gender, gender_status: $gender_status,dob: $dob,dob_status: $dob_status,current_address_status: $current_address_status,address: $address, email: $email,phone: $phone,skype_account: $skype_account,final_education: $final_education,current_situation: $current_situation,city_name: $city_name,countrt_name: $country_name,language_id: $language_id}';
}

class InitialState extends BasicinfoEvent {
  @override
  List<Object> get props => [];
}