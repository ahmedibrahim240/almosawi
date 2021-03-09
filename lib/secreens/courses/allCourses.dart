import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:flutter/material.dart';

class AllCourses extends StatefulWidget {
  @override
  _AllCoursesState createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Text(
            'الدورات المجانية',
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          gardViewOfFreeCourses(
            context: context,
          ),
          SizedBox(height: 10),
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
    );
  }

  gardViewOfAllCourses({BuildContext context}) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - 350) / 1.2;
    final double itemWidth = size.width / 2;
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: (itemWidth / itemHeight),
      shrinkWrap: true,
      children: List.generate(
        coursesList.length,
        (index) {
          return allCoursesCard(
            index: index,
            context: context,
            ontap: () {
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

  gardViewOfFreeCourses({BuildContext context}) {
    return GridView.count(
      crossAxisCount: 2,
      primary: false,
      shrinkWrap: true,
      children: List.generate(
        coursesList.length,
        (index) {
          return freeCoursesCard(
              index: index,
              context: context,
              ontap: () {
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

  freeCoursesCard({int index, BuildContext context, Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(coursesList[index].image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    coursesList[index].title,
                    style: AppTheme.heading.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RatingStar(
                      rating: coursesList[index].rate,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${coursesList[index].newPrice}\$',
                          style: AppTheme.headingColorBlue.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white.withOpacity(.7),
                            fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${coursesList[index].oldPrice}\$',
                          style: AppTheme.headingColorBlue.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  allCoursesCard({int index, BuildContext context, Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(coursesList[index].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              coursesList[index].title,
              style: AppTheme.heading,
            ),
            RatingStar(
              rating: coursesList[index].rate,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${coursesList[index].newPrice}\$',
                  style: AppTheme.headingColorBlue.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.white.withOpacity(.7),
                    fontSize: 10,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  '${coursesList[index].oldPrice}\$',
                  style: AppTheme.headingColorBlue.copyWith(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: customColor,
              onPressed: () {},
              child: Text(
                'شراء الان',
                style: AppTheme.heading.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
