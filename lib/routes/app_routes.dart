import 'package:flutter/material.dart';
import 'package:nischay_s_application2/presentation/launch_screen/launch_screen.dart';
import 'package:nischay_s_application2/presentation/login_screen/login_screen.dart';
import 'package:nischay_s_application2/presentation/entry_screen/entry_screen.dart';
import 'package:nischay_s_application2/presentation/real_time_visual_screen/real_time_visual_screen.dart';

class AppRoutes {
  static const String launchScreen = '/launch_screen';

  static const String loginScreen = '/login_screen';

  static const String entryScreen = '/entry_screen';

  static const String realTimeVisualScreen = '/real_time_visual_screen';


  static Map<String, WidgetBuilder> routes = {
    launchScreen: (context) => LaunchScreen(),
    loginScreen: (context) => LoginScreen(),
    entryScreen: (context) => EntryScreen(),
    realTimeVisualScreen: (context) => RealTimeVisualScreen(vehicleNumber: '',)
  };
}
