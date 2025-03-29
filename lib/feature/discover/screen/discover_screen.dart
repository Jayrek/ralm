import 'package:flutter/material.dart';
import 'package:ralm/core/shared/widget/animated_tarot_cad_widget.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.deepPurple, width: 4),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Birthday: March 26, 1997'),
                        Text('Horoscope: Aries'),
                        Text('Chinese Zodiac: Ox'),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Elemental Soul: Air'),
                            Icon(Icons.edit, size: 15, color: Colors.white),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Aura Color: Blue'),
                            Icon(Icons.edit, size: 15, color: Colors.white),
                          ],
                        ),
                        Row(
                          children: [
                            Text('MBTI: ESTP'),
                            Icon(Icons.edit, size: 15, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Text('DAILY TAROT CARD'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedTarotCardWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tarotCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 200,
        width: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Colors.black87),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
