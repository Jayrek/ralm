import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/animated_tarot_cad_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/feature/tarot_reading/bloc/tarot_bloc.dart';
import 'package:ralm/models/tarot.dart';

class TarotCardScreen extends StatefulWidget {
  const TarotCardScreen({super.key});

  @override
  State<TarotCardScreen> createState() => _TarotCardScreenState();
}

class _TarotCardScreenState extends State<TarotCardScreen> {
  List<bool> _isVisible = [];

  @override
  void initState() {
    super.initState();

    context.read<TarotBloc>()
      ..add(ResetPickingTarot())
      ..add(FetchTarotCards(isShuffle: true));
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
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg/tarot_bg/tc_card_picking_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomButtonIconWidget(
                            icon: Icon(Icons.arrow_circle_left),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        _threeCards(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(indent: 20, endIndent: 20),
                        ),
                        Text(
                          'Choose 3 Cards',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 10),
                        BlocListener<TarotBloc, TarotState>(
                          listenWhen:
                              (previous, current) =>
                                  previous.tarots != current.tarots &&
                                  current.tarots.isNotEmpty,
                          listener: (context, state) {
                            _animateCards(state.tarots.length);
                          },
                          child: Center(
                            child: BlocBuilder<TarotBloc, TarotState>(
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
                                      final isPicked = state.pickedTarots.any(
                                        (picked) => picked.id == tarot.id,
                                      );

                                      return AnimatedOpacity(
                                        duration: Duration(milliseconds: 500),
                                        opacity:
                                            _isVisible.length > index &&
                                                    _isVisible[index]
                                                ? 1.0
                                                : 0.0,
                                        child: _tarotCard(
                                          tarot: tarot,
                                          isPicked: isPicked,
                                          onTap: () {
                                            context.read<TarotBloc>().add(
                                              PickedTarot(tarot: tarot),
                                            );
                                            debugPrint('tarot: $tarot');
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: BlocSelector<TarotBloc, TarotState, List<Tarot>>(
                    selector: (state) => state.pickedTarots,
                    builder: (context, pickedTarots) {
                      return pickedTarots.length == 3
                          ? Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await savePickedTarotsWithTimeout(
                                    pickedTarots,
                                  );
                                  if (!context.mounted) return;
                                  Navigator.pushNamed(
                                    context,
                                    StringConstant.navTarotPickedCard,
                                    arguments: pickedTarots,
                                  );
                                },
                                child: Text('View Result'),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  context.read<TarotBloc>()
                                    ..add(ResetPickingTarot())
                                    ..add(FetchTarotCards(isShuffle: true));
                                  _animateCards(
                                    context
                                        .read<TarotBloc>()
                                        .state
                                        .tarots
                                        .length,
                                  );
                                },
                                child: Text(
                                  'RESET',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                          : SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _threeCards() {
    return BlocSelector<TarotBloc, TarotState, List<Tarot>>(
      selector: (state) => state.pickedTarots,
      builder: (context, pickedTarots) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // If tarot exists at index, pass it; else pass null
            final tarot =
                index < pickedTarots.length ? pickedTarots[index] : null;
            return AnimatedTarotCardWidget(tarot: tarot);
          }),
        );
      },
    );
  }

  Widget _tarotCard({
    required Tarot tarot,
    required bool isPicked,
    required Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: InkWell(
        onTap: isPicked ? null : onTap,
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
              image:
                  isPicked
                      ? DecorationImage(
                        image: AssetImage(tarot.image),
                        fit: BoxFit.cover,
                      )
                      : DecorationImage(
                        image: AssetImage(
                          'assets/image/tarot/card_backcover.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
