import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/models/prodact.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          gardViewOfAllCourses(
            context: context,
          ),
        ],
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
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: customCachedNetworkImage(
                  context: context,
                  url: coursesList[index].image,
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
              onPressed: () async {
                ConsultantProdect prodect = ConsultantProdect({
                  'consultantId': 1,
                  'dateId': 2,
                  'title': coursesList[index].title,
                  'price': coursesList[index].newPrice,
                  'proImageUrl': coursesList[index].image,
                  'date': '21/3/2021',
                  'time': '10 am',
                });
                // ignore: unused_local_variable
                int id = await helper.createProduct(prodect);
                showCartDialog(context: context);
              },
              child: Text(
                'اشتري الان',
                style: AppTheme.heading.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
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
}
