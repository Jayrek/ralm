import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';
import 'package:ralm/models/elemental_soul.dart';

class ElementalSoulTestScreen extends StatefulWidget {
  const ElementalSoulTestScreen({super.key});

  @override
  State<ElementalSoulTestScreen> createState() =>
      _ElementalSoulTestScreenState();
}

class _ElementalSoulTestScreenState extends State<ElementalSoulTestScreen> {
  void selectOption(Option option) {
    context.read<ElementalSoulBloc>().add(
      SelectElementalSoulOption(option: option),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg/elemental_soul/es_test_bg.jpg'),
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
                                  child: BlocConsumer<
                                    ElementalSoulBloc,
                                    ElementalSoulState
                                  >(
                                    listener: (context, state) {
                                      final index = state.currentIndex;
                                      final questions =
                                          state.elementalSoulQuestions;

                                      if (index >= questions.length) {
                                        final result =
                                            StringConstant.getElementalTypeFromScore(
                                              state.totalScore,
                                            );
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          StringConstant.navElementalSoulResult,
                                          (_) => false,
                                          arguments: {
                                            'score': state.totalScore,
                                            'result': result,
                                          },
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      final questions =
                                          state.elementalSoulQuestions;
                                      final index = state.currentIndex;

                                      if (questions.isEmpty ||
                                          index >= questions.length) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      final question = questions[index];

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            question.question.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
                                          ...question.option.map((option) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                  ),
                                              child: _optionBox(
                                                label: option.text,
                                                onTap:
                                                    () => selectOption(option),
                                              ),
                                            );
                                          }),
                                        ],
                                      );
                                    },
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
    );
  }

  Widget _optionBox({required String label, required Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        width: 300,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.white, width: 2),
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
