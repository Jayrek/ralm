import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/core/constants/string_constant.dart';
import 'package:ralm/core/util/shared_pref_util.dart';
import 'package:ralm/models/elemental_soul.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'your_color_event.dart';
part 'your_color_state.dart';

class YourColorBloc extends Bloc<YourColorEvent, YourColorState> {
  YourColorBloc() : super(YourColorState()) {
    on<FetchYourColorQuestion>((event, emit) async {
      String jsonString = await rootBundle.loadString('assets/json/color.json');
      final yourColorMapList = jsonDecode(jsonString) as List;
      final yourColorList =
          yourColorMapList
              .map((category) => ElementalSoul.fromJson(category))
              .toList();

      final saved = await loadYourColorProgress();

      emit(
        state.copyWith(
          yourColorQuestions: yourColorList,
          currentIndex: saved['index']!,
          totalScore: saved['score']!,
        ),
      );
    });
    on<SelectYourColorOption>((event, emit) async {
      final nextIndex = state.currentIndex + 1;
      final updatedScore = state.totalScore + event.option.score;

      await saveElementalProgress(nextIndex, updatedScore);

      final isCompleted = nextIndex >= state.yourColorQuestions.length;

      emit(
        state.copyWith(
          currentIndex: nextIndex,
          totalScore: updatedScore,
          yourColorResult:
              isCompleted
                  ? StringConstant.getColorResultFromScore(updatedScore)
                  : null,
        ),
      );
    });
    on<ResetYourColorQuestion>((event, emit) async {
      await resetElementalProgress();
      emit(YourColorState());
      add(FetchYourColorQuestion());
    });

    on<SaveAvatarYourColor>((event, emit) async {
      await saveAvatarYourColor();
    });
    on<GetAvatarYourColor>((event, emit) async {
      final result = await getAvatarYourColor();
      emit(state.copyWith(avatarUnLocked: result ?? 'No'));
    });

    on<RemoveAvatarYourColor>((event, emit) async {
      await removeAvatarYourColor();
    });
  }

  static const _avatarYourColorKey = 'avatarYourColorKey';

  static Future<void> saveAvatarYourColor() async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_avatarYourColorKey);
    if (result == null) {
      await prefs.setString(_avatarYourColorKey, 'Yes');
    }
  }

  static Future<String?> getAvatarYourColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarYourColorKey);
  }

  static Future<void> removeAvatarYourColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarYourColorKey);
  }
}
