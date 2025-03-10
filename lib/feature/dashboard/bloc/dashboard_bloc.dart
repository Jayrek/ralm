import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/category.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<FetchCategory>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/ralm_category.json',
      );
      final categoryMapList = jsonDecode(jsonString) as List;
      final categoryList =
          categoryMapList
              .map((category) => Category.fromJson(category))
              .where((category) => category.status == true)
              .toList();
      emit(state.copyWith(categories: categoryList));
    });
  }
}
