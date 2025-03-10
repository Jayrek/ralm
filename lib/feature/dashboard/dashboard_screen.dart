import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/dashboard/dashboard/dashboard_bloc.dart';

import '../../core/shared/widget/custom_button_icon_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.purple.shade300,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'R',
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge?.copyWith(fontSize: 120),
                          ),
                          Text(
                            ' ALM',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontSize: 50,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        StringConstant.discoverYourself.toUpperCase(),
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          fontFamily: StringConstant.fontTinos,
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 10,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children:
                            state.categories.map((category) {
                              return CustomButtonRoundedWidget(
                                label: category.categoryName,
                                onPressed: () {},
                              );
                            }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButtonIconWidget(
                            icon: Icon(Icons.music_note),
                            onPressed: () {},
                          ),
                          CustomButtonIconWidget(
                            icon: Icon(Icons.logout),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  // this is the avatar
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
