import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/chinese_zodiac.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chinese_zodiac_event.dart';
part 'chinese_zodiac_state.dart';

class ChineseZodiacBloc extends Bloc<ChineseZodiacEvent, ChineseZodiacState> {
  ChineseZodiacBloc() : super(ChineseZodiacState()) {
    on<FetchChineseZodiac>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/chinese_zodiac.json',
      );
      final chineseMapList = jsonDecode(jsonString) as List;
      final chineseList =
          chineseMapList
              .map((zodiac) => ChineseZodiac.fromJson(zodiac))
              .toList();
      emit(state.copyWith(zodiacs: chineseList));
    });
    on<SelectedChineseZodiac>((event, emit) async {
      final year = event.year;
      if (event.notYear) {
        emit(state.copyWith(selectedZodiacIndex: year));
      } else {
        final zodiacs = state.zodiacs;

        final selectedIndex = zodiacs.indexWhere((zodiac) {
          return zodiac.years.contains(year);
        });

        if (selectedIndex != -1) {
          emit(state.copyWith(selectedZodiacIndex: selectedIndex));
        }
        if (event.isFromDiscover) {
          final zodiac = state.zodiacs[selectedIndex].name;
          add(SaveDiscoverZodiac(name: zodiac));
        }
      }
    });

    on<SaveAvatarChineseZodiac>((event, emit) async {
      await saveAvatarChineseZodiac(event.name);
    });
    on<GetAvatarChineseZodiac>((event, emit) async {
      final result = await getAvatarChineseZodiac();
      emit(state.copyWith(avatarUnLocked: result ?? 'No'));
    });

    on<RemoveAvatarChineseZodiac>((event, emit) async {
      await removeAvatarChineseZodiac();
    });

    on<SaveDiscoverZodiac>((event, emit) async {
      await _saveDiscoverZodiac(event.name);
      emit(state.copyWith(zodiacValue: event.name));
    });

    on<GetDiscoverZodiac>((event, emit) async {
      final zodiac = await _getDiscoverZodiac();
      emit(state.copyWith(zodiacValue: zodiac));
    });

    on<RemoveDiscoverZodiac>((event, emit) async {
      await _removeDiscoverZodiac();
      emit(state.copyWith(zodiacValue: ''));
    });
  }

  static const _avatarChineseZodiacKey = 'avatarChineseZodiacKey';

  static Future<void> saveAvatarChineseZodiac(String date) async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_avatarChineseZodiacKey);
    if (result == null) {
      await prefs.setString(_avatarChineseZodiacKey, date);
    }
  }

  static Future<String?> getAvatarChineseZodiac() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarChineseZodiacKey);
  }

  static Future<void> removeAvatarChineseZodiac() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_avatarChineseZodiacKey);
  }

  // zodiac
  static const _discoverZodiacKey = 'discoverZodiac';

  static Future<void> _saveDiscoverZodiac(String name) async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_discoverZodiacKey);
    if (result == null) {
      await prefs.setString(_discoverZodiacKey, name);
    }
  }

  static Future<String?> _getDiscoverZodiac() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_discoverZodiacKey);
  }

  static Future<void> _removeDiscoverZodiac() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_discoverZodiacKey);
  }
}
