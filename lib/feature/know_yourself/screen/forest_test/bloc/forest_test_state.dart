part of 'forest_test_bloc.dart';

class ForestTestState extends Equatable {
  const ForestTestState({this.forestTestResults = const []});

  final List<ForestTest> forestTestResults;

  @override
  List<Object> get props => [forestTestResults];

  ForestTestState copyWith({List<ForestTest>? forestTestResults}) {
    return ForestTestState(
      forestTestResults: forestTestResults ?? this.forestTestResults,
    );
  }
}
