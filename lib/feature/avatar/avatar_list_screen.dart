import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';

class AvatarListScreen extends StatelessWidget {
  const AvatarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AvatarBloc>().add(FetchAvatars());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: BlocBuilder<AvatarBloc, AvatarState>(
        builder: (context, state) {
          final avatars = state.avatarFromJson;
          return Wrap(
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children:
                avatars.map((avatar) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        if (avatar.isLocked) {
                          debugPrint('unlocked this avatar first');
                          // context.read<AvatarBloc>().add(
                          //   UnlockAvatar(avatar.id),
                          // );
                        } else {
                          context.read<AvatarBloc>().add(
                            SetDefaultAvatar(avatar.id),
                          );
                          debugPrint('select new default avatar: $avatar');
                        }
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            avatar.isLocked ? Colors.grey : Colors.transparent,
                        child:
                            avatar.isLocked
                                ? SizedBox()
                                : Text(avatar.category.substring(0, 1)),
                      ),
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}
