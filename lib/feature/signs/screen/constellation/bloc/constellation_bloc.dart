import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/zodiac.dart';

part 'constellation_event.dart';
part 'constellation_state.dart';

class ConstellationBloc extends Bloc<ConstellationEvent, ConstellationState> {
  ConstellationBloc() : super(ConstellationState()) {
    on<FetchConstellationZodiac>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/constellation_zodiac.json',
      );
      final constellationMapList = jsonDecode(jsonString) as List;
      final constellationList =
          constellationMapList
              .map((zodiac) => Zodiac.fromJson(zodiac))
              .toList();
      emit(state.copyWith(zodiacs: constellationList));
    });
    on<SelectedConstellationZodiac>((event, emit) async {
      final zodiacs = state.zodiacs;
      final matchedZodiac = findZodiacSign(event.selectedDate, zodiacs);

      if (matchedZodiac != null) {
        final index = zodiacs.indexOf(matchedZodiac);
        emit(state.copyWith(selectedZodiacIndex: index));
      }
      // final dateRange = event.dateRange;
      // final zodiacs = state.zodiacs;

      // final selectedIndex = zodiacs.indexWhere((zodiac) {
      //   return zodiac.dateRange.contains(dateRange);
      // });

      // if (selectedIndex != -1) {
      //   emit(state.copyWith(selectedZodiacIndex: selectedIndex));
      // }
    });
    on<SelectedConstellationIndividualZodiac>((event, emit) async {
      final dateRange = event.dateRange;
      final zodiacs = state.zodiacs;

      final selectedIndex = zodiacs.indexWhere((zodiac) {
        return zodiac.dateRange.contains(dateRange);
      });

      if (selectedIndex != -1) {
        emit(state.copyWith(selectedZodiacIndex: selectedIndex));
      }
    });
  }
}

Zodiac? findZodiacSign(DateTime date, List<Zodiac> zodiacList) {
  for (var zodiac in zodiacList) {
    if (_isDateInRange(date, zodiac.dateRange)) {
      return zodiac;
    }
  }
  return null;
}

bool _isDateInRange(DateTime date, String range) {
  const int year = 2000;
  final parts = range.split(' - ');
  if (parts.length != 2) return false;

  final start = _parseDate(parts[0], year);
  final end = _parseDate(parts[1], year);
  final normalized = DateTime(year, date.month, date.day);

  final adjustedEnd = end.isBefore(start) ? end.add(Duration(days: 365)) : end;
  final adjustedDate =
      normalized.isBefore(start) && adjustedEnd.isAfter(start)
          ? normalized.add(Duration(days: 365))
          : normalized;

  return !adjustedDate.isBefore(start) && !adjustedDate.isAfter(adjustedEnd);
}

DateTime _parseDate(String dateString, int year) {
  final months = {
    'January': 1,
    'February': 2,
    'March': 3,
    'April': 4,
    'May': 5,
    'June': 6,
    'July': 7,
    'August': 8,
    'September': 9,
    'October': 10,
    'November': 11,
    'December': 12,
  };

  final parts = dateString.split(' ');
  final month = months[parts[0]]!;
  final day = int.parse(parts[1]);

  return DateTime(year, month, day);
}
