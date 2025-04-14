import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/forest_test/bloc/forest_test_bloc.dart';
import 'package:video_player/video_player.dart';

class ForestTestScreen extends StatefulWidget {
  const ForestTestScreen({super.key});

  @override
  State<ForestTestScreen> createState() => _ForestTestScreenState();
}

class _ForestTestScreenState extends State<ForestTestScreen> {
  late VideoPlayerController _controller;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/forest_test.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_controller.value.isPlaying &&
          !_isVideoEnded) {
        setState(() {
          _isVideoEnded = true;
          _controller.pause();
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
      debugPrint('next');

      context.read<ForestTestBloc>().add(FetchForestTestResult());

      Navigator.pushNamed(context, StringConstant.navForestTestResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _controller.value.isInitialized
              ? GestureDetector(
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
                            Text(
                              'Would you like to show the results?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _navigateAfterVideo,
                              child: Text('Show Result'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
              : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
