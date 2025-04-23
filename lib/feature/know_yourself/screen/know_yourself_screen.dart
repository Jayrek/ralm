import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/know_yourself/bloc/know_yourself_bloc.dart';
import 'package:ralm/models/avatar.dart';
import 'package:video_player/video_player.dart';

import '../../../core/shared/widget/custom_button_rounded_widget.dart';
import '../../../core/shared/widget/custom_sub_category_widget.dart';

class KnowYourSelfScreen extends StatefulWidget {
  const KnowYourSelfScreen({super.key});

  @override
  State<KnowYourSelfScreen> createState() => _KnowYourSelfScreenState();
}

class _KnowYourSelfScreenState extends State<KnowYourSelfScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
        'assets/bg/dashboard_bg/main_menu_bg.mp4',
      )
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<KnowYourselfBloc>().add(FetchKnowYourselfCategory());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        children: [
          if (_videoController.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CustomButtonRoundedWidget(
                            label: 'Know Yourself',
                            onPressed: null,
                          ),
                          CustomButtonIconWidget(
                            icon: Icon(Icons.arrow_circle_left),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<KnowYourselfBloc, KnowYourselfState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Column(
                              children:
                                  state.subCategories.map((subCategory) {
                                    return CustomSubCategoryWidget(
                                      name: subCategory.categoryName,
                                      description:
                                          subCategory.categoryDescription,
                                      onPressed: () {
                                        switch (subCategory.id) {
                                          case 0:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant
                                                  .navMyersBriggsIntro,
                                            );
                                          case 1:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant.navForestTest,
                                            );
                                          case 2:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant.navElementalSoul,
                                            );
                                          case 3:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant.navYourColor,
                                            );
                                          case 4:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant.navRandomTest,
                                            );

                                          case 5:
                                            Navigator.pushNamed(
                                              context,
                                              StringConstant.navIdealTYpeIntro,
                                            );
                                        }
                                      },
                                    );
                                  }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Material(
                        elevation: 5,
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              StringConstant.navAvatar,
                            );
                          },
                          child: BlocSelector<AvatarBloc, AvatarState, Avatar>(
                            selector: (state) => state.defaultAvatar,
                            builder: (context, avatar) {
                              return Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(avatar.image),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
