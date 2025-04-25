part of 'avatar_bloc.dart';

class AvatarState extends Equatable {
  const AvatarState({
    this.avatars = const [],
    this.defaultAvatar = const Avatar(
      id: 1,
      category: 'default_1',
      image: 'assets/image/avatar/Default_1.png',
      isSelected: true,
      isLocked: false,
    ),
    this.isAvatarUnlocked = false,
  });

  final List<Avatar> avatars;
  final Avatar defaultAvatar;
  final bool isAvatarUnlocked;

  @override
  List<Object> get props => [avatars, defaultAvatar, isAvatarUnlocked];

  AvatarState copyWith({
    final List<Avatar>? avatars,
    final Avatar? defaultAvatar,
    final bool? isAvatarUnlocked,
  }) {
    return AvatarState(
      avatars: avatars ?? this.avatars,
      defaultAvatar: defaultAvatar ?? this.defaultAvatar,
      isAvatarUnlocked: isAvatarUnlocked ?? this.isAvatarUnlocked,
    );
  }
}
