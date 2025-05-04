import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/signs/screen/dream_sign/bloc/dream_sign_bloc.dart';

class DreamSignScreen extends StatelessWidget {
  const DreamSignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg/dream_sign_bg/ds_home_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
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
                                  FetchDreamSignDetail(
                                    dreamSignCategory: 'common',
                                  ),
                                );
                                Navigator.pushNamed(
                                  context,
                                  StringConstant.navDreamSignDetail,
                                  arguments: {'type': 'common'},
                                );
                              },
                            ),
                            _buildButtonWidget(
                              label: 'Nightmare',
                              onTap: () {
                                context.read<DreamSignBloc>().add(
                                  FetchDreamSignDetail(
                                    dreamSignCategory: 'nightmare',
                                  ),
                                );
                                Navigator.pushNamed(
                                  context,
                                  StringConstant.navDreamSignDetail,
                                  arguments: {'type': 'nightmare'},
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
                                  FetchDreamSignDetail(
                                    dreamSignCategory: 'animal',
                                  ),
                                );
                                Navigator.pushNamed(
                                  context,
                                  StringConstant.navDreamSignDetail,
                                  arguments: {'type': 'animal'},
                                );
                              },
                            ),
                            _buildButtonWidget(
                              label: 'Symbol',
                              onTap: () {
                                context.read<DreamSignBloc>().add(
                                  FetchDreamSignDetail(
                                    dreamSignCategory: 'symbol',
                                  ),
                                );
                                Navigator.pushNamed(
                                  context,
                                  StringConstant.navDreamSignDetail,
                                  arguments: {'type': 'symbol'},
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: CustomButtonIconWidget(
              icon: Icon(Icons.arrow_circle_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
        width: 180,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontFamily: 'Poppins')),
        ),
      ),
    );
  }
}
