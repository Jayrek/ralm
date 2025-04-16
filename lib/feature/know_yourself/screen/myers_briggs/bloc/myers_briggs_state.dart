part of 'myers_briggs_bloc.dart';

class MyersBriggsState extends Equatable {
  const MyersBriggsState({this.myersBriggsList = const []});

  final List<MyersBriggs> myersBriggsList;

  @override
  List<Object> get props => [myersBriggsList];

  MyersBriggsState copyWith({List<MyersBriggs>? myersBriggsList}) {
    return MyersBriggsState(
      myersBriggsList: myersBriggsList ?? this.myersBriggsList,
    );
  }
}
