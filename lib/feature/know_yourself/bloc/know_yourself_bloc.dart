import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/sub_category.dart';

part 'know_yourself_event.dart';
part 'know_yourself_state.dart';

class KnowYourselfBloc extends Bloc<KnowYourselfEvent, KnowYourselfState> {
  KnowYourselfBloc() : super(KnowYourselfState()) {
    on<FetchKnowYourselfCategory>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/ralm_know_yourself_category.json',
      );
      final subCategoryMapList = jsonDecode(jsonString) as List;
      final subCategoryList =
          subCategoryMapList
              .map((category) => SubCategory.fromJson(category))
              .where((category) => category.status == true)
              .toList();
      emit(state.copyWith(subCategories: subCategoryList));
    });
  }
}
