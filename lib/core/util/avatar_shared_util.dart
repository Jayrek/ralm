import 'dart:convert';

import 'package:ralm/models/avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarSharedUtil {
  static final List<Avatar> _defaultAvatars = [
    Avatar(
      id: 1,
      category: 'one_avatar',
      image: '',
      isSelected: true,
      isLocked: false,
    ),
    Avatar(
      id: 2,
      category: 'two_avatar',
      image: '',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 3,
      category: 'three_avatar',
      image: '',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 4,
      category: 'four_avatar',
      image: '',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 5,
      category: 'tarot',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 6,
      category: 'chinese_zodiac',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 7,
      category: 'constellation',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 8,
      category: 'dream_sign',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 9,
      category: 'secret_crush',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 10,
      category: 'myers_briggs',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 11,
      category: 'forest_test',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 12,
      category: 'elemental_soul',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 13,
      category: 'your_color',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 14,
      category: 'random_test',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 15,
      category: 'ideal_type',
      image: '',
      isSelected: false,
      isLocked: true,
    ),
  ];

  static Future<List<Avatar>> loadAvatars() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('avatars');

    if (data != null) {
      final decoded = jsonDecode(data) as List;
      return decoded.map((e) => Avatar.fromJson(e)).toList();
    }

    return _defaultAvatars;
  }

  static Future<void> saveAvatars(List<Avatar> avatars) async {
    final prefs = await SharedPreferences.getInstance();
    final json = avatars.map((a) => a.toJson()).toList();
    await prefs.setString('avatars', jsonEncode(json));
  }
}
