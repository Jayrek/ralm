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

    String imageResult = '';
    final fireImage = 'assets/bg/elemental_soul/es_fire_bg.jpg';
    final airImage = 'assets/bg/elemental_soul/es_air_bg.jpg';
    final earthImage = 'assets/bg/elemental_soul/es_earth_bg.jpg';
    final waterImage = 'assets/bg/elemental_soul/es_water_bg.jpg';

    switch (result.toLowerCase()) {
      case 'fire':
        imageResult = fireImage;
      case 'earth':
        imageResult = earthImage;
      case 'air':
        imageResult = airImage;
      case 'water':
        imageResult = waterImage;
    }

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
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageResult),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextButton(
                            onPressed: () {
                              context.read<ElementalSoulBloc>().add(
                                ResetElementalSoulQuestion(),
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                StringConstant.navKnowYourScreenKey,
                                ModalRoute.withName(
                                  StringConstant.navKnowYourScreenKey,
                                ),
                              );
                            },
                            child: Text(
                              'Exit',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Text(
                        'YOUR ELEMENTAL SOUL IS',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          elementalInfo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 60), // Extra spacing at bottom
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
