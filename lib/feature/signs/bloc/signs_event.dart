part of 'signs_bloc.dart';

sealed class SignsEvent extends Equatable {
  const SignsEvent();

  @override
  List<Object> get props => [];
}

class FetchSignsCategory extends SignsEvent {
  const FetchSignsCategory();
}
