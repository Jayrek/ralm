part of 'forest_test_bloc.dart';

sealed class ForestTestEvent extends Equatable {
  const ForestTestEvent();

  @override
  List<Object> get props => [];
}

class FetchForestTestResult extends ForestTestEvent {
  const FetchForestTestResult();
}

class SaveAvatarForestTest extends ForestTestEvent {
  const SaveAvatarForestTest();
}

class RemoveAvatarForestTest extends ForestTestEvent {}

class GetAvatarForestTest extends ForestTestEvent {}
