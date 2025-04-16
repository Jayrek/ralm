import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/myers_briggs.dart';

part 'myers_briggs_event.dart';
part 'myers_briggs_state.dart';

class MyersBriggsBloc extends Bloc<MyersBriggsEvent, MyersBriggsState> {
  MyersBriggsBloc() : super(MyersBriggsState()) {
    on<FetchMyersBriggsQuestions>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/myers_briggs.json',
      );
      final myersBriggsMapList = jsonDecode(jsonString) as List;
      final myersBriggsList =
          myersBriggsMapList
              .map((category) => MyersBriggs.fromJson(category))
              .toList();

      emit(state.copyWith(myersBriggsList: myersBriggsList));
    });
  }
}
