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
  const SelectedChineseZodiac({
    required this.year,
    this.notYear = false,
    this.isFromDiscover = false,
  });

  final int year;
  final bool notYear;
  final bool isFromDiscover;

  @override
  List<Object> get props => [year, notYear, isFromDiscover];
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

// zodiac
class SaveDiscoverZodiac extends ChineseZodiacEvent {
  const SaveDiscoverZodiac({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class GetDiscoverZodiac extends ChineseZodiacEvent {
  const GetDiscoverZodiac();
}

class RemoveDiscoverZodiac extends ChineseZodiacEvent {
  const RemoveDiscoverZodiac();
}
