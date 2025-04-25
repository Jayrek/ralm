import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/models/random_test.dart';

class RandomTestScreen extends StatefulWidget {
  const RandomTestScreen({super.key});

  @override
  State<RandomTestScreen> createState() => _RandomTestScreenState();
}

class _RandomTestScreenState extends State<RandomTestScreen> {
  List<RandomTest> _questions = [];
  int _currentIndex = 0;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _loadQuestionsFromJson();
  }

  Future<void> _loadQuestionsFromJson() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/random_test.json',
    );
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      _questions = jsonList.map((e) => RandomTest.fromJson(e)).toList();
    });
  }

  void _onShowResultPressed() {
    setState(() {
      _showResult = true;
    });
  }

  void _onNextPressed() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _showResult = false;
      });
    } else {
      // End of quiz
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("You've reached the end!")));
      Navigator.pushNamedAndRemoveUntil(
        context,
        StringConstant.navKnowYourScreenKey,
        ModalRoute.withName(StringConstant.navKnowYourScreenKey),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            _questions.isEmpty
                ? Center(child: CircularProgressIndicator())
                : SizedBox.expand(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/bg/random_test_bg/rpt_test_bg.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: SafeArea(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: IntrinsicHeight(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: CustomButtonIconWidget(
                                            icon: const Icon(
                                              Icons.arrow_circle_left,
                                            ),
                                            onPressed:
                                                () => Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  StringConstant
                                                      .navKnowYourScreenKey,
                                                  ModalRoute.withName(
                                                    StringConstant
                                                        .navKnowYourScreenKey,
                                                  ),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Expanded(
                                          child: Center(
                                            child: QuestionCard(
                                              question:
                                                  '${_questions[_currentIndex].id}. ${_questions[_currentIndex].question}',
                                              imagePath:
                                                  _questions[_currentIndex]
                                                      .image,
                                              result:
                                                  _questions[_currentIndex]
                                                      .results,
                                              showResult: _showResult,
                                              onShowResult:
                                                  _onShowResultPressed,
                                              onNext: _onNextPressed,
                                              isLast:
                                                  _currentIndex ==
                                                  _questions.length - 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String question;
  final String imagePath;
  final String result;
  final bool showResult;
  final VoidCallback onShowResult;
  final VoidCallback onNext;
  final bool isLast;

  const QuestionCard({
    super.key,
    required this.question,
    required this.imagePath,
    required this.result,
    required this.showResult,
    required this.onShowResult,
    required this.onNext,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 20),
        if (imagePath.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, height: 250),
          ),
        const SizedBox(height: 20),
        if (showResult) ...[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              result,
              key: ValueKey(result),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 16),
          CustomButtonRoundedWidget(
            label: isLast ? 'Finish' : 'Next Question',
            onPressed: onNext,
          ),
        ] else
          CustomButtonRoundedWidget(
            label: "Show Result",
            onPressed: onShowResult,
          ),
      ],
    );
  }
}
