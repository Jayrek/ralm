part of 'myers_briggs_bloc.dart';

sealed class MyersBriggsEvent extends Equatable {
  const MyersBriggsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyersBriggsQuestions extends MyersBriggsEvent {
  const FetchMyersBriggsQuestions();
}
