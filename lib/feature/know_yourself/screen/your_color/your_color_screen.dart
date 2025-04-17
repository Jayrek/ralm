import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';

class YourColorScreen extends StatelessWidget {
  const YourColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Color',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'With only 15 questions try this fun test on telling what Color of aura your giving!',
                  ),
                  SizedBox(height: 30),
                  CustomButtonRoundedWidget(
                    label: 'START',
                    onPressed: () {
                      context.read<YourColorBloc>().add(
                        FetchYourColorQuestion(),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navYourColorTest,
                      );
                    },
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
