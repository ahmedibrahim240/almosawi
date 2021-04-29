import 'package:almosawii/secreens/home/home.dart';
import 'package:almosawii/secreens/splashscreen.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';

import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.route: (_) => SplashScreen(),
  ConnectivityNETWORG.route: (_) => ConnectivityNETWORG(),
  Home.route: (_) => Home(),
  Wrapper.route: (_) => Wrapper(),
};
