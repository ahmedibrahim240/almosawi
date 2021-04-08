import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/material.dart';

class AllCourses extends StatefulWidget {
  @override
  _AllCoursesState createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {
  DbHehper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHehper();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  gardViewOfAllCourses(
                    context: context,
                  ),
                ],
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
}

Future<void> showCartDialog({BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'تم اضافة الطلب لستكمال عمليه الشراء عليه الذهاب الي عربة التسوق',
                  style: AppTheme.subHeading,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'الصفحة الرائسية',
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Wrapper()),
                (route) => false,
              );
            },
          ),
          TextButton(
            child: Text(
              'عربة التسوق',
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => Cart(),
                ),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      );
    },
  );
}
