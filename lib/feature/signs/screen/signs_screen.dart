import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/signs/bloc/signs_bloc.dart';
import 'package:ralm/models/avatar.dart';
import 'package:video_player/video_player.dart';

import '../../../core/shared/widget/custom_button_icon_widget.dart';
import '../../../core/shared/widget/custom_button_rounded_widget.dart';
import '../../../core/shared/widget/custom_sub_category_widget.dart';

class SignsScreen extends StatefulWidget {
  const SignsScreen({super.key});

  @override
  State<SignsScreen> createState() => _SignsScreenState();
}

class _SignsScreenState extends State<SignsScreen> {
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
    context.read<SignsBloc>().add(FetchSignsCategory());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg/signs_bg/new_bg_signs.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Stack(
              children: [
                // if (_videoController.value.isInitialized)
                //   SizedBox.expand(
                //     child: FittedBox(
                //       fit: BoxFit.cover,
                //       child: SizedBox(
                //         width: _videoController.value.size.width,
                //         height: _videoController.value.size.height,
                //         child: VideoPlayer(_videoController),
                //       ),
                //     ),
                //   ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // Row(
                            //   children: [
                            //     CustomButtonRoundedWidget(
                            //       label: 'Signs',
                            //       onPressed: null,
                            //     ),
                            //     CustomButtonIconWidget(
                            //       icon: Icon(Icons.arrow_circle_left),
                            //       onPressed: () => Navigator.of(context).pop(),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // CustomButtonRoundedWidget(
                                //   label: 'Know Yourself',
                                //   onPressed: null,
                                // ),
                                CustomButtonIconWidget(
                                  icon: Icon(Icons.arrow_circle_left),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                Text(
                                  'Signs'.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 40,
                                  ),
                                ),
                                Text(''),
                              ],
                            ),
                            SizedBox(height: 20),
                            BlocBuilder<SignsBloc, SignsState>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    children:
                                        state.signs.map((sign) {
                                          return CustomSubCategoryWidget(
                                            name: sign.categoryName,
                                            description:
                                                sign.categoryDescription,
                                            onPressed: () {
                                              // TODO: e review ni balik
                                              switch (sign.id) {
                                                case 0:
                                                  Navigator.pushNamed(
                                                    context,
                                                    StringConstant
                                                        .navChineseZodiac,
                                                  );
                                                case 1:
                                                  Navigator.pushNamed(
                                                    context,
                                                    StringConstant
                                                        .navConstellationZodiac,
                                                  );
                                                case 2:
                                                  Navigator.pushNamed(
                                                    context,
                                                    StringConstant.navDreamSign,
                                                  );
                                                case 3:
                                                  Navigator.pushNamed(
                                                    context,
                                                    StringConstant
                                                        .navSecretCrush,
                                                  );
                                                default:
                                                  debugPrint('no action');
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
                                child: BlocSelector<
                                  AvatarBloc,
                                  AvatarState,
                                  Avatar
                                >(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
