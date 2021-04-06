import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/Recommendations/freeRecommendations.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/courses/courses.dart';
import 'package:almosawii/secreens/home/home.dart';
import 'package:almosawii/secreens/more/more.dart';
import 'package:almosawii/secreens/theBlog/bolg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../sharedPreferences.dart';

class Wrapper extends StatefulWidget {
  static final route = '/';

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    FreeRecommendations(),
    Blog(),
    Courses(),
    More(),
  ];
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
  }

  @override
  void initState() {
    getTotalPrice();
    super.initState();
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
