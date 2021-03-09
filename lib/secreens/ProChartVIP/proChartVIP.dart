import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';

class ProChartVIP extends StatefulWidget {
  @override
  _ProChartVIPState createState() => _ProChartVIPState();
}

class _ProChartVIPState extends State<ProChartVIP> {
  String contant =
      'توصيات و إشارات تداول موثوقة.. نجاحك توصيات و إشارات تداول موثوقة.. نجاحك توصيات و إشارات تداول موثوقة.. نجاحك توصيات و إشارات تداول موثوقة.. نجاحك توصيات و إشارات تداول موثوقة.. نجاحك';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: customColor,
                )),
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('lib/images/img1.jpg'),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'قسم Pro Chat Vip',
            style: AppTheme.heading,
          ),
          SizedBox(height: 10),
          Text(
            contant,
            style: AppTheme.subHeading,
          ),
          SizedBox(height: 20),
          CustomButton(
            onPress: () {},
            text: 'اشترك',
          ),
        ],
      ),
    );
  }
}
