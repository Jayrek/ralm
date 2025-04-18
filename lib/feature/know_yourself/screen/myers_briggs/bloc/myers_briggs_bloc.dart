import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/core/util/myers_briggs_shared_pref_util.dart';
import 'package:ralm/models/myers_briggs.dart';

part 'myers_briggs_event.dart';
part 'myers_briggs_state.dart';

class MyersBriggsBloc extends Bloc<MyersBriggsEvent, MyersBriggsState> {
  MyersBriggsBloc() : super(MyersBriggsState()) {
    on<FetchMyersBriggsQuestions>((event, emit) async {
      final savedProgress =
          await MyersBriggsSharedPrefUtil.loadMyersBriggsProgress();

      if (savedProgress != null && savedProgress.isNotEmpty) {
        emit(state.copyWith(myersBriggsList: savedProgress));
        return;
      }

      final jsonString = await rootBundle.loadString(
        'assets/json/myers_briggs.json',
      );
      final jsonList = jsonDecode(jsonString) as List;

      final questions = jsonList.map((e) => MyersBriggs.fromJson(e)).toList();

      emit(state.copyWith(myersBriggsList: questions));
      // String jsonString = await rootBundle.loadString(
      //   'assets/json/myers_briggs.json',
      // );
      // final myersBriggsMapList = jsonDecode(jsonString) as List;
      // final myersBriggsList =
      //     myersBriggsMapList
      //         .map((category) => MyersBriggs.fromJson(category))
      //         .toList();

      // emit(state.copyWith(myersBriggsList: myersBriggsList));
    });
    on<SelectMyersBriggsOption>((event, emit) async {
      final updatedList =
          state.myersBriggsList.map((question) {
            if (question.id == event.questionId) {
              return question.copyWith(selectedOption: event.selectedOption);
            }
            return question;
          }).toList();

      await MyersBriggsSharedPrefUtil.saveMyersBriggsProgress(updatedList);

      emit(state.copyWith(myersBriggsList: updatedList));
    });
    on<ClearMyersBriggsProgress>((event, emit) async {
      await MyersBriggsSharedPrefUtil.clearMyersBriggsProgress();
    });
  }
}
