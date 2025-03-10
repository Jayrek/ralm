import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/feature/signs/bloc/signs_bloc.dart';

import '../../../core/shared/widget/custom_button_icon_widget.dart';
import '../../../core/shared/widget/custom_button_rounded_widget.dart';
import '../../../core/shared/widget/custom_sub_category_widget.dart';

class SignsScreen extends StatelessWidget {
  const SignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SignsBloc>().add(FetchSignsCategory());
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CustomButtonRoundedWidget(label: 'Signs', onPressed: () {}),
                  CustomButtonIconWidget(
                    icon: Icon(Icons.arrow_circle_left),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              BlocBuilder<SignsBloc, SignsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      children:
                          state.signs.map((sign) {
                            return CustomSubCategoryWidget(
                              name: sign.categoryName,
                              description: sign.categoryDescription,
                              onPressed: () {},
                            );
                          }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
