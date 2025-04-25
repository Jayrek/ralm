import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

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
                        Text('Pick 3 Cards to start your day.'),
                        SizedBox(height: 30),
                        Text('First card tell about the present'),
                        Text(
                          'Second card tells about tomorrow or the sooner days.',
                        ),
                        Text('Third card represent the long run in the future'),

                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              StringConstant.navTarotCard,
                            );
                          },
                          child: Text('START'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              StringConstant.navTarotViewCard,
                            );
                          },
                          child: Text('View Cards'),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('EXIT'),
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
