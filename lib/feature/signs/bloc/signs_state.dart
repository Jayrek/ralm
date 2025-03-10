part of 'signs_bloc.dart';

class SignsState extends Equatable {
  const SignsState({this.signs = const []});

  final List<SubCategory> signs;

  @override
  List<Object> get props => [signs];

  SignsState copyWith({List<SubCategory>? signs}) {
    return SignsState(signs: signs ?? this.signs);
  }
}
