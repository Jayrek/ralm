part of 'chinese_zodiac_bloc.dart';

sealed class ChineseZodiacEvent extends Equatable {
  const ChineseZodiacEvent();

  @override
  List<Object> get props => [];
}

class FetchChineseZodiac extends ChineseZodiacEvent {
  const FetchChineseZodiac();
}

class SelectedChineseZodiac extends ChineseZodiacEvent {
  const SelectedChineseZodiac({required this.year, this.notYear = false});

  final int year;
  final bool notYear;

  @override
  List<Object> get props => [year, notYear];
}

class SaveAvatarChineseZodiac extends ChineseZodiacEvent {
  const SaveAvatarChineseZodiac({required this.name});
  final String name;
  @override
  List<Object> get props => [name];
}

class RemoveAvatarChineseZodiac extends ChineseZodiacEvent {
  const RemoveAvatarChineseZodiac();
}

class GetAvatarChineseZodiac extends ChineseZodiacEvent {
  const GetAvatarChineseZodiac();
}
