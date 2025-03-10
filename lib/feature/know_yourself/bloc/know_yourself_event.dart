part of 'know_yourself_bloc.dart';

sealed class KnowYourselfEvent extends Equatable {
  const KnowYourselfEvent();

  @override
  List<Object> get props => [];
}

class FetchKnowYourselfCategory extends KnowYourselfEvent {
  const FetchKnowYourselfCategory();
}
