import 'package:almosawii/constants/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/ahmed.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'أ/احمد ابراهيم الموسوي',
              style: AppTheme.heading,
            ),
          ),
          Center(
            child: Text(
              'بلا بلابلا بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا بلا بلابلا بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا  بلا بلابلا ',
              style: AppTheme.heading,
            ),
          ),
        ],
      ),
    );
  }
}
