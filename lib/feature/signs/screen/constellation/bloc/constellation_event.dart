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
  final bool isFromDiscover;

  const SelectedConstellationZodiac({
    required this.selectedDate,
    this.isFromDiscover = false,
  });
  // const SelectedConstellationZodiac({required this.dateRange});

  // final String dateRange;

  // @override
  List<Object> get props => [selectedDate, isFromDiscover];
}

class SelectedConstellationIndividualZodiac extends ConstellationEvent {
  const SelectedConstellationIndividualZodiac({required this.dateRange});

  final String dateRange;

  @override
  List<Object> get props => [dateRange];
}

class SaveAvatarContestllation extends ConstellationEvent {
  const SaveAvatarContestllation({required this.date});
  final String date;
  @override
  List<Object> get props => [date];
}

class RemoveAvatarContestllation extends ConstellationEvent {
  const RemoveAvatarContestllation();
}

class GetAvatarContestllation extends ConstellationEvent {
  const GetAvatarContestllation();
}

// constellation
class SaveDiscoverConstellation extends ConstellationEvent {
  const SaveDiscoverConstellation({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class GetDiscoverConstellation extends ConstellationEvent {
  const GetDiscoverConstellation();
}

class RemoveDiscoverConstellation extends ConstellationEvent {
  const RemoveDiscoverConstellation();
}
