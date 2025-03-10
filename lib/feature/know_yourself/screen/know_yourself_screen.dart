import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/bloc/know_yourself_bloc.dart';

import '../../../core/shared/widget/custom_button_rounded_widget.dart';
import '../../../core/shared/widget/custom_sub_category_widget.dart';

class KnowYourSelfScreen extends StatelessWidget {
  const KnowYourSelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<KnowYourselfBloc>().add(FetchKnowYourselfCategory());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple.shade300,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomButtonRoundedWidget(
                      label: 'Know Yourself',
                      onPressed: () {},
                    ),
                    CustomButtonIconWidget(
                      icon: Icon(Icons.arrow_circle_left),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                BlocBuilder<KnowYourselfBloc, KnowYourselfState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        children:
                            state.subCategories.map((subCategory) {
                              return CustomSubCategoryWidget(
                                name: subCategory.categoryName,
                                description: subCategory.categoryDescription,
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
      ),
    );
  }
}
