part of 'ideal_type_bloc.dart';

class IdealTypeState extends Equatable {
  const IdealTypeState({this.idealTypeList = const []});

  final List<IdealType> idealTypeList;

  @override
  List<Object> get props => [idealTypeList];

  IdealTypeState copyWith({List<IdealType>? idealTypeList}) {
    return IdealTypeState(idealTypeList: idealTypeList ?? this.idealTypeList);
  }
}
