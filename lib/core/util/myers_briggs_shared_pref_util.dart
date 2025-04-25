import 'dart:convert';

import 'package:ralm/models/myers_briggs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyersBriggsSharedPrefUtil {
  static const _key = 'myers_briggs_progress';
  static const _resultKey = 'myers_briggs_result';

  static Future<List<MyersBriggs>?> loadMyersBriggsProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      return (decoded as List)
          .map((item) => MyersBriggs.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }

  static Future<void> saveMyersBriggsProgress(List<MyersBriggs> list) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(list.map((q) => q.toJson()).toList());

    await prefs.setString(_key, jsonString);
  }

  static Future<void> clearMyersBriggsProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<void> saveMyersBriggsResult(String myersResult) async {
    final prefs = await SharedPreferences.getInstance();

    final result = prefs.getString(_resultKey);
    if (result == null) {
      await prefs.setString(_resultKey, myersResult);
    }
  }

  static Future<String?> getMyersBriggsResult() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_resultKey);
  }

  static Future<void> removeMyersBriggsResult() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_resultKey);
  }
}
