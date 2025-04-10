part of 'avatar_bloc.dart';

class AvatarState extends Equatable {
  const AvatarState({
    this.avatarFromJson = const [],
    this.avatarFromShared = const [],
  });

  final List<Avatar> avatarFromJson;
  final List<Avatar> avatarFromShared;

  @override
  List<Object> get props => [avatarFromJson, avatarFromShared];

  AvatarState copyWith({
    final List<Avatar>? avatarFromJson,
    final List<Avatar>? avatarFromShared,
  }) {
    return AvatarState(
      avatarFromJson: avatarFromJson ?? this.avatarFromJson,
      avatarFromShared: avatarFromShared ?? this.avatarFromShared,
    );
  }
}
