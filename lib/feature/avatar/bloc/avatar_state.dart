part of 'avatar_bloc.dart';

class AvatarState extends Equatable {
  const AvatarState({
    this.avatars = const [],
    this.defaultAvatar = const Avatar(
      id: 1,
      category: 'one_avatar',
      image: '',
      isSelected: true,
      isLocked: false,
    ),
  });

  final List<Avatar> avatars;
  final Avatar defaultAvatar;

  @override
  List<Object> get props => [avatars, defaultAvatar];

  AvatarState copyWith({
    final List<Avatar>? avatars,
    final Avatar? defaultAvatar,
  }) {
    return AvatarState(
      avatars: avatars ?? this.avatars,
      defaultAvatar: defaultAvatar ?? this.defaultAvatar,
    );
  }
}
