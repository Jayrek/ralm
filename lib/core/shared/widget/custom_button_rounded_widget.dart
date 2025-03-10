import 'package:flutter/material.dart';

class CustomButtonRoundedWidget extends StatelessWidget {
  const CustomButtonRoundedWidget({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 180,
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: BorderSide(color: Colors.white, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
