class StringConstant {
  // fonts
  static const fontTinos = 'Tinos';
  static const fontWhisper = 'Whisper';

  static const appName = 'Ralm';
  static const discoverYourself = 'Discover Yourself';

  // navigation keys
  static const navDashboardScreenKey = '/';
  static const navKnowYourScreenKey = '/know_yourself_screen';
  static const navSignsScreenKey = '/signs_screen';
  static const navTarotScreenKey = '/tarot_screen';
  static const navDiscoverScreenKey = '/discover_screen';

  // navigation keys for ELEMENTAL SOUL
  static const navElementalSoul = '/elemental_soul';
  static const navElementalSoulTest = '/elemental_soul_test';
  static const navElementalSoulResult = '/elemental_soul_result';

  // navigation keys for YOUR COLOR
  static const navYourColor = '/your_color';
  static const navYourColorTest = '/your_color_test';
  static const navYourColorResult = '/your_color_result';

  // navigation keys for SIGNS
  static const navChineseZodiac = '/chinese_zodiac';
  static const navChineseZodiacDetail = '/chinese_zodiac_detail';
  static const navConstellationZodiac = '/constellation_zodiac';
  static const navConstellationZodiacDetail = '/constellation_zodiac_detail';

  // navigation keys for DREAM SIGN
  static const navDreamSign = '/dream_sign';
  static const navDreamSignDetail = '/dream_sign_detail';

  // navigation keys for SECRET CRUSH
  static const navSecretCrush = '/secret_crush';
  static const navSecretCrushDetail = '/secret_crush_detail';

  // navigation keys for TAROT
  static const navTarotCard = '/tarot_card';
  static const navTarotViewCard = '/tarot_view_card';
  static const navTarotViewCardDetail = '/tarot_view_card_detail';
  static const navTarotPickedCard = '/tarot_picked_card';

  // navigation keys for AVATAR
  static const navAvatar = '/avatar';

  static const List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static String getElementalTypeFromScore(int score) {
    if (score >= 100 && score <= 160) return 'Fire';
    if (score >= 170 && score <= 240) return 'Air';
    if (score >= 250 && score <= 320) return 'Water';
    if (score >= 330 && score <= 400) return 'Earth';
    return 'Unknown';
  }

  static String getColorResultFromScore(int score) {
    if (score >= 150 && score <= 230) return 'Green';
    if (score >= 240 && score <= 330) return 'Purple';
    if (score >= 340 && score <= 420) return 'Red';
    if (score >= 430 && score <= 510) return 'Blue';
    if (score >= 510 && score <= 600) return 'White';
    return 'Unknown';
  }
}
