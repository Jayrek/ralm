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
              Padding(
                padding: const EdgeInsets.all(30),
                child: BlocBuilder<MyersBriggsBloc, MyersBriggsState>(
                  builder: (context, state) {
                    final type = state.personality;
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                type?.imageP ?? '',
                                height: 400,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Your score results shows you are'),
                                  SizedBox(height: 20),
                                  Text(
                                    type?.description ?? '',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(height: 30),
                                  Text('aka ${type?.description}'),
                                  SizedBox(height: 30),
                                  Text(
                                    "\"${type?.akaDescription}\"".toUpperCase(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 20),
                                  Text("\"${type?.information}\""),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.greenAccent.shade200,
                          height: 40,
                          width: double.infinity,
                          child: Center(child: Text('Scroll down for more')),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Image.asset(type?.imageC ?? '', height: 400),
                          ],
                        ),

                        Container(
                          color: Colors.green.shade700,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            spacing: 40,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Strength'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          (type?.strength ?? [])
                                              .map(
                                                (s) => Text(
                                                  '- $s',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weaknesses'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          (type?.weakness ?? [])
                                              .map(
                                                (s) => Text(
                                                  '- $s',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Career'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          (type?.weakness ?? [])
                                              .map(
                                                (s) => Text(
                                                  '- $s',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
