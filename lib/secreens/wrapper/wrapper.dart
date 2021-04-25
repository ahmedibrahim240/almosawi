import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/models/utils.dart';
import 'package:almosawii/secreens/Recommendations/freeRecommendations.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/courses/courses.dart';
import 'package:almosawii/secreens/home/home.dart';
import 'package:almosawii/secreens/more/more.dart';
import 'package:almosawii/secreens/theBlog/bolg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Wrapper extends StatefulWidget {
  static final route = '/';

  const Wrapper({
    Key key,
  }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePages(),
    FreeRecommendations(),
    Blog(),
    CoursesPage(),
    More(),
  ];
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
    User.userBuyPlan = await MySharedPreferences.getUserBuyPlan();
    User.userCantBuy = await MySharedPreferences.getUserCantBuy();
    User.userPassword = await MySharedPreferences.getUserUserPassword();
  }

  checkUserSubscriptions() async {
    try {
      print('User.useridwarrrrrwew:${User.userid}');
      var response = await http.post(Utils.CheckUserSubscriptions_URL, body: {
        'user_id': User.userid.toString(),
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'success') {
        print('proChartRooms' + jsonData['UserData']['proChartRooms']);
        if (jsonData['UserData']['proChartRooms'] == '0' &&
            jsonData['UserData']['proChartVideos'] == '0' &&
            jsonData['UserData']['Courses'] == '0' &&
            jsonData['UserData']['Recomendations'] == '0') {
          setState(() {
            MySharedPreferences.saveUserSkipLogIn(true);
            setState(() {
              User.userSkipLogIn = true;
            });
          });
          User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
        } else {
          setState(() {
            MySharedPreferences.saveUserSkipLogIn(false);
            User.userSkipLogIn = false;
          });
          User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
        }
        User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
      } else {
        setState(() {});
      }
    } catch (e) {
      print('Cash wallpaper');
      setState(() {});

      print(e);
    }
  }

  @override
  void initState() {
    getTotalPrice();
    super.initState();
    _fcm.getToken().then(
      (token) {
        MySharedPreferences.saveUserToken(token.toString());
      },
    );
    getUserToken();
    if (User.userid != null) {
      checkUserSubscriptions();
    }
  }

  getUserToken() async {
    User.userToken = await MySharedPreferences.getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xfffF1F1F1),
        selectedItemColor: customColor,
        unselectedItemColor: customColorGray,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTheme.subHeadingColorBlue,
        unselectedLabelStyle:
            AppTheme.subHeadingColorBlue.copyWith(fontSize: 8),
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'الرئيسية',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: ' التوصيات المجانيه',
            icon: SvgPicture.asset(
              'lib/icons/stockUp.svg',
              color: (_currentIndex == 1) ? customColor : customColorGray,
              height: (_currentIndex == 1) ? 20 : 15,
            ),
          ),
          BottomNavigationBarItem(
            label: 'المدونة',
            icon: Icon(FontAwesomeIcons.newspaper),
          ),
          BottomNavigationBarItem(
            label: 'الدورات التدربية',
            icon: SvgPicture.asset(
              'lib/icons/courses.svg',
              color: (_currentIndex == 3) ? customColor : customColorGray,
              height: (_currentIndex == 3) ? 20 : 15,
            ),
          ),
          BottomNavigationBarItem(
            label: 'المزيد',
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
