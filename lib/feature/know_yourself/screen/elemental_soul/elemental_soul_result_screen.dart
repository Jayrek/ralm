import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';

class ElementalSoulResultScreen extends StatelessWidget {
  const ElementalSoulResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final int score = args['score'];
    final String result = args['result'];

    String elementalInfo = '';
    final fire =
        "YOU'RE AN EXCEPTIONALLY BRIGHT AND CHARISMATIC PERSON YOU EASILY CHARM PEOPLE WITH YOUR CHARACTER AND ATTITUDE \nYOU ARE ALSO REALLY ROMANTIC PASSIONATE AND SENSITIVE SAME TIME YOU'RE SUPER FOCUSED DETERMINED AND DECEIVE YOU \nEXACTLY WHAT YOU WANT OUT OF LIFE SOMETIMES YOUR EMOTION CAN TAKE CONTROL OF YOUR ESPECIALLY JEALOUSY AND ANGER \nTRY NOT TO LET UT GET THE BEST OF YOU.";
    final earth =
        "You're an empathetic loyal and hardworking person, you prefer to think things through before acting your creativity and responsibility\n Easily attract people which makes you an undeniable leader. You can be quite stubborn and overly cautious from time to time don't be afraid to loosen up a little trust me you'll enjoy feeling the freedom and spontaneity.";
    final air =
        "You live life to the fullest and love adventures your witty carefree independent and flexible.\n You're truly a person and can find common ground with pretty much anybody\n You might sometimes make irresponsible decisions but you always try to correct your mistake in the end.\n Even though it happens rarely you can be insensitive sellish and dishonest if you notice that in yourself try to work on it to make your life more positive and happy.";
    final water =
        "People whose soul is driven by water have an inner peace and harmony within them that's why they're easygoing and • laidback.\n If you're in this group you're incredibly trusting understanding and devoted to everything that matters to you.\n You can be a little lazy and pessimistic at times just don't let ke become your norm.";

    switch (result.toLowerCase()) {
      case 'fire':
        elementalInfo = fire;
      case 'earth':
        elementalInfo = earth;
      case 'air':
        elementalInfo = air;
      case 'water':
        elementalInfo = water;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade300,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                context.read<ElementalSoulBloc>().add(
                  ResetElementalSoulQuestion(),
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  StringConstant.navDashboardScreenKey,
                  (_) => false,
                );
              },
              child: Text('Exit', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.purple.shade300,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('YOUR ELEMENTAL SOUL IS'),
              Text(
                result,
                // state.elementalSoulResult,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(elementalInfo, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
