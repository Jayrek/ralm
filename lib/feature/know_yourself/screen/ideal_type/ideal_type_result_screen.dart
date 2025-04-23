import 'package:flutter/material.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';

class IdealTypeResultScreen extends StatefulWidget {
  const IdealTypeResultScreen({super.key});

  @override
  State<IdealTypeResultScreen> createState() => _IdealTypeResultScreenState();
}

class _IdealTypeResultScreenState extends State<IdealTypeResultScreen> {
  String imageBg = '';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String gender = args['gender'];
    final int points = args['points'];

    imageBg =
        gender == 'female'
            ? getGirlImageResult(points)
            : getBoyImageResult(points);

    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/ideal_type_bg/it_test_bg.jpg',
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
                      icon: const Icon(Icons.arrow_circle_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  gender == 'female'
                      ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _buildImageContainerWidget(imageBg),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              getGirlResult(points),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                      : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _buildImageContainerWidget(imageBg),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text(
                                  getBoyResult(points),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'No matter your result , remember your result, remember , it’s all in good fun. \n\n The perfect guy is out there. And who knows? You might have just gotten a sneak today!',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildImageContainerWidget(String image) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Container(
            height: 350,
            width: 180,
            child: Image.asset(image, fit: BoxFit.fill),
            // decoration: BoxDecoration(
            //   color: Colors.black45,
            //   border: Border.all(width: 1, color: Colors.black87),
            //   borderRadius: BorderRadius.circular(10),
            //   image: DecorationImage(
            //     image: AssetImage(image),
            //     fit: BoxFit.fill,
            //   ),
            // ),
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

  String getBoyImageResult(int totalPoints) {
    final bucket = StringConstant.getIdealTypeBoyResult(totalPoints);
    switch (bucket) {
      case 1:
        return "assets/bg/ideal_type_bg/boy_adventurous_explorer.png";
      case 2:
        return "assets/bg/ideal_type_bg/boy_throughtful_caring.png";
      case 3:
        return "assets/bg/ideal_type_bg/boy_charming_intellectual.png";
      default:
        return 'No result found for the score: $totalPoints\n\n';
    }
  }

  String getGirlImageResult(int totalPoints) {
    final bucket = StringConstant.getIdealTypeGirlResult(totalPoints);
    switch (bucket) {
      case 1:
        return "assets/bg/ideal_type_bg/girl_free_spirit.png";
      case 2:
        return "assets/bg/ideal_type_bg/girl_intellectual.png";
      case 3:
        return "assets/bg/ideal_type_bg/girl_creative_soul.png";
      case 4:
        return "assets/bg/ideal_type_bg/girl_nurturer.png";
      case 5:
        return "assets/bg/ideal_type_bg/girl_go_getter.png";
      default:
        return 'No result found for the score: $totalPoints';
    }
  }
}
