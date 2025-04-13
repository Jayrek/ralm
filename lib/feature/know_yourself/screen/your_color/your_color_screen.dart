import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';

class YourColorScreen extends StatelessWidget {
  const YourColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Exit'),
          ),
        ],
      ),
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Column(
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
            InkWell(
              onTap: () {
                context.read<YourColorBloc>().add(FetchYourColorQuestion());
                Navigator.pushNamed(context, StringConstant.navYourColorTest);
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Center(child: Text('START')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
