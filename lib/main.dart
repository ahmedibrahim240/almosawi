import 'package:almosawii/routes.dart';
import 'package:almosawii/secreens/splashscreen.dart';
import 'package:almosawii/services/connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/constans.dart';
import 'constants/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'enums/connectivity_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      initialData: null,
      // builder: (context, wdiget) => Container(),
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.white),
          primaryColor: Colors.white,
          bottomAppBarColor: customColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: customColor),
            actionsIconTheme: IconThemeData(color: customColor),
            centerTitle: true,
            textTheme: TextTheme(
              headline6: AppTheme.heading,
            ),
          ),
          accentColor: customColor,
          iconTheme: IconThemeData(color: customColor),
        ),
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar'),
        ],
        initialRoute: ConnectivityNETWORG.route,
        routes: routes,
      ),
    );
  }
}
