import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/core/shared/widget/custom_button_rounded_widget.dart';
import 'package:ralm/feature/signs/screen/secret_crush/bloc/secret_crush_bloc.dart';

class SecretCrushScreen extends StatelessWidget {
  const SecretCrushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomButtonIconWidget(
                  icon: Icon(Icons.arrow_circle_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '28 Sign someone might have a secret crush on you'
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontSize: 60, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      CustomButtonRoundedWidget(
                        label: 'READ',
                        onPressed: () {
                          context.read<SecretCrushBloc>().add(
                            FetchSecretCrush(),
                          );
                          Navigator.pushNamed(
                            context,
                            StringConstant.navSecretCrushDetail,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
