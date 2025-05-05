import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(DiscoverState()) {
    on<SaveZodiacFromBDate>((event, emit) async {
      await _saveDiscoverBday(event.bday);
      emit(state.copyWith(bday: event.bday));
    });

    on<GetZodiacFromBDate>((event, emit) async {
      final bday = await _getDiscoverBday();
      emit(state.copyWith(bday: bday));
    });

    on<RemoveZodiacFromBDate>((event, emit) async {
      await _removeDiscoverBday();
      emit(state.copyWith(bday: ''));
    });

    on<SaveDiscoverUserName>((event, emit) async {
      await _saveDiscoverUserName(event.name);
      emit(state.copyWith(userName: event.name));
    });

    on<GetDiscoverUserName>((event, emit) async {
      final name = await _getDiscoverUserName();
      emit(state.copyWith(userName: name));
    });

    on<RemoveDiscoverUserName>((event, emit) async {
      await _removeDiscoverUserName();
      emit(state.copyWith(userName: ''));
    });
  }

  // name
  static const _discoverUserNameKey = 'discoverUserName';

  static Future<void> _saveDiscoverUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();

    // final result = prefs.getString(_discoverUserNameKey);
    // if (result == null) {
    await prefs.setString(_discoverUserNameKey, name);
    // }
  }

  static Future<String?> _getDiscoverUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_discoverUserNameKey);
  }

  static Future<void> _removeDiscoverUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_discoverUserNameKey);
  }

  // bday
  static const _discoverBdayKey = 'discoverBday';

  static Future<void> _saveDiscoverBday(String soul) async {
    final prefs = await SharedPreferences.getInstance();

    // final result = prefs.getString(_discoverBdayKey);
    // if (result == null) {
    await prefs.setString(_discoverBdayKey, soul);
    // }
  }

  static Future<String?> _getDiscoverBday() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_discoverBdayKey);
  }

  static Future<void> _removeDiscoverBday() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_discoverBdayKey);
  }
}
