import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  DbHehper helper;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    helper = DbHehper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            customOnRefresh(onRefresh: () {
              setState(() {
                loading = !loading;
              });
            }, affterRefresh: () {
              setState(() {
                loading = !loading;
              });
            });
          },
          child: (loading)
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  children: [
                    Text(
                      'جميع الدورات',
                      style: AppTheme.heading,
                    ),
                    SizedBox(height: 20),
                    gardViewOfAllCourses(
                      context: context,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  gardViewOfAllCourses({BuildContext context}) {
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: .6,
      shrinkWrap: true,
      children: List.generate(
        coursesList.length,
        (index) {
          return allCoursesCard(
              index: index,
              context: context,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Coursesedtails(
                      courses: coursesList[index],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  allCoursesCard({int index, BuildContext context, Function onTap}) {
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
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: customCachedNetworkImage(
                  context: context,
                  url: coursesList[index].image,
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: Text(
                coursesList[index].name,
                style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(height: 5),
            RatingStar(
              rating: coursesList[index].totalRating,
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
}
