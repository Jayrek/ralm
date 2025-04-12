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
      emit(state.copyWith(avatars: avatars));
      // String jsonString = await rootBundle.loadString(
      //   'assets/json/avatar.json',
      // );
      // final avatarMapList = jsonDecode(jsonString) as List;
      // final avatarList =
      //     avatarMapList.map((category) => Avatar.fromJson(category)).toList();
      // emit(state.copyWith(avatarFromJson: avatarList));
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

      // final updated =
      //     avatars.map((a) {
      //       return a.id == event.id ? a.copyWith(isSelected: true) : a;
      //     }).toList();

      await AvatarSharedUtil.saveAvatars(updatedAvatars);
      final defaultAvatar =
          updatedAvatars.where((avatar) => avatar.isSelected == true).first;
      emit(
        state.copyWith(avatars: updatedAvatars, defaultAvatar: defaultAvatar),
      );
    });
  }
}
