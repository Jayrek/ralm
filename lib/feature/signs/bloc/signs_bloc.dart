import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ralm/models/sub_category.dart';

part 'signs_event.dart';
part 'signs_state.dart';

class SignsBloc extends Bloc<SignsEvent, SignsState> {
  SignsBloc() : super(SignsState()) {
    on<FetchSignsCategory>((event, emit) async {
      String jsonString = await rootBundle.loadString(
        'assets/json/ralm_signs_category.json',
      );
      final signsMapList = jsonDecode(jsonString) as List;
      final signsList =
          signsMapList
              .map((sign) => SubCategory.fromJson(sign))
              .where((sign) => sign.status == true)
              .toList();
      emit(state.copyWith(signs: signsList));
    });
  }
}
