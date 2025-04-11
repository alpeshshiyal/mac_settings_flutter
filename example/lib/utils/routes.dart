import 'package:flutter/material.dart';
import '../ui/setup_ip_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> generateRoutes = {
    // SplashScreen.routeName:(context)=>const SplashScreen(),
    SetupIpScreen.routeName:(context)=>const SetupIpScreen(),
  };

}