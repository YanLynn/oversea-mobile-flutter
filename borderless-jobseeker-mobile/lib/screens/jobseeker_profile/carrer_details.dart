import 'package:borderlessWorking/Widget/jobseekerProfile/carrer_details_widget.dart';
import 'package:borderlessWorking/bloc/carrer_bloc/carrer_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarrerDetail extends StatefulWidget {
  @override
  _CarrerDetailsState createState() => _CarrerDetailsState();
}

class _CarrerDetailsState extends State<CarrerDetail> {
  final CarrerBloc _newsBloc = CarrerBloc();

  @override
  void initState() {
    _newsBloc.add(GetCarrerList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  Widget buildList() {
    return BlocProvider(
      create: (_) => _newsBloc,
      child: BlocListener<CarrerBloc, CarrerState>(
        listener: (context, state) {
          if (state is CarrerFail) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<CarrerBloc, CarrerState>(
          builder: (context, state) {
            if (state is CarrerInitial) {
              return buildLoading();
            }
            if (state is GetCarrerSuccess) {
              List carrers = state.carrers;

              var year;
              var month;
              for (int i = 0; i < carrers[0].educations.length; i++) {
                if (carrers[0].educations[i]['from_year'] != null) {
                  year = 1920 + carrers[0].educations[i]['from_year'];
                  carrers[0].educations[i]['from_year'] = year;
                }
                if (carrers[0].educations[i]['from_month'] != null) {
                  month = 12 + carrers[0].educations[i]['from_month'];
                  carrers[0].educations[i]['from_month'] = month;
                }
                if (carrers[0].educations[i]['to_year'] != null) {
                  year = 1920 + carrers[0].educations[i]['to_year'];
                  carrers[0].educations[i]['to_year'] = year;
                }
                if (carrers[0].educations[i]['to_month'] != null) {
                  month = 12 + carrers[0].educations[i]['to_month'];
                  carrers[0].educations[i]['to_month'] = month;
                }
              }
              for (int i = 0; i < carrers[0].experiences.length; i++) {
                if (carrers[0].experiences[i]['from_year'] != null) {
                  year = 1920 + carrers[0].experiences[i]['from_year'];
                  carrers[0].experiences[i]['from_year'] = year;
                }
                if (carrers[0].experiences[i]['from_month'] != null) {
                  month = 12 + carrers[0].experiences[i]['from_month'];
                  carrers[0].experiences[i]['from_month'] = month;
                }
                if (carrers[0].experiences[i]['to_year'] != null) {
                  year = 1920 + carrers[0].experiences[i]['to_year'];
                  carrers[0].experiences[i]['to_year'] = year;
                }
                if (carrers[0].experiences[i]['to_month'] != null) {
                  month = 12 + carrers[0].experiences[i]['to_month'];
                  carrers[0].experiences[i]['to_month'] = month;
                }
              }
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, position) {
                    return item(carrers, context);
                  });
            } else if (state is CarrerFail) {
              return Center(child: CupertinoActivityIndicator());
            }
            return buildLoading();
          },
        ),
      ),
    );
    // );
    // ])
    // );
  }
}
