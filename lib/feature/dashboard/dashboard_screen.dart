import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:ralm/models/avatar.dart';
import 'package:video_player/video_player.dart';

import '../../core/shared/widget/custom_button_icon_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
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
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'R',
                              style: Theme.of(
                                context,
                              ).textTheme.displayLarge?.copyWith(fontSize: 120),
                            ),
                            Text(
                              ' ALM',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontSize: 50,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          StringConstant.discoverYourself.toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge?.copyWith(
                            fontFamily: StringConstant.fontTinos,
                            fontSize: 20,
                            fontWeight: FontWeight.w100,
                            letterSpacing: 10,
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          children:
                              state.categories.map((category) {
                                return CustomButtonRoundedWidget(
                                  label: category.categoryName,
                                  onPressed: () {
                                    // TODO: e review ni balik
                                    switch (category.id) {
                                      case 0:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navKnowYourScreenKey,
                                        );
                                      case 1:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navSignsScreenKey,
                                        );
                                      case 2:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navTarotScreenKey,
                                        );
                                      case 3:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navDiscoverScreenKey,
                                        );
                                      default:
                                        debugPrint('no action');
                                    }
                                  },
                                );
                              }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButtonIconWidget(
                              icon: Icon(Icons.music_note),
                              onPressed: () {},
                            ),
                            CustomButtonIconWidget(
                              icon: Icon(Icons.logout),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    // this is the avatar
                    Positioned(
                      top: 20,
                      right: 10,
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
                            child:
                                BlocSelector<AvatarBloc, AvatarState, Avatar>(
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
                                        backgroundImage: AssetImage(
                                          avatar.image,
                                        ),
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
            ],
          ),
        );
      },
    );
  }
}
