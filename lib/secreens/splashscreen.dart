import 'dart:async';

import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
  final FirebaseMessaging _fcm = FirebaseMessaging();

  getDateOfUser() async {
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.userid = await MySharedPreferences.getUserUserid();
  }

  getUserToken() async {
    User.userToken = await MySharedPreferences.getUserToken();
  }

  @override
  void initState() {
    _fcm.getToken().then(
      (token) {
        print(token);
        MySharedPreferences.saveUserToken(token.toString());
      },
    );
    getDateOfUser();

    getUserToken();

    super.initState();
    timer();
  }

  Timer timer() {
    return Timer(
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
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: customColor,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/splachBack.png'),
            fit: BoxFit.cover,
          ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
