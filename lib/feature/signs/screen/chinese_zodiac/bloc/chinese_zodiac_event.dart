part of 'chinese_zodiac_bloc.dart';

sealed class ChineseZodiacEvent extends Equatable {
  const ChineseZodiacEvent();

  @override
  List<Object> get props => [];
}

class FetchChineseZodiac extends ChineseZodiacEvent {
  const FetchChineseZodiac();
}
