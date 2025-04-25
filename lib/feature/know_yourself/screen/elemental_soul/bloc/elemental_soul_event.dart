part of 'elemental_soul_bloc.dart';

sealed class ElementalSoulEvent extends Equatable {
  const ElementalSoulEvent();

  @override
  List<Object> get props => [];
}

class FetchElementalSoulQuestion extends ElementalSoulEvent {
  const FetchElementalSoulQuestion();
}

class SelectElementalSoulOption extends ElementalSoulEvent {
  const SelectElementalSoulOption({required this.option});

  final Option option;

  @override
  List<Object> get props => [option];
}

class ResetElementalSoulQuestion extends ElementalSoulEvent {
  const ResetElementalSoulQuestion();
}

class SaveAvatarElementalSoul extends ElementalSoulEvent {
  const SaveAvatarElementalSoul();
}

class RemoveAvatarElementalSoul extends ElementalSoulEvent {
  const RemoveAvatarElementalSoul();
}

class GetAvatarElementalSoul extends ElementalSoulEvent {
  const GetAvatarElementalSoul();
}
