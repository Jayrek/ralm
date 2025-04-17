import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class MyersBriggsTestScreen extends StatefulWidget {
  const MyersBriggsTestScreen({super.key});

  @override
  State<MyersBriggsTestScreen> createState() => _MyersBriggsTestScreenState();
}

class _MyersBriggsTestScreenState extends State<MyersBriggsTestScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final int _itemsPerPage = 10;

  void _nextPage(int maxPages) {
    if (_currentPage < maxPages - 1) {
      setState(() => _currentPage++);
      _scrollToTop();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
      _scrollToTop();
    }
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
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomButtonIconWidget(
                  icon: Icon(Icons.arrow_circle_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                builder: (context, state) {
                  final questions = state.myersBriggsList;
                  final totalPages = (questions.length / _itemsPerPage).ceil();

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
                                    'Question ${globalIndex + 1}'.toUpperCase(),
                                width: 650,
                                child: Text(
                                  question.question,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 650,
                                child: Row(
                                  spacing: 20,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      isEven
                                          ? [
                                            _optionBox(
                                              label:
                                                  question
                                                      .myersBriggsOption[0]
                                                      .text,
                                              onTap: () {},
                                            ),
                                            _optionBox(
                                              label:
                                                  question
                                                      .myersBriggsOption[1]
                                                      .text,
                                              onTap: () {},
                                            ),
                                          ]
                                          : [
                                            _optionBox(
                                              label:
                                                  question
                                                      .myersBriggsOption[0]
                                                      .text,
                                              onTap: () {},
                                            ),
                                            _optionBox(
                                              label:
                                                  question
                                                      .myersBriggsOption[1]
                                                      .text,
                                              onTap: () {},
                                            ),
                                          ],
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
                              child: const Text('Previous'),
                            ),
                          Text('Page ${_currentPage + 1} of $totalPages'),
                          if (_currentPage < totalPages - 1)
                            ElevatedButton(
                              onPressed: () => _nextPage(totalPages),
                              child: const Text('Next'),
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
    );
  }

  Widget _optionBox({required String label, required Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 300,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple.shade300,
            side: BorderSide(color: Colors.deepPurple, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(label, textAlign: TextAlign.center),
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
        Container(
          color: Colors.purple.shade300,
          child: Padding(
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
                style: labelStyle ?? const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
