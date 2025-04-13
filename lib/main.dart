import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/theme/app_theme.dart';
import 'package:ralm/feature/avatar/avatar_list_screen.dart';
import 'package:ralm/feature/avatar/bloc/avatar_bloc.dart';
import 'package:ralm/feature/discover/screen/discover_screen.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/bloc/elemental_soul_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/elemental_soul_result_screen.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/elemental_soul_screen.dart';
import 'package:ralm/feature/know_yourself/screen/elemental_soul/elemental_soul_test_screen.dart';
import 'package:ralm/feature/know_yourself/screen/forest_test/forest_test_screen.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/bloc/your_color_bloc.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/your_color_result_screen.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/your_color_screen.dart';
import 'package:ralm/feature/know_yourself/screen/your_color/your_color_test_screen.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/bloc/chinese_zodiac_bloc.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/chinese_zodiac_detail_screen.dart';
import 'package:ralm/feature/signs/screen/chinese_zodiac/chinese_zodiac_screen.dart';
import 'package:ralm/feature/signs/screen/constellation/bloc/constellation_bloc.dart';
import 'package:ralm/feature/signs/screen/constellation/constellation_detail_screen.dart';
import 'package:ralm/feature/signs/screen/constellation/constellation_screen.dart';
import 'package:ralm/feature/signs/screen/dream_sign/bloc/dream_sign_bloc.dart';
import 'package:ralm/feature/signs/screen/dream_sign/dream_sign_detail_screen.dart';
import 'package:ralm/feature/signs/screen/dream_sign/dream_sign_screen.dart';
import 'package:ralm/feature/signs/screen/secret_crush/bloc/secret_crush_bloc.dart';
import 'package:ralm/feature/signs/screen/secret_crush/secret_crush_detail_screen.dart';
import 'package:ralm/feature/signs/screen/secret_crush/secret_crush_screen.dart';
import 'package:ralm/feature/signs/screen/signs_screen.dart';
import 'package:ralm/feature/tarot_reading/bloc/tarot_bloc.dart';
import 'package:ralm/feature/tarot_reading/screen/tarot_card_screen.dart';
import 'package:ralm/feature/tarot_reading/screen/tarot_screen.dart';
import 'package:ralm/feature/dashboard/dashboard_screen.dart';
import 'package:ralm/feature/tarot_reading/screen/view_card_detail_screen.dart';
import 'package:ralm/feature/tarot_reading/screen/view_card_picked_screen.dart';
import 'package:ralm/feature/tarot_reading/screen/view_card_screen.dart';

import 'core/constants/string_constant.dart';
import 'feature/dashboard/bloc/dashboard_bloc.dart';
import 'feature/know_yourself/bloc/know_yourself_bloc.dart';
import 'feature/know_yourself/screen/know_yourself_screen.dart';
import 'feature/signs/bloc/signs_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc()..add(FetchCategory()),
        ),
        BlocProvider(create: (context) => KnowYourselfBloc()),
        BlocProvider(create: (context) => SignsBloc()),
        BlocProvider(create: (context) => ChineseZodiacBloc()),
        BlocProvider(create: (context) => ConstellationBloc()),
        BlocProvider(create: (context) => TarotBloc()),
        BlocProvider(create: (context) => AvatarBloc()),
        BlocProvider(create: (context) => DreamSignBloc()),
        BlocProvider(create: (context) => SecretCrushBloc()),
        BlocProvider(create: (context) => ElementalSoulBloc()),
        BlocProvider(create: (context) => YourColorBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstant.appName,
        theme: AppTheme.lightTheme,
        initialRoute: StringConstant.navDashboardScreenKey,
        routes: {
          StringConstant.navDashboardScreenKey: (context) => DashboardScreen(),
          StringConstant.navDiscoverScreenKey: (context) => DiscoverScreen(),

          // KNOW YOURSELF category
          StringConstant.navKnowYourScreenKey:
              (context) => KnowYourSelfScreen(),

          // FOREST TEST
          StringConstant.navForestTest: (context) => ForestTestScreen(),

          // Elemental Soul
          StringConstant.navElementalSoul: (context) => ElementalSoulScreen(),
          StringConstant.navElementalSoulTest:
              (context) => ElementalSoulTestScreen(),
          StringConstant.navElementalSoulResult:
              (context) => ElementalSoulResultScreen(),

          // Your Color
          StringConstant.navYourColor: (context) => YourColorScreen(),
          StringConstant.navYourColorTest: (context) => YourColorTestScreen(),
          StringConstant.navYourColorResult:
              (context) => YourColorResultScreen(),

          // SIGNS category
          StringConstant.navSignsScreenKey: (context) => SignsScreen(),
          StringConstant.navChineseZodiac: (context) => ChineseZodiacScreen(),
          StringConstant.navChineseZodiacDetail:
              (context) => ChineseZodiacDetailScreen(),
          StringConstant.navConstellationZodiac:
              (context) => ConstellationScreen(),
          StringConstant.navConstellationZodiacDetail:
              (context) => ConstellationDetailScreen(),
          StringConstant.navDreamSign: (context) => DreamSignScreen(),
          StringConstant.navDreamSignDetail:
              (context) => DreamSignDetailScreen(),
          StringConstant.navSecretCrush: (context) => SecretCrushScreen(),
          StringConstant.navSecretCrushDetail:
              (context) => SecretCrushDetailScreen(),

          // TAROT category
          StringConstant.navTarotScreenKey: (context) => TarotScreen(),
          StringConstant.navTarotCard: (context) => TarotCardScreen(),
          StringConstant.navTarotViewCard: (context) => ViewTarotCard(),
          StringConstant.navTarotViewCardDetail:
              (context) => ViewCardDetailScreen(),
          StringConstant.navTarotPickedCard:
              (context) => ViewPickedCardScreen(),
          // AVATAR
          StringConstant.navAvatar: (context) => AvatarListScreen(),
        },
      ),
    );
  }
}
