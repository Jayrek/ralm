import 'package:flutter/material.dart';

class CustomButtonIconWidget extends StatelessWidget {
  const CustomButtonIconWidget({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final Widget icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, color: Colors.white, onPressed: () {});
  }
}
