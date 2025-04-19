import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/screen/ideal_type/bloc/ideal_type_bloc.dart';
import 'package:ralm/models/ideal_type.dart';

class IdealTypeTestScreen extends StatelessWidget {
  const IdealTypeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    context.read<IdealTypeBloc>().add(FetchIdealType(gender: args['gender']));

    debugPrint('args: ${args['gender']}');
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: BlocConsumer<IdealTypeBloc, IdealTypeState>(
            listener: (context, state) {
              debugPrint('state: ${state.idealTypeList}');
            },
            builder: (context, state) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomButtonIconWidget(
                      icon: Icon(Icons.arrow_circle_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  ...state.idealTypeList.map(
                    (idealType) => _buildImagesPanel(idealType),
                  ),
                  // _buildImagesPanel(idealType),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImagesPanel(IdealType idealType) {
    return Column(
      children: [
        Text(idealType.question),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              idealType.choices.map((choice) {
                return Column(
                  children: [
                    Image.asset(choice.image, width: 100, height: 100),
                    const SizedBox(height: 5),
                    Text('${choice.points} points'),
                  ],
                );
              }).toList(),
        ),
      ],
    );
  }
}
