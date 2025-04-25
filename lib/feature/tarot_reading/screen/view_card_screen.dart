import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/tarot_reading/bloc/tarot_bloc.dart';
import 'package:ralm/models/tarot.dart';

class ViewTarotCard extends StatefulWidget {
  const ViewTarotCard({super.key});

  @override
  State<ViewTarotCard> createState() => _ViewTarotCardState();
}

class _ViewTarotCardState extends State<ViewTarotCard> {
  List<bool> _isVisible = [];

  @override
  void initState() {
    super.initState();

    context.read<TarotBloc>().add(FetchTarotCards());
  }

  void _animateCards(int count) {
    _isVisible = List.generate(count, (_) => false);
    for (int i = 0; i < count; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        if (mounted) {
          setState(() {
            _isVisible[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/tarot_bg/tc_card_detail_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: BlocListener<TarotBloc, TarotState>(
                listenWhen:
                    (previous, current) =>
                        previous.tarots != current.tarots &&
                        current.tarots.isNotEmpty,
                listener: (context, state) {
                  _animateCards(state.tarots.length);
                },
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomButtonIconWidget(
                        icon: Icon(Icons.arrow_circle_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'The Major Arcana cards are the most recognizable and impactful cards in a Tarot deck. These 22 cards represent situations we all face in the grand scheme of life, with each carrying specific messages of perspective and guidance to help you in times of need. While the Minor Arcana cards focus on the everyday actions and decisions you must face, these Major Arcana cards reveal messages about the bigger picture of your life and its long-term direction. Though each of the Major Arcana cards stands alone with its own deep meanings and influences, these 22 Tarot cards also tell a united story. The first card, The Fool, is the main character of this story, and his experiences as he learns, grows, and makes his way through life are represented by the 21 cards that follow. This storyline is a great description of the accomplishments, setbacks, and lessons we all learn as we go through the trials and tribulations of our lifetime, growing into whole, complete beings by the end of our journey.',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          BlocBuilder<TarotBloc, TarotState>(
                            builder: (context, state) {
                              final tarots = state.tarots;
                              return Center(
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(tarots.length, (
                                    index,
                                  ) {
                                    final tarot = tarots[index];
                                    return AnimatedOpacity(
                                      duration: Duration(milliseconds: 500),
                                      opacity:
                                          _isVisible.length > index &&
                                                  _isVisible[index]
                                              ? 1.0
                                              : 0.0,
                                      child: _tarotCard(tarot, () {
                                        context.read<TarotBloc>().add(
                                          SelectedTarot(index: tarot.id),
                                        );
                                        Navigator.pushNamed(
                                          context,
                                          StringConstant.navTarotViewCardDetail,
                                        );
                                      }),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tarotCard(Tarot tarot, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Container(
            height: 180,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(width: 1, color: Colors.black87),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(tarot.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
