import 'package:flutter/material.dart';

class DreamSignScreen extends StatelessWidget {
  const DreamSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Dream Sign',
            style: Theme.of(
              context,
            ).textTheme.displayLarge?.copyWith(fontSize: 90),
          ),
          SizedBox(height: 40),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButtonWidget(label: 'Common', onTap: () {}),
              _buildButtonWidget(label: 'Nightmare', onTap: () {}),
            ],
          ),
          SizedBox(height: 40),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButtonWidget(label: 'Animal', onTap: () {}),
              _buildButtonWidget(label: 'Symbol', onTap: () {}),
            ],
          ),
          SizedBox(height: 40),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonWidget({
    required String label,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
        ),
        child: Center(child: Text(label)),
      ),
    );
  }
}
