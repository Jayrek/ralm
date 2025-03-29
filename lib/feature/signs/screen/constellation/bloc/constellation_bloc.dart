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
  }
}
