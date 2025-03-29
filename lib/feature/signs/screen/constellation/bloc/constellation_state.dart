part of 'constellation_bloc.dart';

class ConstellationState extends Equatable {
  const ConstellationState({this.zodiacs = const []});

  final List<Zodiac> zodiacs;

  @override
  List<Object> get props => [zodiacs];

  ConstellationState copyWith({List<Zodiac>? zodiacs}) {
    return ConstellationState(zodiacs: zodiacs ?? this.zodiacs);
  }
}
