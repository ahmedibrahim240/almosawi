import 'dart:async';

import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../sharedPreferences.dart';
import 'onboarding/onboarding.dart';

class ConnectivityNETWORG extends StatefulWidget {
  static final route = '/Connectivity';

  @override
  _ConnectivityNETWORGState createState() => _ConnectivityNETWORGState();
}

class _ConnectivityNETWORGState extends State<ConnectivityNETWORG> {
  ConnectivityResult connectivity;
  Timer _timer;
  int counter = 10;

  netWorkTest() async {
    connectivity = await Connectivity().checkConnectivity();
  }

  startTimer() {
    counter = 10;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (counter > 0) {
            counter--;
          } else if (connectivity != ConnectivityResult.none) {
            setState(() {
              loading = false;
            });
            _timer.cancel();
          } else {
            setState(() {
              loading = false;
            });
            _timer.cancel();
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    netWorkTest();
    print(connectivity);
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : (connectivity == ConnectivityResult.none)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Icon(
                        FontAwesomeIcons.wifi,
                        size: 50,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loading = !loading;
                        });
                        netWorkTest();
                        startTimer();
                        if (connectivity != ConnectivityResult.none) {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Text(
                        '‏لا ‏يوجد ‏اتصال ‏بالإنترنت ‏يرجى ‏المحاولة ‏مجددا',
                        style: AppTheme.subHeading.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )
              : SplashScreen(),
    );
  }
}

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
    User.isOnBording = await MySharedPreferences.getUserOnBording();
  }

  getFcmToken() async {
    await _fcm.getToken().then(
      (token) {
        print(token);
        MySharedPreferences.saveUserToken(token.toString());
      },
    );
  }

  getUserToken() async {
    User.userToken = await MySharedPreferences.getUserToken();
  }

  @override
  void initState() {
    getFcmToken();
    getDateOfUser();
    getUserToken();

    super.initState();
    timer();
  }

  Timer timer() {
    return Timer(
      Duration(seconds: 8),
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
