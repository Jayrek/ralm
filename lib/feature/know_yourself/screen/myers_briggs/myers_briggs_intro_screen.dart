import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class MyersBriggsIntroScreen extends StatelessWidget {
  const MyersBriggsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple.shade300),
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
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
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('Myers Briggs Personality Test'.toUpperCase()),
                  Text(
                    'A total of 50 questions! The Myers Briggs Type Indicator (MBTI) assessment is a tool that hepls people increase their self-awareness understand and appreciate differences in others, and apply personality insights to improve their personal and professional effectiveness.',
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // TODO(jayrek): show dialog here

                      context.read<MyersBriggsBloc>().add(
                        FetchMyersBriggsQuestions(),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navMyersBriggsTest,
                      );
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(child: Text('START TEST')),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(child: Text('16 Personalities')),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(child: Text('History')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
