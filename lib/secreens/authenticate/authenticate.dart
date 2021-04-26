import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/authenticate/register/register.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../sharedPreferences.dart';
import 'logIn/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    _fcm.getToken().then(
      (token) {
        print(token);
        MySharedPreferences.saveUserToken(token.toString());
      },
    );

    getUserToken();
    super.initState();
  }

  getUserToken() async {
    User.userToken = await MySharedPreferences.getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    if (User.userid == null) {
      if (showSignIn) {
        return Container(
          child: LogIn(toggleView: toggleView),
        );
      } else {
        return Container(
          child: Register(toggleView: toggleView),
        );
      }
    } else {
      return Wrapper();
    }
  }
}
