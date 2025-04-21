import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class PersonalitiesScreen extends StatefulWidget {
  const PersonalitiesScreen({super.key});

  @override
  State<PersonalitiesScreen> createState() => _PersonalitiesScreenState();
}

class _PersonalitiesScreenState extends State<PersonalitiesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyersBriggsBloc>().add(const FetchPersonalities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/myers_briggs_bg/mb_personality_bg.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                  BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                    builder: (context, state) {
                      final personalities = state.personalities;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: personalities.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 2.5,
                            ),
                        itemBuilder: (context, index) {
                          final personality = personalities[index];
                          final columnIndex = index % 4;

                          final List<Color> columnColors = [
                            Colors.blue.shade200,
                            Colors.teal.shade400,
                            Colors.purple.shade200,
                            Colors.orange.shade300,
                          ];

                          final buttonColor = columnColors[columnIndex];

                          return Center(
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(30),
                              color:
                                  Colors
                                      .transparent, // keep background color from button
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: buttonColor.withOpacity(0.8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 20,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: BorderSide(
                                    color: Colors.yellow.shade900,
                                    width: 5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(230),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    StringConstant
                                        .navMyersBriggsPersonalitiesDetail,
                                    arguments: {'id': personality.id},
                                  );
                                },
                                child: Text(
                                  personality.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.purple.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
