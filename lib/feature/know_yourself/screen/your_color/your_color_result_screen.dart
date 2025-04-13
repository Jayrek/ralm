import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';

class YourColorResultScreen extends StatelessWidget {
  const YourColorResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int score = args['score'];
    final String result = args['result'];

    String colorInfo = '';
    final green =
        "You're supportive and loyal with exceptional people skills you can read the emotions of others and spread your positive healing energy you always find the most original solution to any problem you feel equally good among people and alone.";
    final purple =
        "You're logical serious and in perfect balance between your body and mind you can resolve any conflict and people come to you for advice you're naturally mysterious unique and incredibly interesting it draws others to you you enjoy reading and are really wise for your age.";
    final red =
        "Energy and passion are two words that describe you the best you can lead any project people trust you and follow your drive love and relationships are important to you you're the soul of any party nothing can scare you or stop you.";
    final blue =
        "You're a natural explorer you never think twice if someone offers to try something new or go to a new place you live every day to the fullest and don't regret it you're also a very kind person and will always help a friend out no matter what it costs you.";
    final white =
        "You're an artist at heart creating something with your hands or mind makes you the happiest you might seem shy but that's because you're always in the world of your dreams you see beauty in the little things and want to make the world a better place.";

    switch (result.toLowerCase()) {
      case 'green':
        colorInfo = green;
      case 'purple':
        colorInfo = purple;
      case 'red':
        colorInfo = red;
      case 'blue':
        colorInfo = blue;
      case 'white':
        colorInfo = white;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        actions: [
          TextButton(
            onPressed: () {
              context.read<YourColorBloc>().add(ResetYourColorQuestion());
              Navigator.pushNamedAndRemoveUntil(
                context,
                StringConstant.navDashboardScreenKey,
                (_) => false,
              );
            },
            child: Text('Exit'),
          ),
        ],
      ),
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 50,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(colorInfo, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
