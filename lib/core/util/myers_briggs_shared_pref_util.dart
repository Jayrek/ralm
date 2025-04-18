import 'dart:convert';

import 'package:ralm/models/myers_briggs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyersBriggsSharedPrefUtil {
  static const _key = 'myers_briggs_progress';

  static Future<List<MyersBriggs>?> loadMyersBriggsProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('myers_briggs_progress');

    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      return (decoded as List)
          .map((item) => MyersBriggs.fromJson(item))
          .toList();
    } else {
      return [];
    }
    // final prefs = await SharedPreferences.getInstance();
    // final jsonString = prefs.getString(_key);

    // if (jsonString == null) return null;

    // final decoded = jsonDecode(jsonString) as List;
    // return decoded.map((e) => MyersBriggs.fromJson(e)).toList();
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
}
