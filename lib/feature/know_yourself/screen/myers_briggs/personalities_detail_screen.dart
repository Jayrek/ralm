import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/dialog/dialog_utils.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class PersonalitiesDetailScreen extends StatefulWidget {
  const PersonalitiesDetailScreen({super.key});

  @override
  State<PersonalitiesDetailScreen> createState() =>
      _PersonalitiesDetailScreenState();
}

class _PersonalitiesDetailScreenState extends State<PersonalitiesDetailScreen> {
  @override
  void initState() {
    context.read<AvatarBloc>().add(CheckAvatarUnlocked(id: 10));
    context.read<MyersBriggsBloc>().add(GetMyersBriggesResult());
    // checkAvatarReward();

    super.initState();
  }

  Future<void> checkAvatarReward() async {
    final avatarUnLocked = context.read<AvatarBloc>().state.isAvatarUnlocked;
    final personalityResult =
        context.read<MyersBriggsBloc>().state.personalityResult;
    if (personalityResult.isNotEmpty) {
      if (avatarUnLocked) {
        await Future.delayed(Duration(seconds: 2), () {});
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!mounted) return;
          await DialogUtils.showRewardDialog(
            context: context,
            avatarName: 'THE MYERS BRIGGS AVATAR',
            avatarAsset: 'assets/image/avatar/Myers_Briggs_Avatar.png',
          );
        });
      } else {
        debugPrint('already unlocked');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String name = args['name'];
    final bool isFromPersonalities = args['isFromPersonalities'];
    context.read<MyersBriggsBloc>().add(FetchPersonalitiesById(name: name));
    return BlocListener<AvatarBloc, AvatarState>(
      listenWhen:
          (previous, current) =>
              previous.isAvatarUnlocked != current.isAvatarUnlocked,
      listener: (context, avatarState) {
        final result = context.read<MyersBriggsBloc>().state.personalityResult;
        if (result.isNotEmpty && avatarState.isAvatarUnlocked) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              DialogUtils.showRewardDialog(
                context: context,
                avatarName: 'THE MYERS BRIGGS AVATAR',
                avatarAsset: 'assets/image/avatar/Myers_Briggs_Avatar.png',
              );
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomButtonIconWidget(
                    icon: const Icon(
                      Icons.arrow_circle_left,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      if (isFromPersonalities) {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          StringConstant.navKnowYourScreenKey,
                          ModalRoute.withName(
                            StringConstant.navKnowYourScreenKey,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 50,
                  ),
                  child: BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                    builder: (context, state) {
                      final type = state.personality;
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.asset(
                                  type?.imageP ?? '',
                                  height: 400,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your score results shows you are',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      type?.description ?? '',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.green,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'aka ${type?.description}',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "\"${type?.akaDescription}\""
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "\"${type?.information}\"",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.greenAccent.shade200,
                            height: 40,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Scroll down for more',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.greenAccent.shade100,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    Image.asset(
                                      type?.imageC ?? '',
                                      height: 300,
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Strength'.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.green.shade900,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green.shade50,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 20,
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    (type?.strength ?? [])
                                                        .map(
                                                          (s) => Text(
                                                            '- $s',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Weaknesses'.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.green.shade900,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    Colors.greenAccent.shade100,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 20,
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    (type?.weakness ?? [])
                                                        .map(
                                                          (s) => Text(
                                                            '- $s',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors
                                                                      .green
                                                                      .shade900,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Career'.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.green.shade900,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),

                                                color:
                                                    Colors.greenAccent.shade200,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 20,
                                                  ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    (type?.career ?? [])
                                                        .map(
                                                          (s) => Text(
                                                            '- $s',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
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
