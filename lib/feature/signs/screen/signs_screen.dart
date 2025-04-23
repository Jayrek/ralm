import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/signs/bloc/signs_bloc.dart';
import 'package:ralm/models/avatar.dart';

import '../../../core/shared/widget/custom_button_icon_widget.dart';
import '../../../core/shared/widget/custom_button_rounded_widget.dart';
import '../../../core/shared/widget/custom_sub_category_widget.dart';

class SignsScreen extends StatelessWidget {
  const SignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SignsBloc>().add(FetchSignsCategory());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CustomButtonRoundedWidget(
                        label: 'Signs',
                        onPressed: null,
                      ),
                      CustomButtonIconWidget(
                        icon: Icon(Icons.arrow_circle_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
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
                                  description: sign.categoryDescription,
                                  onPressed: () {
                                    // TODO: e review ni balik
                                    switch (sign.id) {
                                      case 0:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navChineseZodiac,
                                        );
                                      case 1:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navConstellationZodiac,
                                        );
                                      case 2:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navDreamSign,
                                        );
                                      case 3:
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navSecretCrush,
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
                        Navigator.pushNamed(context, StringConstant.navAvatar);
                      },
                      child: BlocSelector<AvatarBloc, AvatarState, Avatar>(
                        selector: (state) => state.defaultAvatar,
                        builder: (context, avatar) {
                          return Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 3),
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
    );
  }
}
