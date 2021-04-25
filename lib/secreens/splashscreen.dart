import 'dart:async';

import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';

import 'package:flutter/material.dart';

import '../sharedPreferences.dart';
import 'onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static final route = '/splashScreen';

  static bool slider = true;
  static void isSlider() {
    slider = !slider;
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getDateOfUser() async {
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.userid = await MySharedPreferences.getUserUserid();
  }

  @override
  void initState() {
    getDateOfUser();

    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => OnBoard(),
          ),
          (routes) => false,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: customColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('lib/images/splachback.jpeg'),
            //   fit: BoxFit.fitHeight,
            // ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/logo.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ALMOSAWI',
              style: AppTheme.heading.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
