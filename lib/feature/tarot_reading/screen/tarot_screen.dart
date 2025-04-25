import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';

class TarotScreen extends StatelessWidget {
  const TarotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/tarot_bg/tc_card_home_bg.jpg',
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
                      children: [
                        Text(
                          'TAROT',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontSize: 50, color: Colors.white),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Pick 3 Cards to start your day.',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'First card tell about the present',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        Text(
                          'Second card tells about tomorrow or the sooner days.',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        Text(
                          'Third card represent the long run in the future',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),

                        SizedBox(height: 30),
                        CustomButtonRoundedWidget(
                          label: 'START',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              StringConstant.navTarotCard,
                            );
                          },
                        ),

                        SizedBox(height: 10),
                        CustomButtonRoundedWidget(
                          label: 'VIEW CARDS',
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              StringConstant.navTarotViewCard,
                            );
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'EXIT',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
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
