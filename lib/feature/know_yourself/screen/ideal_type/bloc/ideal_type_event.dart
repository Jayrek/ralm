part of 'ideal_type_bloc.dart';

sealed class IdealTypeEvent extends Equatable {
  const IdealTypeEvent();

  @override
  List<Object> get props => [];
}

class FetchIdealType extends IdealTypeEvent {
  const FetchIdealType({required this.gender});

  final String gender;

  @override
  List<Object> get props => [gender];
}
