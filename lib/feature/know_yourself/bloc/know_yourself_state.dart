part of 'know_yourself_bloc.dart';

class KnowYourselfState extends Equatable {
  const KnowYourselfState({this.subCategories = const []});

  final List<SubCategory> subCategories;

  @override
  List<Object> get props => [subCategories];

  KnowYourselfState copyWith({final List<SubCategory>? subCategories}) {
    return KnowYourselfState(
      subCategories: subCategories ?? this.subCategories,
    );
  }
}
