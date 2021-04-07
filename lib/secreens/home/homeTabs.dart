import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/homeTapsModels.dart';
// import 'package:almosawii/secreens/Recommendations/recommendations.dart';
import 'package:almosawii/secreens/archives/archives.dart';
import 'package:almosawii/secreens/courses/allCourses.dart';
// import 'package:almosawii/secreens/prochartroom/prochartRoom.dart';
import 'package:almosawii/secreens/theBlog/bolg.dart';
// import 'package:almosawii/secreens/videosProChart/allVideosProChart.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatefulWidget {
  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    return homeTabs();
  }

  homeTabs({String title, String iconImage, Function onTap}) {
    return GridView.count(
      crossAxisCount: 3,
      primary: false,
      childAspectRatio: .8,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      children: List.generate(
        lsitOfTapsData.length,
        (index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Blog(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AllCourses(),
                    ),
                  );
                  break;
                default:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Archives(),
                    ),
                  );
              }
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: (index == 0)
                          ? Color(0xfffFF9B63)
                          : (index == 1)
                              ? Color(0xfff067FA5)
                              : Color(0xfffF00B27),
                      width: 5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(lsitOfTapsData[index].image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            lsitOfTapsData[index].titleAr,
                            textAlign: TextAlign.right,
                            style: AppTheme.subHeading,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            lsitOfTapsData[index].titleEn,
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

    //  Container(
    //   width: 120,
    //   height: 100,
    //   child: InkWell(
    //     onTap: onTap,
    //     child: Card(
    //       elevation: 3,
    //       child: Container(
    //         height: 80,
    //         alignment: Alignment.center,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               height: 40,
    //               width: 60,
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                   image: AssetImage(iconImage),
    //                   fit: BoxFit.fitHeight,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: 10),
    //             Text(
    //               title,
    //               style: AppTheme.heading.copyWith(
    //                 color: customColor,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
