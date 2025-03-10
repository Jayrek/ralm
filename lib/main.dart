import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralm/core/theme/app_theme.dart';
import 'package:ralm/feature/discover/screen/discover_screen.dart';
import 'package:ralm/feature/signs/screen/signs_screen.dart';
import 'package:ralm/feature/tarot_reading/screen/tarot_screen.dart';
import 'package:ralm/feature/dashboard/dashboard_screen.dart';

import 'core/constants/string_constant.dart';
import 'feature/dashboard/dashboard/dashboard_bloc.dart';
import 'feature/know_yourself/screen/know_yourself_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(FetchCategory()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstant.appName,
        theme: AppTheme.lightTheme,
        initialRoute: StringConstant.navDashboardScreenKey,
        routes: {
          StringConstant.navDashboardScreenKey: (context) => DashboardScreen(),
          StringConstant.navKnowYourScreenKey:
              (context) => KnowYourSelfScreen(),
          StringConstant.navSignsScreenKey: (context) => SignsScreen(),
          StringConstant.navTarotScreenKey: (context) => TarotScreen(),
          StringConstant.navDiscoverScreenKey: (context) => DiscoverScreen(),
        },
      ),
    );
  }
}
