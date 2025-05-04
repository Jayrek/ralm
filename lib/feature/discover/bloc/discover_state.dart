part of 'discover_bloc.dart';

class DiscoverState extends Equatable {
  const DiscoverState({
    this.userName = '',
    this.bday = '',
    this.constellation = '',
    this.chineseZodiac = '',
  });

  final String userName;
  final String bday;
  final String constellation;
  final String chineseZodiac;
  @override
  List<Object> get props => [userName, bday, constellation, chineseZodiac];

  DiscoverState copyWith({
    String? userName,
    String? bday,
    String? constellation,
    String? chineseZodiac,
  }) {
    return DiscoverState(
      userName: userName ?? this.userName,
      bday: bday ?? this.bday,
      constellation: constellation ?? this.constellation,
      chineseZodiac: chineseZodiac ?? this.chineseZodiac,
    );
  }
}
