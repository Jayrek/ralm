import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/dream_sign.dart';

part 'secret_crush_event.dart';
part 'secret_crush_state.dart';

class SecretCrushBloc extends Bloc<SecretCrushEvent, SecretCrushState> {
  SecretCrushBloc() : super(SecretCrushState()) {
    on<FetchSecretCrush>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/secret_crush.json',
      );

      final secretCrushMapList = jsonDecode(jsonString) as List;
      final secretCrushList =
          secretCrushMapList
              .map((category) => DreamSign.fromJson(category))
              .toList();
      emit(state.copyWith(secretCrushList: secretCrushList));
    });
  }
}
