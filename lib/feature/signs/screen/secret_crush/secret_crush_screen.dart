import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/signs/screen/secret_crush/bloc/secret_crush_bloc.dart';

class SecretCrushScreen extends StatelessWidget {
  const SecretCrushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '28 Sign someone might have a secret crush on you'
                    .toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 60,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  context.read<SecretCrushBloc>().add(FetchSecretCrush());
                  Navigator.pushNamed(
                    context,
                    StringConstant.navSecretCrushDetail,
                  );
                },
                child: Container(
                  width: 150,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Center(child: Text('READ')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
