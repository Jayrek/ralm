import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralm/models/ideal_type.dart';

part 'ideal_type_event.dart';
part 'ideal_type_state.dart';

class IdealTypeBloc extends Bloc<IdealTypeEvent, IdealTypeState> {
  IdealTypeBloc() : super(IdealTypeState()) {
    on<FetchIdealType>((event, emit) async {
      final genderString =
          event.gender == 'female'
              ? 'assets/json/ideal_type_girl.json'
              : 'assets/json/ideal_type_boy.json';
      String jsonString = await rootBundle.loadString(genderString);
      final idealTypeMapList = jsonDecode(jsonString) as List;
      final idealTypeList =
          idealTypeMapList.map((type) => IdealType.fromJson(type)).toList();

      emit(state.copyWith(idealTypeList: idealTypeList));
    });
  }
}
