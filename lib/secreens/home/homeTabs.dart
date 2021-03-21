import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/Recommendations/recommendations.dart';
import 'package:almosawii/secreens/archives/archives.dart';
import 'package:almosawii/secreens/courses/allCourses.dart';
import 'package:almosawii/secreens/theBlog/bolg.dart';
import 'package:almosawii/secreens/videosProChart/allVideosProChart.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'المدونة',
              iconImage: 'lib/images/consulantent.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Blog(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'الدورات التدربية',
              iconImage: 'lib/images/courses.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AllCourses(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'برو شارت',
              iconImage: 'lib/images/eventicons.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Archives(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  rowofHomeTap2(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'غرفة بروشارت',
              iconImage: 'lib/images/consulantent.png',
              onTap: () {},
            ),
          ),
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'التوصيات',
              iconImage: 'lib/images/courses.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Recommendations(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: homeTabs(
              title: 'قسم التعليم',
              iconImage: 'lib/images/eventicons.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AllCourses(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  rowofHomeTap3(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          homeTabs(
            title: 'فيديو بروشارت',
            iconImage: 'lib/images/consulantent.png',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AllVideosProChart(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  homeTabs({String title, String iconImage, Function onTap}) {
    return Container(
      width: 120,
      height: 100,
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
                  height: 40,
                  width: 60,
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
