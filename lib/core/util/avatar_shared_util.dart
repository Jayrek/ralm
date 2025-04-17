import 'dart:convert';

import 'package:ralm/models/avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarSharedUtil {
  static final List<Avatar> _defaultAvatars = [
    Avatar(
      id: 1,
      category: 'default_1',
      image: 'assets/image/avatar/Default_1.png',
      isSelected: true,
      isLocked: false,
    ),
    Avatar(
      id: 2,
      category: 'default_2',
      image: 'assets/image/avatar/Default_2.png',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 3,
      category: 'default_3',
      image: 'assets/image/avatar/Default_3.png',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 4,
      category: 'default_4',
      image: 'assets/image/avatar/Default_4.png',
      isSelected: false,
      isLocked: false,
    ),
    Avatar(
      id: 5,
      category: 'tarot',
      image: 'assets/image/avatar/Tarot_Card_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 6,
      category: 'chinese_zodiac',
      image: 'assets/image/avatar/Chinese_Zodiac_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 7,
      category: 'constellation',
      image: 'assets/image/avatar/Constellation_Sign_Avatar.png"',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 8,
      category: 'dream_sign',
      image: 'assets/image/avatar/Dream_Sign_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 9,
      category: 'secret_crush',
      image: 'assets/image/avatar/Secret_Crush_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 10,
      category: 'myers_briggs',
      image: 'assets/image/avatar/Myers_Briggs_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 11,
      category: 'forest_test',
      image: 'assets/image/avatar/Forest_Test_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 12,
      category: 'elemental_soul',
      image: 'assets/image/avatar/Elemental_Soul_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 13,
      category: 'your_color',
      image: 'assets/image/avatar/Your_Color_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 14,
      category: 'random_test',
      image: 'assets/image/avatar/Random_Test_Avatar.png',
      isSelected: false,
      isLocked: true,
    ),
    Avatar(
      id: 15,
      category: 'ideal_type',
      image: 'assets/image/avatar/Ideal_Type_Avatar.png',
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
