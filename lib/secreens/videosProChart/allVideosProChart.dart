import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/secreens/videosProChart/videosProChartDetaills.dart';
import 'package:flutter/material.dart';

class AllVideosProChart extends StatefulWidget {
  @override
  _AllVideosProChartState createState() => _AllVideosProChartState();
}

class _AllVideosProChartState extends State<AllVideosProChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: blogList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => VideosProChartDetaills(
                        theBolg: blogList[index],
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(blogList[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blogList[index].date,
                              style: AppTheme.subHeading.copyWith(
                                color: customColorGray,
                                fontSize: 9,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                blogList[index].name,
                                style: AppTheme.heading.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                blogList[index].contant,
                                style: AppTheme.subHeading.copyWith(
                                  color: customColorGray,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
