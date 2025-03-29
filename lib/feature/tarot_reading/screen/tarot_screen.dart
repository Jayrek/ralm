import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';

class TarotScreen extends StatelessWidget {
  const TarotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(
                'TAROT',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Text('Pick 3 Cards to start your day.'),
              SizedBox(height: 30),
              Text('First card tell about the present'),
              Text('Second card tells about tomorrow or the sooner days.'),
              Text('Third card represent the long run in the future'),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, StringConstant.navTarotCard);
                },
                child: Text('START'),
              ),
              SizedBox(height: 30),
              ElevatedButton(onPressed: () {}, child: Text('View Cards')),
              SizedBox(height: 60),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('EXIT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
