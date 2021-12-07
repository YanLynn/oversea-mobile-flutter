import 'package:borderlessWorking/Widget/basicinfo/basicinfo.dart';
import 'package:borderlessWorking/Widget/basicinfo/basicinfo_edit.dart';
import 'package:borderlessWorking/Widget/jobdetails/jobdetails.dart';
import 'package:borderlessWorking/Widget/publicSearch/country_list.dart';
import 'package:borderlessWorking/Widget/publicSearch/occupation_list.dart';
import 'package:borderlessWorking/Widget/setting/timezone_list.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/forget_password.dart';
import 'package:borderlessWorking/screens/auth/forget_password_success.dart';
import 'package:borderlessWorking/screens/auth/login_screen.dart';
import 'package:borderlessWorking/screens/chatting/chat_list.dart';
import 'package:borderlessWorking/screens/chatting/chat_room.dart';
import 'package:borderlessWorking/screens/contactus/contactusSuccess_screen.dart';
import 'package:borderlessWorking/screens/contactus/contactus_screen.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/carrer_details.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/carrer_edit.dart';
import 'package:borderlessWorking/screens/jobappliedlist/jobappliedlist.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/desired_condition_edit.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/exp_qualification_edit.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/profile.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/self_intro_details.dart';
import 'package:borderlessWorking/screens/jobseeker_profile/self_intro_edit.dart';
import 'package:borderlessWorking/screens/public/about_screen.dart';
import 'package:borderlessWorking/screens/public/jobseekerflow_screen.dart';
import 'package:borderlessWorking/screens/public/privacypolicy_screen.dart';
import 'package:borderlessWorking/screens/public/public_home_srceen.dart';
import 'package:borderlessWorking/screens/public/specified_commerical_transactions_screen.dart';
import 'package:borderlessWorking/screens/public/terms_screen.dart';
import 'package:borderlessWorking/screens/public_search/public_home.dart';
import 'package:borderlessWorking/screens/public_search/public_search_result.dart';
import 'package:borderlessWorking/screens/register/register.dart';
import 'package:borderlessWorking/screens/register/register_success.dart';
import 'package:borderlessWorking/screens/setting/all_setting.dart';
import 'package:borderlessWorking/screens/setting/scout_setting.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AuthRepository authRepository = AuthRepository();
  Route onGenerateRoute(RouteSettings settings) {
    // final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PublicHomeScreen(
              authRepository: authRepository, checkAlert: '', selectedIndex: 0),
        );
      case '/login':
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => LoginScreen(authRepository: authRepository));
      case '/register':
        return MaterialPageRoute(
          builder: (_) => Formregister(),
        );
      case '/JobseekerProfile':
        return MaterialPageRoute(
          builder: (_) => JobseekerProfile(),
        );
      case '/SelfIntroDetail':
        return MaterialPageRoute(
          builder: (_) => SelfIntroDetails(),
        );
      // case '/carrer-edit':
      //   return MaterialPageRoute(
      //     builder: (_) => CarrerEdit(),
      //   );
      case '/carrer-detail':
        return MaterialPageRoute(
          builder: (_) => CarrerDetail(),
        );
      case '/forget-password':
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
        );
      case '/scout-setting':
        return MaterialPageRoute(
          builder: (_) => ScoutSetting(),
        );
      case '/all-setting':
        return MaterialPageRoute(
          builder: (_) =>
              AllSetting(timezoneVal: 'timezone', offsetVal: 'offset'),
        );
      case '/content':
        return MaterialPageRoute(
          builder: (_) => ContactusScreen(),
        );
      case '/Jobappliedlist':
        return MaterialPageRoute(
          builder: (_) => Jobappliedlist(),
        );
      case '/privacypolicy':
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicyPage(),
        );
      case '/terms':
        return MaterialPageRoute(
          builder: (_) => TermsPage(),
        );
      case '/about':
        return MaterialPageRoute(
          builder: (_) => AboutPage(),
        );
      case '/specified-commerical-transactions':
        return MaterialPageRoute(
          builder: (_) => SpecifiedCommercialTransPage(),
        );
      case '/jobseeker-flow':
        return MaterialPageRoute(
          builder: (_) => JobseekerflowPage(),
        );
      case '/contactus-success-screen':
        return MaterialPageRoute(
          builder: (_) => ContactusSuccessScreen(),
        );
      case '/register-success-screen':
        return MaterialPageRoute(
          builder: (_) => Registersuccess(),
        );
      case '/forget-pass-success-screen':
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordSuccess(),
        );
      case '/chat-lists':
        return MaterialPageRoute(
          builder: (_) => ChatLists(),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ExpansionTileCardDemo(saveSuccess: null),
        );
      case '/career-edit':
        return MaterialPageRoute(
          builder: (_) => CarrerEdit(),
        );
      case '/public-search':
        return MaterialPageRoute(
          builder: (_) => PublicSerch(data: settings.arguments),
        );
      case '/selfIntro-edit':
        return MaterialPageRoute(
          builder: (_) => JobseekerProfile(),
        );

      case '/time-zone-list':
        return MaterialPageRoute(
          builder: (_) => TimezoneList(),
        );
      case '/chat-room':
        return MaterialPageRoute(
          builder: (_) => ChatRoom(
            chatUserData: settings.arguments,
          ),
        );
      case '/desired-condition-edit':
        return MaterialPageRoute(
          builder: (_) => DesiredConditionEdit(),
        );
      case '/exp-qualification-edit':
        return MaterialPageRoute(
          builder: (_) => ExpQualificationEdit(),
        );
      case '/country-list':
        return MaterialPageRoute(
            builder: (_) => CountryList(data: settings.arguments));

      case '/basicinfo':
        return MaterialPageRoute(
          builder: (_) => Getbasicinfo(),
        );
      case '/editbasicinfo':
        return MaterialPageRoute(
          builder: (_) => Basicinfoedit(),
        );
      case '/public-home':
        return MaterialPageRoute(
            builder: (_) => PublicSerch(data: settings.arguments));
      case '/occupation-list':
        return MaterialPageRoute(
            builder: (_) => OccupationList(data: settings.arguments));
      case '/public-search-result':
        return MaterialPageRoute(
            builder: (_) => PublicSearchResult(jobsData: settings.arguments));
      case '/job-details':
        return MaterialPageRoute(
            builder: (_) => JobData(job_id: settings.arguments));

      default:
        return null;
    }
  }
}
