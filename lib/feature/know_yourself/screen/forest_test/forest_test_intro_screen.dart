// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:ralm/core/constants/string_constant.dart';
// import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

// class ForestTestIntroScreen extends StatelessWidget {
//   const ForestTestIntroScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SizedBox.expand(
//         child: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/bg/forest_test_bg/ft_home_bg.jpg'),
//               // fit: BoxFit.cover,
//             ),
//           ),
//           child: Container(
//             color: Colors.black.withOpacity(0.2),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: CustomButtonIconWidget(
//                         icon: Icon(Icons.arrow_circle_left),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                     ),

//                     Expanded(
//                       child: Center(
//                         child: Column(
//                           children: [
//                             SizedBox(height: 70),
//                             Text(
//                               'Forest Test',
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.headlineMedium?.copyWith(
//                                 color: Colors.white,
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                             SizedBox(height: 40),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 40,
//                               ),
//                               child: Text(
//                                 "A total of 10 questions! The Forest Test is test that explore aspects of one's personality, emotion, and subconscious through symbolic representation within the forest imagery.",
//                                 style: Theme.of(
//                                   context,
//                                 ).textTheme.headlineMedium?.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontFamily: 'Poppins',
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                             SizedBox(height: 40),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   StringConstant.navForestTest,
//                                 );
//                               },
//                               child: Text(
//                                 'START',
//                                 style: Theme.of(
//                                   context,
//                                 ).textTheme.headlineMedium?.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                   fontFamily: 'Poppins',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/forest_test/bloc/forest_test_bloc.dart';
import 'package:video_player/video_player.dart';

class ForestTestIntroScreen extends StatefulWidget {
  const ForestTestIntroScreen({super.key});

  @override
  State<ForestTestIntroScreen> createState() => _ForestTestIntroScreenState();
}

class _ForestTestIntroScreenState extends State<ForestTestIntroScreen> {
  bool _showVideo = false;
  late VideoPlayerController _controller;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/forest_test.mp4')
      ..initialize().then((_) {
        if (_showVideo) {
          setState(() {});
          _controller.play();
        }
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_controller.value.isPlaying &&
          !_isVideoEnded) {
        setState(() {
          _isVideoEnded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateAfterVideo() {
    if (_isVideoEnded) {
      context.read<ForestTestBloc>().add(FetchForestTestResult());
      Navigator.pushNamed(context, StringConstant.navForestTestResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _showVideo ? _buildVideoPlayer() : _buildIntroScreen(context),
      floatingActionButton:
          _showVideo && _controller.value.isInitialized
              ? FloatingActionButton.extended(
                onPressed: () {
                  _controller.pause(); // stop the video
                  context.read<ForestTestBloc>().add(FetchForestTestResult());
                  context.read<ForestTestBloc>().add(SaveAvatarForestTest());
                  context.read<AvatarBloc>().add(UnlockAvatar(11));

                  Navigator.pushNamed(
                    context,
                    StringConstant.navForestTestResult,
                  );
                },
                label: const Text("Skip"),
                icon: const Icon(Icons.skip_next),
              )
              : null,
    );
  }

  Widget _buildIntroScreen(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/forest_test_bg/ft_home_bg.jpg'),
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomButtonIconWidget(
                      icon: const Icon(Icons.arrow_circle_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Forest Test',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "A total of 10 questions! The Forest Test explores aspects of one's personality, emotion, and subconscious through symbolic forest imagery.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _showVideo = true;
                                _controller.play();
                              });
                            },
                            child: Text(
                              'START',
                              style: Theme.of(
                                context,
                              ).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Poppins',
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
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _navigateAfterVideo,
      child: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          if (_isVideoEnded)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Would you like to show the results?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _navigateAfterVideo,
                    child: const Text('Show Result'),
                  ),
                ],
              ),
            ),
          Positioned(
            top: 0,
            left: 0,
            child: CustomButtonIconWidget(
              icon: const Icon(Icons.arrow_circle_left),
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(StringConstant.navDashboardScreenKey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
