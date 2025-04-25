import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/animated_tarot_cad_widget.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/models/avatar.dart';
import 'package:ralm/models/tarot.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Tarot> pickedCards = [];

  @override
  void initState() {
    super.initState();
    _handlePickedCards();
  }

  Future<void> _handlePickedCards() async {
    await resetPickedTarots();
    List<Tarot> cards = await loadPickedCards();
    setState(() {
      pickedCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bg/discover/discover_bg.jpg', fit: BoxFit.cover),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Material(
                      elevation: 4,
                      shape: CircleBorder(),
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            StringConstant.navAvatar,
                          );
                        },
                        child: BlocSelector<AvatarBloc, AvatarState, Avatar>(
                          selector: (state) => state.defaultAvatar,
                          builder: (context, avatar) {
                            return Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: AssetImage(avatar.image),
                              ),
                            );
                          },
                        ),
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
                        (index) => AnimatedTarotCardWidget(
                          tarot:
                              pickedCards.isNotEmpty
                                  ? pickedCards[index]
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
