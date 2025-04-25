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
  const FetchPersonalitiesById({required this.name});

  final String name;
  @override
  List<Object> get props => [name];
}

class SaveMyersBriggesResult extends MyersBriggsEvent {
  const SaveMyersBriggesResult({required this.result});

  final String result;

  @override
  List<Object> get props => [result];
}

class RemoveMyersBriggesResult extends MyersBriggsEvent {}

class GetMyersBriggesResult extends MyersBriggsEvent {}
