part of 'tarot_bloc.dart';

class TarotState extends Equatable {
  const TarotState({
    this.tarots = const [],
    this.pickedTarots = const [],
    this.selectedIndex = 0,
    this.pickingTries = 0,
  });

  final List<Tarot> tarots;
  final List<Tarot> pickedTarots;
  final int selectedIndex;
  final int pickingTries;

  @override
  List<Object> get props => [tarots, pickedTarots, selectedIndex, pickingTries];

  TarotState copyWith({
    List<Tarot>? tarots,
    List<Tarot>? pickedTarots,
    int? selectedIndex,
    int? pickingTries,
  }) {
    return TarotState(
      tarots: tarots ?? this.tarots,
      pickedTarots: pickedTarots ?? this.pickedTarots,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pickingTries: pickingTries ?? this.pickingTries,
    );
  }
}
