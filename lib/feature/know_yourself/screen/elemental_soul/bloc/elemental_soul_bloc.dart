import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/elemental_soul.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      // final saved = await loadElementalProgress();

      emit(
        state.copyWith(
          elementalSoulQuestions: elementalSoulList,
          // currentIndex: saved['index']!,
          // totalScore: saved['score']!,
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

    on<SaveAvatarElementalSoul>((event, emit) async {
      await saveAvatarElementalSoul(event.soul);
    });
    on<GetAvatarElementalSoul>((event, emit) async {
      final result = await getAvatarElementalSoul();
      emit(state.copyWith(avatarUnLocked: result ?? 'No'));
    });

    on<RemoveAvatarElementalSoul>((event, emit) async {
      await removeAvatarElementalSoul();
      emit(state.copyWith(avatarUnLocked: 'No'));
    });
  }

  static const _avatarElementalSoulKey = 'avatarElementalSoulKey';

  static Future<void> saveAvatarElementalSoul(String soul) async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_avatarElementalSoulKey);
    if (result == null) {
      await prefs.setString(_avatarElementalSoulKey, soul);
    }
  }

  static Future<String?> getAvatarElementalSoul() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarElementalSoulKey);
  }

  static Future<void> removeAvatarElementalSoul() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarElementalSoulKey);
  }
}
