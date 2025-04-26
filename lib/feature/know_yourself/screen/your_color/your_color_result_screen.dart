import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/dialog/dialog_utils.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';

class YourColorResultScreen extends StatefulWidget {
  const YourColorResultScreen({super.key});

  @override
  State<YourColorResultScreen> createState() => _YourColorResultScreenState();
}

class _YourColorResultScreenState extends State<YourColorResultScreen> {
  @override
  void initState() {
    context.read<AvatarBloc>().add(CheckAvatarUnlocked(id: 13));
    context.read<YourColorBloc>().add(GetAvatarYourColor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final int score = args['score'];
    final String result = args['result'];

    String imageResult = '';
    final blueImage = 'assets/bg/your_color/yc_blue_green.jpg';
    final greenImage = 'assets/bg/your_color/yc_green_bg.jpg';
    final purpleImage = 'assets/bg/your_color/yc_purple_bg.jpg';
    final redImage = 'assets/bg/your_color/yc_red_bg.jpg';
    final whiteImage = 'assets/bg/your_color/yc_white_bg.jpg';

    switch (result.toLowerCase()) {
      case 'green':
        imageResult = greenImage;
      case 'purple':
        imageResult = purpleImage;
      case 'red':
        imageResult = redImage;
      case 'blue':
        imageResult = blueImage;
      case 'white':
        imageResult = whiteImage;
    }

    String colorInfo = '';
    final green =
        "You're supportive and loyal with exceptional people skills you can read the emotions of others and spread your positive healing energy you always find the most original solution to any problem you feel equally good among people and alone.";
    final purple =
        "You're logical serious and in perfect balance between your body and mind you can resolve any conflict and people come to you for advice you're naturally mysterious unique and incredibly interesting it draws others to you you enjoy reading and are really wise for your age.";
    final red =
        "Energy and passion are two words that describe you the best you can lead any project people trust you and follow your drive love and relationships are important to you you're the soul of any party nothing can scare you or stop you.";
    final blue =
        "You're a natural explorer you never think twice if someone offers to try something new or go to a new place you live every day to the fullest and don't regret it you're also a very kind person and will always help a friend out no matter what it costs you.";
    final white =
        "You're an artist at heart creating something with your hands or mind makes you the happiest you might seem shy but that's because you're always in the world of your dreams you see beauty in the little things and want to make the world a better place.";

    switch (result.toLowerCase()) {
      case 'green':
        colorInfo = green;
      case 'purple':
        colorInfo = purple;
      case 'red':
        colorInfo = red;
      case 'blue':
        colorInfo = blue;
      case 'white':
        colorInfo = white;
    }

    return BlocListener<AvatarBloc, AvatarState>(
      listenWhen:
          (previous, current) =>
              previous.isAvatarUnlocked != current.isAvatarUnlocked,

      listener: (context, avatarState) {
        final result = context.read<YourColorBloc>().state.avatarUnLocked;
        if (result != 'No' && avatarState.isAvatarUnlocked) {
          Future.delayed(const Duration(seconds: 2), () {
            if (context.mounted) {
              DialogUtils.showRewardDialog(
                context: context,
                avatarName: 'THE YOUR COLOR AVATAR',
                avatarAsset: 'assets/image/avatar/Your_Color_Avatar.png',
              );
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageResult),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () async {
                            context.read<YourColorBloc>().add(
                              ResetYourColorQuestion(),
                            );

                            await Future.delayed(Duration(seconds: 1), () {});
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringConstant.navKnowYourScreenKey,
                              ModalRoute.withName(
                                StringConstant.navKnowYourScreenKey,
                              ),
                            );
                          },
                          child: Text(
                            'Exit',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Text(
                      result.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Text(
                        colorInfo,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
