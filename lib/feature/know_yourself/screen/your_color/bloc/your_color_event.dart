part of 'your_color_bloc.dart';

sealed class YourColorEvent extends Equatable {
  const YourColorEvent();

  @override
  List<Object> get props => [];
}

class FetchYourColorQuestion extends YourColorEvent {
  const FetchYourColorQuestion();
}

class SelectYourColorOption extends YourColorEvent {
  const SelectYourColorOption({required this.option});

  final Option option;

  @override
  List<Object> get props => [option];
}

class ResetYourColorQuestion extends YourColorEvent {
  const ResetYourColorQuestion();
}

class SaveAvatarYourColor extends YourColorEvent {
  const SaveAvatarYourColor({required this.color});
  final String color;

  @override
  List<Object> get props => [color];
}

class RemoveAvatarYourColor extends YourColorEvent {
  const RemoveAvatarYourColor();
}

class GetAvatarYourColor extends YourColorEvent {
  const GetAvatarYourColor();
}
