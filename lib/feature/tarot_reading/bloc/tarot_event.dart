part of 'tarot_bloc.dart';

sealed class TarotEvent extends Equatable {
  const TarotEvent();

  @override
  List<Object> get props => [];
}

class FetchTarotCards extends TarotEvent {}

class SelectedCTarot extends TarotEvent {
  const SelectedCTarot({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}
