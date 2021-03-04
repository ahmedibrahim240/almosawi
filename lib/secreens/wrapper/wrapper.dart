import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Center(child: Text('sssdsdsdd')),
    Center(child: Text('sssdsdsdd')),
    Center(child: Text('sssdsdsdd')),
    Center(child: Text('sssdsdsdd')),
    Center(child: Text('sssdsdsdd')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xfffF1F1F1),
        selectedItemColor: customColor,
        unselectedItemColor: customColorGray,
        selectedLabelStyle: AppTheme.headingColorBlue,
        unselectedLabelStyle: AppTheme.subHeadingColorBlue,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'الرئيسية',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'التوصيات',
            icon: Icon(FontAwesomeIcons.bookmark),
          ),
          BottomNavigationBarItem(
            label: 'المدونة',
            icon: Icon(FontAwesomeIcons.newspaper),
          ),
          BottomNavigationBarItem(
            label: 'الدورات التدربية',
            icon: Icon(FontAwesomeIcons.youtube),
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
