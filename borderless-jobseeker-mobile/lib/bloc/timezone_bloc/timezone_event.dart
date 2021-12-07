part of 'timezone_bloc.dart';

abstract class TimezoneEvent extends Equatable {
  const TimezoneEvent();

  @override
  List<Object> get props => [];
}

class GetUserTimeZone extends TimezoneEvent {
  @override
  List<Object> get props => [];
}

class ChangeTimezoneButtonPressed extends TimezoneEvent {
  final String changeTimezone, changeOffset;

  ChangeTimezoneButtonPressed(this.changeTimezone, this.changeOffset);
  @override
  List<Object> get props => [];
}