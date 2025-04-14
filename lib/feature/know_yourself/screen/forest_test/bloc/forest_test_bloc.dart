import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/forest_test.dart';

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
  }
}
