part of 'forest_test_bloc.dart';

class ForestTestState extends Equatable {
  const ForestTestState({
    this.forestTestResults = const [],
    this.avatarUnLocked = 'No',
  });

  final List<ForestTest> forestTestResults;
  final String avatarUnLocked;

  @override
  List<Object> get props => [forestTestResults, avatarUnLocked];

  ForestTestState copyWith({
    List<ForestTest>? forestTestResults,
    String? avatarUnLocked,
  }) {
    return ForestTestState(
      forestTestResults: forestTestResults ?? this.forestTestResults,
      avatarUnLocked: avatarUnLocked ?? this.avatarUnLocked,
    );
  }
}
