part of 'tarot_bloc.dart';

sealed class TarotEvent extends Equatable {
  const TarotEvent();

  @override
  List<Object> get props => [];
}

class FetchTarotCards extends TarotEvent {
  const FetchTarotCards({this.isShuffle = false});
  final bool isShuffle;

  @override
  List<Object> get props => [isShuffle];
}

class SelectedTarot extends TarotEvent {
  const SelectedTarot({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class PickedTarot extends TarotEvent {
  const PickedTarot({required this.tarot});

  final Tarot tarot;

  @override
  List<Object> get props => [tarot];
}

class ResetPickingTarot extends TarotEvent {
  const ResetPickingTarot();
}
