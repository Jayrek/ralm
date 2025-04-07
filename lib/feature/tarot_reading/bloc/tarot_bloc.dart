import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/tarot.dart';

part 'tarot_event.dart';
part 'tarot_state.dart';

class TarotBloc extends Bloc<TarotEvent, TarotState> {
  TarotBloc() : super(TarotState()) {
    on<FetchTarotCards>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/tarot_card.json',
      );
      final tarotsMapList = jsonDecode(jsonString) as List;
      final tarotsList =
          tarotsMapList.map((tarot) => Tarot.fromJson(tarot)).toList();
      emit(state.copyWith(tarots: tarotsList));
    });
    on<SelectedCTarot>((event, emit) {
      final index = event.index;
      final tarots = state.tarots;

      final selectedIndex = tarots.indexWhere((tarot) {
        return tarot.id == index;
      });

      emit(state.copyWith(selectedIndex: selectedIndex));
    });
  }
}
