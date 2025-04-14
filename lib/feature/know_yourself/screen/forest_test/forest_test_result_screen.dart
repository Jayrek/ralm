import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: BlocBuilder<ForestTestBloc, ForestTestState>(
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: opacity,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SingleChildScrollView(
                        child: _buildDreamSignInfoWidget(dream, details),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
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
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
