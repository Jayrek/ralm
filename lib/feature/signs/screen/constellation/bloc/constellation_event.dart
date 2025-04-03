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
  const SelectedConstellationZodiac({required this.dateRange});

  final String dateRange;

  @override
  List<Object> get props => [dateRange];
}
