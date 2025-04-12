import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/dream_sign.dart';

part 'dream_sign_event.dart';
part 'dream_sign_state.dart';

class DreamSignBloc extends Bloc<DreamSignEvent, DreamSignState> {
  DreamSignBloc() : super(DreamSignState()) {
    on<FetchDreamSignDetail>((event, emit) async {
      String assetString = '';
      switch (event.dreamSignCategory) {
        case 'common':
          assetString = 'assets/json/dream_sign_common.json';
          break;
        case 'nightmare':
          assetString = 'assets/json/dream_sign_nigthmare.json';
          break;
        case 'animal':
          assetString = 'assets/json/dream_sign_animals.json';
          break;
        case 'symbol':
          assetString = 'assets/json/dream_sign_symbol.json';
          break;
      }

      String jsonString = await rootBundle.loadString(assetString);

      final dreamSignMapList = jsonDecode(jsonString) as List;
      final dreamSignList =
          dreamSignMapList
              .map((category) => DreamSign.fromJson(category))
              .toList();
      emit(state.copyWith(dreamSignDetailList: dreamSignList));
    });
  }
}
