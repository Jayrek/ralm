import 'package:flutter/material.dart';

class CustomButtonRoundedWidget extends StatelessWidget {
  const CustomButtonRoundedWidget({
    required this.label,
    required this.onPressed,
    this.width = 160,
    super.key,
  });

  final String label;
  final Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: width,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            // backgroundColor: Colors.purple.shade300,
            side: BorderSide(color: Colors.white, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
