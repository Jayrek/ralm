import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class MyersBriggsIntroScreen extends StatelessWidget {
  const MyersBriggsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/myers_briggs_bg/mb_home_bg.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomButtonIconWidget(
                      icon: Icon(Icons.arrow_circle_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.purpleAccent,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      width: 700,
                      height: 400,
                      padding: EdgeInsets.all(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Myers Briggs'.toUpperCase(),
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium?.copyWith(
                                  fontSize: 30,
                                  color: Colors.yellow,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Myers Briggs Personality Test'.toUpperCase(),
                                style: TextStyle(color: Colors.yellow),
                              ),
                              Text(
                                'A total of 50 questions! The Myers Briggs Type Indicator (MBTI) assessment is a tool that hepls people increase their self-awareness understand and appreciate differences in others, and apply personality insights to improve their personal and professional effectiveness.',
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButtonRoundedWidget(
                                label: 'START TEST',
                                onPressed: () {
                                  context.read<MyersBriggsBloc>().add(
                                    FetchMyersBriggsQuestions(),
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    StringConstant.navMyersBriggsTest,
                                  );
                                },
                              ),
                              CustomButtonRoundedWidget(
                                label: '16 Personalities',
                                onPressed:
                                    () => Navigator.pushNamed(
                                      context,
                                      StringConstant
                                          .navMyersBriggsPersonalities,
                                    ),
                              ),
                              CustomButtonRoundedWidget(
                                label: 'History',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
