import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';
import 'package:ralm/models/elemental_soul.dart';

class YourColorTestScreen extends StatefulWidget {
  const YourColorTestScreen({super.key});

  @override
  State<YourColorTestScreen> createState() => _YourColorTestScreenState();
}

class _YourColorTestScreenState extends State<YourColorTestScreen> {
  void selectOption(Option option) {
    context.read<YourColorBloc>().add(SelectYourColorOption(option: option));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<YourColorBloc, YourColorState>(
          listener: (context, state) {
            final index = state.currentIndex;
            final questions = state.yourColorQuestions;

            if (index >= questions.length) {
              final result = StringConstant.getColorResultFromScore(
                state.totalScore,
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                StringConstant.navYourColorResult,
                (_) => false,
                arguments: {'score': state.totalScore, 'result': result},
              );
            }
          },
          builder: (context, state) {
            final questions = state.yourColorQuestions;
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
                          context.read<YourColorBloc>().add(
                            SelectYourColorOption(option: option),
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
}
