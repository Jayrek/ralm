part of 'myers_briggs_bloc.dart';

sealed class MyersBriggsEvent extends Equatable {
  const MyersBriggsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyersBriggsQuestions extends MyersBriggsEvent {
  const FetchMyersBriggsQuestions();
}

class SelectMyersBriggsOption extends MyersBriggsEvent {
  const SelectMyersBriggsOption({
    required this.questionId,
    required this.selectedOption,
  });
  final int questionId;
  final MyersBriggsOption selectedOption;

  @override
  List<Object> get props => [questionId, selectedOption];
}

class ClearMyersBriggsProgress extends MyersBriggsEvent {
  const ClearMyersBriggsProgress();
}

class FetchPersonalities extends MyersBriggsEvent {
  const FetchPersonalities();
}

class FetchPersonalitiesById extends MyersBriggsEvent {
  const FetchPersonalitiesById({required this.id});

  final int id; // result
  @override
  List<Object> get props => [id];
}
