// import 'package:borderlessWorking/Widget/JobseekerProfile/self_intro_details/self_intro_details_widget.dart';
import 'package:borderlessWorking/Widget/jobseekerProfile/self_intro_details/self_intro_details_widget.dart';
import 'package:borderlessWorking/bloc/jobseeker_profile_bloc/jobseeker_profile_bloc.dart';
import 'package:borderlessWorking/data/model/language.dart';
import 'package:borderlessWorking/data/model/languagelevel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfIntroDetails extends StatefulWidget {
  @override
  _SelfIntroDetailsState createState() => _SelfIntroDetailsState();
}

class _SelfIntroDetailsState extends State<SelfIntroDetails> {
  final JobseekerProfileBloc _newsBloc = JobseekerProfileBloc();
  List<LanguageLevel> language_level;
  List jobseekers;
  List<Language> languages;
  List<String> langList;
  @override
  void initState() {
    _newsBloc.add(GetSelfIntroList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return BlocProvider(
      create: (_) => _newsBloc,
      child: BlocListener<JobseekerProfileBloc, JobseekerProfileState>(
        listener: (context, state) {
          if (state is JobseekerProfileFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<JobseekerProfileBloc, JobseekerProfileState>(
          builder: (context, state) {
            if (state is JobseekerProfileInitial) {
              return buildLoading();
            }
            if (state is GetSelfIntroSuccess) {
              language_level = state.language_level;
              jobseekers = state.jobseekers;
              languages = state.languages;

              langList = new List();
              for (int i = 0; i < language_level.length; i++) {
                if (language_level[i].language_id != null &&
                    language_level[i].language_id != '') {
                  for (int j = 0; j < languages.length; j++) {
                    if (language_level[i].language_id ==
                        languages[j].id.toString()) {
                      var value = languages[j].language_name;
                      if (language_level[i].language_level != null &&
                          language_level[i].language_level != '') {
                        value += '.' + language_level[i].language_level;
                      }
                      langList.add(value);
                    }
                  }
                }
              }

              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return item(jobseekers, langList, context);
                  });
            } else if (state is JobseekerProfileFailure) {
              return Center(child: CupertinoActivityIndicator());
            }
            return buildLoading();
          },
        ),
      ),
    );
  }
}
