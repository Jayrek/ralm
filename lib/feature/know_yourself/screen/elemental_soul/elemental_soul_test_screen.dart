import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';
import 'package:ralm/models/elemental_soul.dart';

class ElementalSoulTestScreen extends StatefulWidget {
  const ElementalSoulTestScreen({super.key});

  @override
  State<ElementalSoulTestScreen> createState() =>
      _ElementalSoulTestScreenState();
}

class _ElementalSoulTestScreenState extends State<ElementalSoulTestScreen> {
  bool _hasNavigatedToResult = false;

  void selectOption(Option option) {
    context.read<ElementalSoulBloc>().add(
      SelectElementalSoulOption(option: option),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ElementalSoulBloc, ElementalSoulState>(
          listener: (context, state) {
            final index = state.currentIndex;
            final questions = state.elementalSoulQuestions;

            if (index >= questions.length) {
              _hasNavigatedToResult = true;
              final result = StringConstant.getElementalTypeFromScore(
                state.totalScore,
              );

              // context.read<ElementalSoulBloc>().add(
              //   ResetElementalSoulQuestion(),
              // );

              Navigator.pushNamedAndRemoveUntil(
                context,
                StringConstant.navElementalSoulResult,
                (_) => false,
                arguments: {'score': state.totalScore, 'result': result},
              );
            }
          },
          builder: (context, state) {
            final questions = state.elementalSoulQuestions;
            final index = state.currentIndex;

            if (questions.isEmpty || index >= questions.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final question = questions[index];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question.question.toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ...question.option.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 40,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.read<ElementalSoulBloc>().add(
                            SelectElementalSoulOption(option: option),
                          );
                        },
                        child: Container(
                          width: 480,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Center(child: Text(option.text)),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCompletedTestDialog(int index, ElementalSoulState state) {
    if (index >= state.elementalSoulQuestions.length) {
      final result = StringConstant.getElementalTypeFromScore(state.totalScore);
      return Center(
        child: AlertDialog(
          title: const Text("Quiz Completed"),
          content: Text("You are: $result\nTotal Score: ${state.totalScore}"),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ElementalSoulBloc>().add(
                  ResetElementalSoulQuestion(),
                );
              },
              child: const Text("Restart"),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
