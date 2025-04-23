import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';

class ElementalSoulScreen extends StatelessWidget {
  const ElementalSoulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/elemental_soul/es_home_bg.jpg',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Elemental Soul Personality Test'.toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(fontSize: 30, color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Are you ready to deep within soul and discover your true element?',
                        ),
                        Text('Take this fun quiz to play wtih elements'),
                        SizedBox(height: 30),
                        CustomButtonRoundedWidget(
                          label: 'START TEST',
                          onPressed: () {
                            context.read<ElementalSoulBloc>().add(
                              FetchElementalSoulQuestion(),
                            );
                            Navigator.pushNamed(
                              context,
                              StringConstant.navElementalSoulTest,
                            );
                          },
                        ),
                      ],
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
