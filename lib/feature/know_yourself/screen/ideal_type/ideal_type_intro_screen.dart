import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

class IdealTypeIntroScreen extends StatelessWidget {
  const IdealTypeIntroScreen({super.key});

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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ideal Type Test'.toUpperCase(),
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'After taking the test, result shows what type of ideal partner you wanted to be',
                    ),
                    SizedBox(height: 30),
                    Text('Choose your gender'),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                StringConstant.navIdealTYpeTest,
                                arguments: {'gender': 'female'},
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.female,
                                size: 60,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                StringConstant.navIdealTYpeTest,
                                arguments: {'gender': 'male'},
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.male,
                                size: 60,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
