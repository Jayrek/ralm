import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/forest_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'forest_test_event.dart';
part 'forest_test_state.dart';

class ForestTestBloc extends Bloc<ForestTestEvent, ForestTestState> {
  ForestTestBloc() : super(ForestTestState()) {
    on<FetchForestTestResult>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/forest_test_result.json',
      );
      final forestTestMapList = jsonDecode(jsonString) as List;
      final forestTestList =
          forestTestMapList
              .map((category) => ForestTest.fromJson(category))
              .toList();

      emit(state.copyWith(forestTestResults: forestTestList));
    });

    on<SaveAvatarForestTest>((event, emit) async {
      await saveAvatarForestTest();
    });
    on<GetAvatarForestTest>((event, emit) async {
      final result = await getAvatarForestTest();
      emit(state.copyWith(avatarUnLocked: result ?? 'No'));
    });

    on<RemoveAvatarForestTest>((event, emit) async {
      await removeAvatarForestTest();
    });
  }

  static const _avatarForestTestKey = 'avatarForestTestKey';

  static Future<void> saveAvatarForestTest() async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_avatarForestTestKey);
    if (result == null) {
      await prefs.setString(_avatarForestTestKey, 'Yes');
    }
  }

  static Future<String?> getAvatarForestTest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarForestTestKey);
  }

  static Future<void> removeAvatarForestTest() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarForestTestKey);
  }
}
