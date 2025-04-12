part of 'dream_sign_bloc.dart';

sealed class DreamSignEvent extends Equatable {
  const DreamSignEvent();

  @override
  List<Object> get props => [];
}

class FetchDreamSignDetail extends DreamSignEvent {
  const FetchDreamSignDetail({required this.dreamSignCategory});

  final String dreamSignCategory;

  @override
  List<Object> get props => [dreamSignCategory];
}
