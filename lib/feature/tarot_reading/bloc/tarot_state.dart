part of 'tarot_bloc.dart';

class TarotState extends Equatable {
  const TarotState({this.tarots = const [], this.selectedIndex = 0});

  final List<Tarot> tarots;
  final int selectedIndex;

  @override
  List<Object> get props => [tarots, selectedIndex];

  TarotState copyWith({List<Tarot>? tarots, int? selectedIndex}) {
    return TarotState(
      tarots: tarots ?? this.tarots,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
