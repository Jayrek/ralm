part of 'dream_sign_bloc.dart';

class DreamSignState extends Equatable {
  const DreamSignState({
    this.dreamSignDetailList = const [],
    this.dreamSignCategory = '',
  });

  final List<DreamSign> dreamSignDetailList;
  final String dreamSignCategory;

  @override
  List<Object> get props => [dreamSignDetailList, dreamSignCategory];

  DreamSignState copyWith({
    List<DreamSign>? dreamSignDetailList,
    String? dreamSignCategory,
  }) {
    return DreamSignState(
      dreamSignDetailList: dreamSignDetailList ?? this.dreamSignDetailList,
      dreamSignCategory: dreamSignCategory ?? this.dreamSignCategory,
    );
  }
}
