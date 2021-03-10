import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/secreens/courses/allCourses.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:almosawii/secreens/home/homeVideo.dart';
import 'package:almosawii/secreens/theBlog/bolgDetailes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: [
            HomeVideo(),
            SizedBox(height: 10),
            homeBaner(),
            sectionTitle(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AllCourses(),
                    ),
                  );
                },
                title: 'الدورات التدريبية'),
            corsesSections(),
            sectionTitle(onTap: () {}, title: 'المدونة'),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BolgDetailes(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blogList[index].date,
                                style: AppTheme.subHeading
                                    .copyWith(color: customColorGray),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  blogList[index].name,
                                  style: AppTheme.heading,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  blogList[index].date,
                                  style: AppTheme.subHeading
                                      .copyWith(color: customColorGray),
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
      ),
    );
  }

  corsesSections() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: coursesList.length,
        itemBuilder: (context, index) {
          return courses(
            index: index,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => Coursesedtails(
                    courses: coursesList[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  courses({int index, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    coursesList[index].image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: Text(
                coursesList[index].title,
                style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(height: 5),
            RatingStar(
              rating: coursesList[index].rate,
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '${coursesList[index].newPrice}\$',
                  style: AppTheme.headingColorBlue.copyWith(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 10,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${coursesList[index].oldPrice}\$',
                  style: AppTheme.headingColorBlue.copyWith(
                    fontSize: 12,
                    color: customColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container sectionTitle({String title, Function onTap}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTheme.heading.copyWith(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              'عرض المزيد',
              style: AppTheme.subHeading.copyWith(
                fontSize: 12,
                color: customColorGray,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container homeBaner() {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/coode.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
