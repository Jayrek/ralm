part of 'constellation_bloc.dart';

sealed class ConstellationEvent extends Equatable {
  const ConstellationEvent();

  @override
  List<Object> get props => [];
}

class FetchConstellationZodiac extends ConstellationEvent {
  const FetchConstellationZodiac();
}

class SelectedConstellationZodiac extends ConstellationEvent {
  final DateTime selectedDate;

  const SelectedConstellationZodiac(this.selectedDate);
  // const SelectedConstellationZodiac({required this.dateRange});

  // final String dateRange;

  // @override
  List<Object> get props => [selectedDate];
}

class SelectedConstellationIndividualZodiac extends ConstellationEvent {
  const SelectedConstellationIndividualZodiac({required this.dateRange});

  final String dateRange;

  // @override
  List<Object> get props => [dateRange];
}
