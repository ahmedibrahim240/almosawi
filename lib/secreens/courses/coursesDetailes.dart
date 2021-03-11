import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/models/rating.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Coursesedtails extends StatefulWidget {
  final Courses courses;

  const Coursesedtails({Key key, @required this.courses}) : super(key: key);
  @override
  _CoursesedtailsState createState() => _CoursesedtailsState();
}

class _CoursesedtailsState extends State<Coursesedtails> {
  bool viewRating = false;
  int tapded = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          SizedBox(height: 10),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(widget.courses.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          firtstScetons(),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              widget.courses.contant,
              // textAlign: TextAlign.justify,
              style: AppTheme.subHeading.copyWith(
                color: customColorGray,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                taps(
                  index: 0,
                  title: 'محتوي الدورة',
                  onTap: () {
                    setState(
                      () {
                        tapded = 0;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 1,
                  title: 'اراء العملاء',
                  onTap: () {
                    setState(
                      () {
                        tapded = 1;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          (tapded == 0) ? courseContent() : ratingListView(context: context),
        ],
      ),
    );
  }

  ListView courseContent() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.courses.coursContentList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Text(
                    '${index + 1}',
                    style: AppTheme.heading,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.courses.coursContentList[index].name,
                        style: AppTheme.heading,
                      ),
                      Text(
                        widget.courses.coursContentList[index].description,
                        style: AppTheme.subHeading,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  InkWell taps({Function onTap, String title, int index}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.subHeading.copyWith(
              color: (tapded == index) ? customColor : Colors.grey[400],
            ),
          ),
          SizedBox(
            width: 50,
            child: Divider(
              color: (tapded == index) ? customColor : Colors.transparent,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  ListView firtstScetons() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.courses.title,
              style: AppTheme.heading,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.courses.newPrice.toString() + '\$',
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  widget.courses.oldPrice.toString() + '\$',
                  style: AppTheme.subHeading.copyWith(
                    color: customColorGray,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingStar(
              rating: widget.courses.rate,
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
      ],
    );
  }

  coursesDetaile({IconData iconData, String title}) {
    return Row(
      children: [
        Icon(
          iconData,
          color: customColorGold,
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: AppTheme.heading.copyWith(
            color: customColorGray,
          ),
        )
      ],
    );
  }

  iconCouresBoton({String title, IconData icon}) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: customColor,
            size: 35,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: AppTheme.headingColorBlue.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
