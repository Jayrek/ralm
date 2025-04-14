part of 'forest_test_bloc.dart';

sealed class ForestTestEvent extends Equatable {
  const ForestTestEvent();

  @override
  List<Object> get props => [];
}

class FetchForestTestResult extends ForestTestEvent {
  const FetchForestTestResult();
}
