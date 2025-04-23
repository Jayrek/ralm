import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/know_yourself/screen/ideal_type/bloc/ideal_type_bloc.dart';
import 'package:ralm/models/ideal_type.dart';

class IdealTypeTestScreen extends StatefulWidget {
  const IdealTypeTestScreen({super.key});

  @override
  State<IdealTypeTestScreen> createState() => _IdealTypeTestScreenState();
}

class _IdealTypeTestScreenState extends State<IdealTypeTestScreen> {
  int _currentIndex = 0;
  int _totalPoints = 0;
  bool isShowResultButton = false;

  void _onImageTap(int points, int maxIndex) {
    if (!isShowResultButton) {
      setState(() {
        _totalPoints += points;
        if (_currentIndex < maxIndex - 1) {
          _currentIndex++;
        } else {
          // Done with the quiz
          debugPrint("Total Points: $_totalPoints");
          // Navigate or show results
          setState(() {
            isShowResultButton = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final gender = (args is Map<String, dynamic>) ? args['gender'] : null;

    context.read<IdealTypeBloc>().add(
      FetchIdealType(gender: gender ?? 'female'),
    );

    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/ideal_type_bg/it_test_bg.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: BlocBuilder<IdealTypeBloc, IdealTypeState>(
              builder: (context, state) {
                if (state.idealTypeList.isEmpty)
                  return CircularProgressIndicator();

                final idealType = state.idealTypeList[_currentIndex];

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomButtonIconWidget(
                        icon: const Icon(Icons.arrow_circle_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildImagesPanel(
                      idealType,
                      () => state.idealTypeList.length,
                    ),
                    const SizedBox(height: 20),
                    isShowResultButton
                        ? CustomButtonRoundedWidget(
                          label: 'SHOW RESULT',
                          onPressed: () {
                            // context.read<ElementalSoulBloc>().add(
                            //   FetchElementalSoulQuestion(),
                            // );
                            Navigator.pushNamed(
                              context,
                              StringConstant.navIdealTYpeResult,
                              arguments: {
                                'gender': gender,
                                'points': _totalPoints,
                              },
                            );
                          },
                        )
                        : SizedBox(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesPanel(IdealType idealType, int Function() maxIndexFn) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            idealType.question.toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
                idealType.choices.map((choice) {
                  return GestureDetector(
                    onTap: () => _onImageTap(choice.points, maxIndexFn()),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white, width: 3),
                      ),
                      elevation: 4,
                      child: Image.asset(
                        choice.image,
                        height: 240,
                        width: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
