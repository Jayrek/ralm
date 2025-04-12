import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/elemental_soul.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/core/constants/string_constant.dart';

part 'elemental_soul_event.dart';
part 'elemental_soul_state.dart';

class ElementalSoulBloc extends Bloc<ElementalSoulEvent, ElementalSoulState> {
  ElementalSoulBloc() : super(ElementalSoulState()) {
    on<FetchElementalSoulQuestion>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/elemental_soul.json',
      );
      final elementalSoulMapList = jsonDecode(jsonString) as List;
      final elementalSoulList =
          elementalSoulMapList
              .map((category) => ElementalSoul.fromJson(category))
              .toList();

      final saved = await loadElementalProgress();

      emit(
        state.copyWith(
          elementalSoulQuestions: elementalSoulList,
          currentIndex: saved['index']!,
          totalScore: saved['score']!,
        ),
      );
    });
    on<SelectElementalSoulOption>((event, emit) async {
      final nextIndex = state.currentIndex + 1;
      final updatedScore = state.totalScore + event.option.score;

      await saveElementalProgress(nextIndex, updatedScore);

      final isCompleted = nextIndex >= state.elementalSoulQuestions.length;

      emit(
        state.copyWith(
          currentIndex: nextIndex,
          totalScore: updatedScore,
          elementalSoulResult:
              isCompleted
                  ? StringConstant.getElementalTypeFromScore(updatedScore)
                  : null,
        ),
      );

      // final nextIndex = state.currentIndex + 1;
      // final updatedScore = state.totalScore + event.option.score;

      // if (nextIndex < state.elementalSoulQuestions.length) {
      //   emit(state.copyWith(currentIndex: nextIndex, totalScore: updatedScore));
      // } else {
      //   emit(state.copyWith(currentIndex: nextIndex, totalScore: updatedScore));
      // }
    });
    on<ResetElementalSoulQuestion>((event, emit) async {
      await resetElementalProgress();
      emit(ElementalSoulState());
      add(FetchElementalSoulQuestion());
    });
  }
}
