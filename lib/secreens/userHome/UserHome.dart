import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/homeTapsModels.dart';
import 'package:almosawii/secreens/ProChartVIP/proChartVIP.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:almosawii/secreens/courses/allCourses.dart';
import 'package:almosawii/secreens/videosProChart/allVideosProChart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:almosawii/secreens/prochartroom/prochartRoom.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<HomeTapsModels> lsitOfTapsData1 = [
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'غرفة',
      titleEn: 'Pro Chart',
    ),
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'توصيات',
      titleEn: 'Pro Chart VIP',
    ),
  ];
  List<HomeTapsModels> lsitOfTapsData2 = [
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'مكتبة الفيديو',
      titleEn: 'Video Pro Chart',
    ),
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'قسم التعليم',
      titleEn: 'Pro Chart VIP',
    ),
  ];
  List<String> namesList = [
    'Silver',
    'Mosawi',
    "Elite",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: [
            suerHomeAppBar(),
            homeTabsFirst(list: lsitOfTapsData1),
            contactWithAhmed(context),
            homeTabsTow(list: lsitOfTapsData2),
            homeTabsName(),
          ],
        ),
      ),
    );
  }

  suerHomeAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      color: Color(0xfff04B085),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ',Welcome',
            style: AppTheme.headingColorBlue.copyWith(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ahmed Ibrahim',
                style: AppTheme.headingColorBlue.copyWith(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  contactWithAhmed(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContactUs(),
          ),
        );
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff04B085),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 120,
              child: Text(
                'تواصل مع',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                FontAwesomeIcons.solidComment,
                size: 110,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              child: Text(
                'أ/أحمد الموسوي',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  homeTabsFirst({List<HomeTapsModels> list}) {
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: .8,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      children: List.generate(
        list.length,
        (index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProchartRoom(),
                    ),
                  );
                  break;

                default:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProChartVIP(),
                    ),
                  );
              }
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: (index == 0)
                          ? Color(0xfffFF9B63)
                          : Color(0xfff067FA5),
                      width: 5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(list[index].image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            list[index].titleAr,
                            textAlign: TextAlign.right,
                            style: AppTheme.heading,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            list[index].titleEn,
                            textAlign: TextAlign.left,
                            style:
                                AppTheme.heading.copyWith(color: customColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  homeTabsTow({List<HomeTapsModels> list}) {
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: .8,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      children: List.generate(
        list.length,
        (index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AllVideosProChart(),
                    ),
                  );
                  break;

                default:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AllCourses(),
                    ),
                  );
              }
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: (index == 0)
                          ? Color(0xfff6C089B)
                          : Color(0xfffF00B27),
                      width: 5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(list[index].image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            list[index].titleAr,
                            textAlign: TextAlign.right,
                            style: AppTheme.subHeading,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            list[index].titleEn,
                            textAlign: TextAlign.left,
                            style: AppTheme.subHeading
                                .copyWith(color: customColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  homeTabsName() {
    return GridView.count(
      crossAxisCount: 3,
      primary: false,
      childAspectRatio: 1,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      children: List.generate(
        namesList.length,
        (index) {
          return InkWell(
            onTap: () {},
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xfff04B085),
                      width: 5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      namesList[index],
                      textAlign: TextAlign.right,
                      style: AppTheme.heading.copyWith(
                        color: customColor,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Room',
                      textAlign: TextAlign.left,
                      style: AppTheme.subHeading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
