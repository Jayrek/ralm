part of 'avatar_bloc.dart';

sealed class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

class FetchAvatars extends AvatarEvent {
  const FetchAvatars();
}

class UnlockAvatar extends AvatarEvent {
  const UnlockAvatar(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

class SetDefaultAvatar extends AvatarEvent {
  const SetDefaultAvatar(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}
