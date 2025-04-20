import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

class IdealTypeResultScreen extends StatelessWidget {
  const IdealTypeResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String gender = args['gender'];
    final int points = args['points'];

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
                  icon: const Icon(Icons.arrow_circle_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(height: 20),
              gender == 'female'
                  ? Text(getGirlResult(points), textAlign: TextAlign.center)
                  : Text(getBoyResult(points), textAlign: TextAlign.center),
              Visibility(
                visible: gender == 'male',
                child: Text(
                  'No matter your result , remember your result, remember , it’s all in good fun. \n\n The perfect guy is out there. And who knows? You might have just gotten a sneak today!',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getGirlResult(int totalPoints) {
    final bucket = StringConstant.getIdealTypeGirlResult(totalPoints);

    switch (bucket) {
      case 1:
        return "The Free Spirit - This girl type is all about living in the moment and embracing life’s adventures. She values independence, craves new experiences, and has a carefree attitude that is infectious. Her ideal match is someone who respects her need for freedom and is willing to join her on spontaneous escapades.";
      case 2:
        return "The Intellectual - She’s a thinker and a dreamer, with a love for deep conversations and a thirst for knowledge. This girl type finds joy in intellectual pursuits and meaningful discussions. She’s attracted to those who can challenge her mind and share her passion for learning.";
      case 3:
        return "The Creative Soul - Artistic and imaginative, this girl type sees the world through a unique lens. She’s often involved in creative projects and finds solace in self-expression. She connects best with individuals who appreciate her artistic nature and support her creative endeavors.";
      case 4:
        return "The Nurturer - Caring and compassionate, this girl type is the epitome of empathy. She’s often the one friends turn to for comfort and advice. She seeks a partner who values emotional depth and is not afraid to show vulnerability.";
      case 5:
        return "The Go-getter - Ambitious and driven, this girl type knows what she wants and isn’t afraid to go after it. She’s goal-oriented and often successful in her pursuits. She resonates with partners who are equally motivated and can keep up with her fast-paced lifestyle.";
      default:
        return 'No result found for the score: $totalPoints';
    }
  }

  String getBoyResult(int totalPoints) {
    final bucket = StringConstant.getIdealTypeBoyResult(totalPoints);

    switch (bucket) {
      case 1:
        return "Your ideal ‘boy type’ is the ‘Adventurous Explorer’ - the guy who’s always up for a thrill!\nn";
      case 2:
        return "You’ve got the ‘ Caring Companion’. Your perfect match is the thoughtful and caring guy who’s there for you!\n\n";
      case 3:
        return "You’re into the ‘Charming Intellectual’ Smart and charismatic- that’s your guy!\n\n";
      default:
        return 'No result found for the score: $totalPoints\n\n';
    }
  }

  //   If your score is 20 or 30, Your ideal ‘boy type’ is the ‘Adventurous Explorer’ - the guy
  // who’s always up for a thrill!
  // Score from 31 to 45?
  // You’ve got the ‘ Caring Companion’. Your perfect match is the thoughtful and caring guy
  // who’s there for you!.
  // And If your total score hits 46 to 60, you’re into the ‘Charming Intellectual’
  // Smart and charismatic- that’s your guy!

  // No matter your result , remember your result, remember , it’s all in good fun.
  // The perfect guy is out there. And who knows? You might have just gotten a sneak today!
}
