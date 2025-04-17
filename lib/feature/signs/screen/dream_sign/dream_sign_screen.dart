import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/feature/signs/screen/dream_sign/bloc/dream_sign_bloc.dart';

class DreamSignScreen extends StatelessWidget {
  const DreamSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  _buildButtonWidget(
                    label: 'Common',
                    onTap: () {
                      context.read<DreamSignBloc>().add(
                        FetchDreamSignDetail(dreamSignCategory: 'common'),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navDreamSignDetail,
                      );
                    },
                  ),
                  _buildButtonWidget(
                    label: 'Nightmare',
                    onTap: () {
                      context.read<DreamSignBloc>().add(
                        FetchDreamSignDetail(dreamSignCategory: 'nightmare'),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navDreamSignDetail,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButtonWidget(
                    label: 'Animal',
                    onTap: () {
                      context.read<DreamSignBloc>().add(
                        FetchDreamSignDetail(dreamSignCategory: 'animal'),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navDreamSignDetail,
                      );
                    },
                  ),
                  _buildButtonWidget(
                    label: 'Symbol',
                    onTap: () {
                      context.read<DreamSignBloc>().add(
                        FetchDreamSignDetail(dreamSignCategory: 'symbol'),
                      );
                      Navigator.pushNamed(
                        context,
                        StringConstant.navDreamSignDetail,
                      );
                    },
                  ),
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
        ),
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
