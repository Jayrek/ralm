import 'package:flutter/material.dart';

class ElementalSoulScreen extends StatelessWidget {
  const ElementalSoulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('ss'));
  }

  Widget _buildIntroScreen() {
    return Column(
      children: [
        Text('Elemental Soul Personality Test'),
        Text(
          'Are you ready to deep within soul and discover your true element?',
        ),
        Text('Take this fun quiz to play wtih elements'),
        Text('Start Test'),
      ],
    );
  }
}
