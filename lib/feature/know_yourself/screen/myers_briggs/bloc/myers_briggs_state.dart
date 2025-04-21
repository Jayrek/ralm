part of 'myers_briggs_bloc.dart';

class MyersBriggsState extends Equatable {
  const MyersBriggsState({
    this.myersBriggsList = const [],
    this.personalities = const [],
    this.personality,
  });

  final List<MyersBriggs> myersBriggsList;
  final List<Personalities> personalities;
  final Personalities? personality;

  @override
  List<Object?> get props => [myersBriggsList, personalities, personality];

  MyersBriggsState copyWith({
    List<MyersBriggs>? myersBriggsList,
    List<Personalities>? personalities,
    Personalities? personality,
  }) {
    return MyersBriggsState(
      myersBriggsList: myersBriggsList ?? this.myersBriggsList,
      personalities: personalities ?? this.personalities,
      personality: personality ?? this.personality,
    );
  }
}
