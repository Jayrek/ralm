import 'dart:convert';
import 'package:ralm/models/test_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryStorage {
  static const _key = 'test_history';

  static Future<void> saveHistoryItem(TestHistory item) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existing = prefs.getStringList(_key) ?? [];

    final newItemJson = json.encode(item.toJson());
    existing.add(newItemJson);

    await prefs.setStringList(_key, existing);
  }

  static Future<List<TestHistory>> getHistoryList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList(_key) ?? [];

    return items
        .map((item) => TestHistory.fromJson(json.decode(item)))
        .toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
