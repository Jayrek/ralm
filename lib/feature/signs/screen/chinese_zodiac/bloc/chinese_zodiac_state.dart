part of 'chinese_zodiac_bloc.dart';

class ChineseZodiacState extends Equatable {
  const ChineseZodiacState({this.zodiacs = const []});

  final List<ChineseZodiac> zodiacs;

  @override
  List<Object> get props => [zodiacs];

  ChineseZodiacState copyWith({final List<ChineseZodiac>? zodiacs}) {
    return ChineseZodiacState(zodiacs: zodiacs ?? this.zodiacs);
  }
}
