import 'package:flutter/material.dart';

import 'custom_button_rounded_widget.dart';

class CustomSubCategoryWidget extends StatelessWidget {
  const CustomSubCategoryWidget({
    required this.name,
    required this.description,
    required this.onPressed,
    super.key,
  });

  final String name;
  final String description;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.purple.shade800,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 180),
                Text(
                  description.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButtonRoundedWidget(
          label: name.toUpperCase(),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
