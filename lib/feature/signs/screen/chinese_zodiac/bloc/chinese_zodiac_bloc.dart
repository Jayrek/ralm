import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/chinese_zodiac.dart';

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
      }
    });
  }
}
