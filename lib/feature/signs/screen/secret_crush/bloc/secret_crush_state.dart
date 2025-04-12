part of 'secret_crush_bloc.dart';

class SecretCrushState extends Equatable {
  const SecretCrushState({this.secretCrushList = const []});

  final List<DreamSign> secretCrushList;

  @override
  List<Object> get props => [secretCrushList];

  SecretCrushState copyWith({List<DreamSign>? secretCrushList}) {
    return SecretCrushState(
      secretCrushList: secretCrushList ?? this.secretCrushList,
    );
  }
}
