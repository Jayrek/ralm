part of 'discover_bloc.dart';

sealed class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

//name
class SaveDiscoverUserName extends DiscoverEvent {
  const SaveDiscoverUserName({required this.name});
  final String name;

  @override
  List<Object> get props => [name];
}

class GetDiscoverUserName extends DiscoverEvent {
  const GetDiscoverUserName();
}

class RemoveDiscoverUserName extends DiscoverEvent {
  const RemoveDiscoverUserName();
}

// bday
class SaveZodiacFromBDate extends DiscoverEvent {
  const SaveZodiacFromBDate({required this.bday});
  final String bday;

  @override
  List<Object> get props => [bday];
}

class GetZodiacFromBDate extends DiscoverEvent {
  const GetZodiacFromBDate();
}

class RemoveZodiacFromBDate extends DiscoverEvent {
  const RemoveZodiacFromBDate();
}

// // constellation
// class SaveDiscoverConstellation extends DiscoverEvent {
//   const SaveDiscoverConstellation({required this.name});
//   final String name;

//   @override
//   List<Object> get props => [name];
// }

// class GetDiscoverConstellation extends DiscoverEvent {
//   const GetDiscoverConstellation();
// }

// class RemoveDiscoverConstellation extends DiscoverEvent {
//   const RemoveDiscoverConstellation();
// }

// // zodiac
// class SaveDiscoverZodiac extends DiscoverEvent {
//   const SaveDiscoverZodiac({required this.name});
//   final String name;

//   @override
//   List<Object> get props => [name];
// }

// class GetDiscoverZodiac extends DiscoverEvent {
//   const GetDiscoverZodiac();
// }

// class RemoveDiscoverZodiac extends DiscoverEvent {
//   const RemoveDiscoverZodiac();
// }
