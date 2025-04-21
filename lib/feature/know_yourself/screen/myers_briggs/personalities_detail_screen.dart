import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/shared/widget/custom_button_icon_widget.dart';
import 'package:ralm/feature/know_yourself/screen/myers_briggs/bloc/myers_briggs_bloc.dart';

class PersonalitiesDetailScreen extends StatelessWidget {
  const PersonalitiesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int id = args['id'];
    context.read<MyersBriggsBloc>().add(FetchPersonalitiesById(id: id));
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
                  icon: const Icon(Icons.arrow_circle_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                builder: (context, state) {
                  final type = state.personality;
                  return Text(type?.description ?? '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
