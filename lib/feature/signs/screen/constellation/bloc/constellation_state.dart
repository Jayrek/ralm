part of 'constellation_bloc.dart';

class ConstellationState extends Equatable {
  const ConstellationState({
    this.zodiacs = const [],
    this.selectedZodiacIndex = 0,
  });

  final List<Zodiac> zodiacs;
  final int selectedZodiacIndex;

  @override
  List<Object> get props => [zodiacs, selectedZodiacIndex];

  ConstellationState copyWith({
    List<Zodiac>? zodiacs,
    int? selectedZodiacIndex,
  }) {
    return ConstellationState(
      zodiacs: zodiacs ?? this.zodiacs,
      selectedZodiacIndex: selectedZodiacIndex ?? this.selectedZodiacIndex,
    );
  }
}
