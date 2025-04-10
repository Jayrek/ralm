import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ralm/models/avatar.dart';
import 'package:ralm/models/tarot.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePickedTarotsWithTimeout(List<Tarot> pickedCards) async {
  final prefs = await SharedPreferences.getInstance();

  final existing = prefs.getStringList('picked_cards');
  final savedTimestamp = prefs.getInt('picked_cards_timestamp');

  final now = DateTime.now();

  // If timestamp exists, calculate the time difference
  if (savedTimestamp != null) {
    final savedTime = DateTime.fromMillisecondsSinceEpoch(savedTimestamp);
    final difference = now.difference(savedTime);

    // if (difference.inHours < 24 && existing != null && existing.isNotEmpty) {
    if (difference.inMinutes < 1 && existing != null && existing.isNotEmpty) {
      debugPrint('Less than 24 hours since last save. Skipping save.');
      return;
    }
  }

  // Save new cards
  final List<String> encodedCards =
      pickedCards.map((card) => jsonEncode(card.toJson())).toList();

  await prefs.setStringList('picked_cards', encodedCards);
  await prefs.setInt('picked_cards_timestamp', now.millisecondsSinceEpoch);

  debugPrint('Picked cards saved with new timestamp.');
}

Future<List<Tarot>> loadPickedCards() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? encodedCards = prefs.getStringList('picked_cards');

  if (encodedCards == null) return [];

  final tarot =
      encodedCards
          .map((cardStr) => Tarot.fromJson(jsonDecode(cardStr)))
          .toList();

  debugPrint('tarott: $tarot');
  return tarot;
}

Future<void> resetPickedTarots() async {
  final prefs = await SharedPreferences.getInstance();

  final savedTimestamp = prefs.getInt('picked_cards_timestamp');

  if (savedTimestamp == null) {
    debugPrint('No timestamp found. Nothing to reset.');
    return;
  }

  final savedTime = DateTime.fromMillisecondsSinceEpoch(savedTimestamp);
  final now = DateTime.now();
  final difference = now.difference(savedTime);

  // if (difference.inHours >= 24) {
  if (difference.inMinutes >= 1) {
    await prefs.remove('picked_cards');
    await prefs.remove('picked_cards_timestamp');
    debugPrint('24 hours passed. Picked cards and timestamp cleared.');
  } else {
    final remaining = 1 - difference.inMinutes;
    debugPrint('Not yet 24 hours. Wait $remaining more hour(s) before reset.');
  }
}
