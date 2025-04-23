import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';

class AvatarListScreen extends StatelessWidget {
  const AvatarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AvatarBloc>().add(FetchAvatars());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomButtonIconWidget(
                  icon: Icon(Icons.arrow_circle_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              BlocBuilder<AvatarBloc, AvatarState>(
                builder: (context, state) {
                  final avatars = state.avatars;
                  return Wrap(
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children:
                        avatars.map((avatar) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                              elevation: 5,
                              shape: CircleBorder(),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.transparent,
                              child: InkWell(
                                customBorder: CircleBorder(),
                                onTap: () {
                                  if (avatar.isLocked) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Avatar is locked!'),
                                      ),
                                    );
                                    debugPrint('unlocked this avatar first');
                                    // context.read<AvatarBloc>().add(
                                    //   UnlockAvatar(avatar.id),
                                    // );
                                  } else {
                                    context.read<AvatarBloc>().add(
                                      SetDefaultAvatar(avatar.id),
                                    );
                                    debugPrint(
                                      'select new default avatar: $avatar',
                                    );
                                    // Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color:
                                          avatar.isSelected
                                              ? Colors.blue
                                              : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        avatar.isLocked
                                            ? Colors.black12
                                            : Colors.transparent,
                                    // backgroundImage: AssetImage(
                                    //   avatar.image,
                                    // ),
                                    backgroundImage:
                                        avatar.isLocked
                                            ? null
                                            : AssetImage(avatar.image),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
