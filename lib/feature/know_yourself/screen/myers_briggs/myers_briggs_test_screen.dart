import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';
import 'package:ralm/models/myers_briggs.dart';

class MyersBriggsTestScreen extends StatefulWidget {
  const MyersBriggsTestScreen({super.key});

  @override
  State<MyersBriggsTestScreen> createState() => _MyersBriggsTestScreenState();
}

class _MyersBriggsTestScreenState extends State<MyersBriggsTestScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final int _itemsPerPage = 10;
  String myersBriggsResult = '';

  @override
  void initState() {
    // Wait until the state is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyersBriggsBloc>().add(const FetchPersonalities());
      final bloc = context.read<MyersBriggsBloc>();
      final state = bloc.state;

      final lastAnsweredIndex = state.myersBriggsList.lastIndexWhere(
        (q) => q.selectedOption != null,
      );

      if (lastAnsweredIndex != -1) {
        // Go to the page that contains the last answered question
        final page = lastAnsweredIndex ~/ _itemsPerPage;
        setState(() => _currentPage = page);
      }

      // _showAddToDiscoverDialog();
    });
    super.initState();
  }

  void _showAddToDiscoverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade500,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.pinkAccent, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'WOULD YOU LIKE TO ADD THE RESULT TO YOUR DISCOVER PAGE?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dialogOptionButton(
                      label: 'NO',
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    _dialogOptionButton(
                      label: 'YES',
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogOptionButton({
    required String label,
    required Function()? onTap,
  }) {
    return SizedBox(
      width: 100,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple.shade500,
          side: BorderSide(color: Colors.lightGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    );
  }

  void _nextPage(int maxPages, List<MyersBriggs> visibleQuestions) {
    final allAnswered = visibleQuestions.every((q) => q.selectedOption != null);
    final myersData = context.read<MyersBriggsBloc>().state.myersBriggsList;

    if (!allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please answer all questions on this page before continuing.',
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    if (_currentPage < maxPages - 1) {
      setState(() => _currentPage++);
      _scrollToTop();
    }
    // if (allAnswered) {
    //   setState(() {
    //     myersBriggsResult = calculateMBTIFromAnswers(myersData);
    //     debugPrint('myersBriggsResult: $myersBriggsResult');
    //   });
    // }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _scrollToTop();
    }
  }

  String calculateMBTIFromAnswers(List<MyersBriggs> answers) {
    final Map<String, int> counts = {
      'E': 0,
      'I': 0,
      'S': 0,
      'N': 0,
      'T': 0,
      'F': 0,
      'J': 0,
      'P': 0,
    };

    for (final question in answers) {
      final selected = question.selectedOption;
      if (selected != null && counts.containsKey(selected.personalityCode)) {
        counts[selected.personalityCode] =
            counts[selected.personalityCode]! + 1;
      }
    }

    String result = '';
    result += (counts['E']! >= counts['I']!) ? 'E' : 'I';
    result += (counts['S']! >= counts['N']!) ? 'S' : 'N';
    result += (counts['T']! >= counts['F']!) ? 'T' : 'F';
    result += (counts['J']! >= counts['P']!) ? 'J' : 'P';

    return result;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/myers_briggs_bg/mb_test_bg.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/bg/myers_briggs_bg/mb_test_icon.png',
                            height: 150,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: CustomButtonIconWidget(
                            icon: const Icon(Icons.arrow_circle_left),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                    builder: (context, state) {
                      final questions = state.myersBriggsList;
                      final totalPages =
                          (questions.length / _itemsPerPage).ceil();

                      final start = _currentPage * _itemsPerPage;
                      final end = (_currentPage + 1) * _itemsPerPage;
                      final visibleQuestions = questions.sublist(
                        start,
                        end > questions.length ? questions.length : end,
                      );

                      return Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: visibleQuestions.length,
                            itemBuilder: (context, index) {
                              final question = visibleQuestions[index];
                              final globalIndex = start + index;
                              final isEven = globalIndex % 2 == 0;

                              return Column(
                                crossAxisAlignment:
                                    isEven
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                children: [
                                  LabeledBorderBox(
                                    label:
                                        'Question ${globalIndex + 1}'
                                            .toUpperCase(),
                                    width: 650,
                                    child: Text(
                                      question.question,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: 650,
                                    child: Row(
                                      spacing: 20,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:
                                          question.myersBriggsOption.map((
                                            option,
                                          ) {
                                            return _optionBox(
                                              label: option.text,
                                              isSelected:
                                                  question
                                                      .selectedOption
                                                      ?.text ==
                                                  option.text,
                                              onTap: () {
                                                context
                                                    .read<MyersBriggsBloc>()
                                                    .add(
                                                      SelectMyersBriggsOption(
                                                        questionId: question.id,
                                                        selectedOption: option,
                                                      ),
                                                    );
                                              },
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_currentPage > 0)
                                ElevatedButton(
                                  onPressed: _previousPage,
                                  child: const Text(
                                    'Previous',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                              Text(
                                'Page ${_currentPage + 1} of $totalPages',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              // if (_currentPage < totalPages - 1)
                              //   ElevatedButton(
                              //     onPressed:
                              //         () => _nextPage(
                              //           totalPages,
                              //           visibleQuestions,
                              //         ),
                              //     child: const Text('Next'),
                              //   ),
                              if (_currentPage < totalPages - 1)
                                ElevatedButton(
                                  onPressed:
                                      () => _nextPage(
                                        totalPages,
                                        visibleQuestions,
                                      ),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                )
                              else
                                ElevatedButton(
                                  onPressed: () async {
                                    final myersData =
                                        context
                                            .read<MyersBriggsBloc>()
                                            .state
                                            .myersBriggsList;

                                    final allAnswered = myersData.every(
                                      (q) => q.selectedOption != null,
                                    );

                                    if (!allAnswered) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please answer all questions before submitting.',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      return;
                                    }

                                    final result = calculateMBTIFromAnswers(
                                      myersData,
                                    );

                                    setState(() {
                                      myersBriggsResult = result;
                                    });

                                    context.read<MyersBriggsBloc>().add(
                                      const ClearMyersBriggsProgress(),
                                    );

                                    await Future.delayed(
                                      Duration(seconds: 1),
                                      () {},
                                    );

                                    debugPrint('MBTI Result: $result');
                                    Navigator.pushNamed(
                                      context,
                                      StringConstant
                                          .navMyersBriggsPersonalitiesDetail,
                                      arguments: {'name': result},
                                    );
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionBox({
    required bool isSelected,
    required String label,
    required Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 300,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: isSelected ? Colors.deepPurple : null,
            side: BorderSide(color: Colors.deepPurple, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      ),
    );
  }
}

class LabeledBorderBox extends StatelessWidget {
  final String label;
  final Widget child;
  final double width;
  final TextStyle? labelStyle;

  const LabeledBorderBox({
    super.key,
    required this.label,
    required this.child,
    this.width = double.infinity,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: width,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: child,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.yellow),
              borderRadius: BorderRadius.circular(50),
              color: Colors.purple.shade300,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              style:
                  labelStyle ??
                  const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            ),
          ),
        ),
      ],
    );
  }
}
