import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatefulWidget {
  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowofHomeTap1(context),
        rowofHomeTap2(context),
        rowofHomeTap3(context),
      ],
    );
  }

  rowofHomeTap1(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          homeTabs(
            title: 'الاخبار',
            iconImage: 'lib/images/consulantent.png',
            onTap: () {},
          ),
          homeTabs(
            title: 'الدورات التدربية',
            iconImage: 'lib/images/courses.png',
            onTap: () {},
          ),
          homeTabs(
            title: 'برو شارت',
            iconImage: 'lib/images/eventicons.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  rowofHomeTap2(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          homeTabs(
            title: 'غرفة بروشارت',
            iconImage: 'lib/images/consulantent.png',
            onTap: () {},
          ),
          homeTabs(
            title: 'التوصيات',
            iconImage: 'lib/images/courses.png',
            onTap: () {},
          ),
          homeTabs(
            title: 'قسم التعليم',
            iconImage: 'lib/images/eventicons.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  rowofHomeTap3(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          homeTabs(
            title: 'فيديو بروشارت',
            iconImage: 'lib/images/consulantent.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  homeTabs({String title, String iconImage, Function onTap}) {
    return Container(
      width: 120,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 3,
          child: Container(
            height: 80,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(iconImage),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
