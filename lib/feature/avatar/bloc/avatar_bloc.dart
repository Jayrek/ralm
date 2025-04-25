import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/core/util/avatar_shared_util.dart';
import 'package:ralm/models/avatar.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(AvatarState()) {
    on<FetchAvatars>((event, emit) async {
      final avatars = await AvatarSharedUtil.loadAvatars();
      final selectedAvatar = avatars.firstWhere((avatar) => avatar.isSelected);
      emit(state.copyWith(avatars: avatars, defaultAvatar: selectedAvatar));
    });

    on<UnlockAvatar>((event, emit) async {
      final avatars = await AvatarSharedUtil.loadAvatars();
      final updated =
          avatars.map((a) {
            return a.id == event.id ? a.copyWith(isLocked: false) : a;
          }).toList();

      await AvatarSharedUtil.saveAvatars(updated);
      emit(state.copyWith(avatars: updated));
    });

    on<SetDefaultAvatar>((event, emit) async {
      final avatars = await AvatarSharedUtil.loadAvatars();
      final updatedAvatars =
          avatars.map((a) {
            return a.copyWith(isSelected: a.id == event.id);
          }).toList();

      await AvatarSharedUtil.saveAvatars(updatedAvatars);
      final defaultAvatar =
          updatedAvatars.where((avatar) => avatar.isSelected == true).first;
      emit(
        state.copyWith(avatars: updatedAvatars, defaultAvatar: defaultAvatar),
      );
    });
    on<CheckAvatarUnlocked>((event, emit) async {
      final avatars = await AvatarSharedUtil.loadAvatars();
      final avatar = avatars.firstWhere((avatar) => avatar.id == event.id);

      if (!avatar.isLocked) {
        // Avatar is unlocked
        emit(state.copyWith(isAvatarUnlocked: true));
      } else {
        // Avatar is locked or not found
        emit(state.copyWith(isAvatarUnlocked: false));
      }
    });
  }
}
