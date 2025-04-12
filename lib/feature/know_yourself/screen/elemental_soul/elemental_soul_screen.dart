import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';

class ElementalSoulScreen extends StatelessWidget {
  const ElementalSoulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: _buildIntroScreen(context),
    );
  }

  Widget _buildIntroScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Elemental Soul Personality Test'.toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Are you ready to deep within soul and discover your true element?',
          ),
          Text('Take this fun quiz to play wtih elements'),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              context.read<ElementalSoulBloc>().add(
                FetchElementalSoulQuestion(),
              );
              Navigator.pushNamed(context, StringConstant.navElementalSoulTest);
            },
            child: Container(
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Center(child: Text('START TEST')),
            ),
          ),
        ],
      ),
    );
  }
}
