import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/dialog/dialog_utils.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/forest_test/bloc/forest_test_bloc.dart';
import 'package:ralm/models/forest_test.dart';

class ForestTestResultScreen extends StatefulWidget {
  const ForestTestResultScreen({super.key});

  @override
  State<ForestTestResultScreen> createState() => _ForestTestResultScreenState();
}

class _ForestTestResultScreenState extends State<ForestTestResultScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  int _currentPage = 0;

  void _goToPrevious() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext(int totalZodiacs) {
    if (_currentPage < totalZodiacs - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    context.read<AvatarBloc>().add(CheckAvatarUnlocked(id: 11));
    context.read<ForestTestBloc>().add(GetAvatarForestTest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AvatarBloc, AvatarState>(
      listenWhen:
          (previous, current) =>
              previous.isAvatarUnlocked != current.isAvatarUnlocked,
      listener: (context, avatarState) {
        final result = context.read<ForestTestBloc>().state.avatarUnLocked;
        if (result == 'Yes' && avatarState.isAvatarUnlocked) {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              DialogUtils.showRewardDialog(
                context: context,
                avatarName: 'THE FOREST TEST AVATAR',
                avatarAsset: 'assets/image/avatar/Forest_Test_Avatar.png',
              );
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.purple.shade300,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/bg/forest_test_bg/ft_result_bg.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: BlocBuilder<ForestTestBloc, ForestTestState>(
                    builder: (context, state) {
                      final details = state.forestTestResults;
                      return PageView.builder(
                        controller: _pageController,
                        itemCount: details.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final dream = details[index];

                          double opacity = (_currentPage == index) ? 1.0 : 0;
                          double scale = (_currentPage == index) ? 1.0 : 0.95;

                          return Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              transform: Matrix4.identity()..scale(scale),
                              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: opacity,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: SingleChildScrollView(
                                    child: _buildDreamSignInfoWidget(
                                      dream,
                                      details,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomButtonIconWidget(
                    icon: const Icon(Icons.arrow_circle_left),
                    onPressed:
                        () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          StringConstant.navKnowYourScreenKey,
                          ModalRoute.withName(
                            StringConstant.navKnowYourScreenKey,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDreamSignInfoWidget(ForestTest forestTest, List<ForestTest> list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${forestTest.id}. ${forestTest.forestTestData.description.toUpperCase()}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        // Left & Right Navigation Buttons
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: _currentPage != 0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: _currentPage > 0 ? _goToPrevious : null,
                ),
              ),
              SizedBox(width: 200),
              Visibility(
                visible: _currentPage != list.length - 1,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed:
                      _currentPage < list.length - 1
                          ? () => _goToNext(list.length)
                          : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
