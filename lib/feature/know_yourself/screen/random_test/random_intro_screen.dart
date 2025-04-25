import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

class RandomIntroScreen extends StatelessWidget {
  const RandomIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/bg/random_test_bg/random_test_home_bg.jpg',
              ),
              // fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.2),
            child: SafeArea(
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
                        icon: Icon(Icons.arrow_circle_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),

                    // gibutang ra ni aron mangatik
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            '',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 180),
                      child: _optionBox(
                        label: 'START TEST',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            StringConstant.navRandomTest,
                          );
                        },
                      ),
                    ),
                    Text(
                      '',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionBox({required String label, required Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 200,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: BorderSide(color: Colors.pink, width: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
