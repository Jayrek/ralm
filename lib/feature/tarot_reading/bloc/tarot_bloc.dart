import 'dart:convert';

import 'package:flutter/material.dart';
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
      if (event.isShuffle) {
        tarotsList.shuffle();
      }
      emit(state.copyWith(tarots: tarotsList));
    });
    on<SelectedTarot>((event, emit) {
      final index = event.index;
      final tarots = state.tarots;

      final selectedIndex = tarots.indexWhere((tarot) {
        return tarot.id == index;
      });

      emit(state.copyWith(selectedIndex: selectedIndex));
    });
    on<PickedTarot>((event, emit) {
      final selectedTarot = event.tarot;

      emit(state.copyWith(pickingTries: state.pickingTries + 1));
      debugPrint('pickingTries: ${state.pickingTries}');

      if (state.pickingTries <= 3) {
        final pickedTarots = List<Tarot>.from(state.pickedTarots);
        pickedTarots.add(selectedTarot);
        emit(state.copyWith(pickedTarots: pickedTarots));
        // TODO: save shared_preference here
      }
    });
    on<ResetPickingTarot>((event, emit) {
      emit(
        state.copyWith(
          tarots: const [],
          pickedTarots: const [],
          selectedIndex: 0,
          pickingTries: 0,
        ),
      );
    });
  }
}
