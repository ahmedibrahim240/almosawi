import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'components/videoscreens.dart';

class MyCoursesDetails extends StatefulWidget {
  final Courses courses;

  const MyCoursesDetails({Key key, @required this.courses}) : super(key: key);
  @override
  _MyCoursesDetailsState createState() => _MyCoursesDetailsState();
}

class _MyCoursesDetailsState extends State<MyCoursesDetails> {
  int lecTapped = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ChewieVideo(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.courses.title,
                  style: AppTheme.heading,
                ),
                RatingStar(
                  rating: widget.courses.rate,
                ),
              ],
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
                        lecTapped = 0;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 1,
                  title: 'معرفه المزيد',
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 1;
                      },
                    );
                  },
                ),
                SizedBox(width: 20),
                taps(
                  index: 2,
                  title: 'تقيمك',
                  onTap: () {
                    setState(
                      () {
                        lecTapped = 2;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          (lecTapped == 0)
              ? lectureBody()
              : (lecTapped == 1)
                  ? ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Container(
                          child: Center(
                            child: Text(
                              widget.courses.contant,
                              style: AppTheme.subHeading,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'اراء العملاء',
                            style:
                                AppTheme.heading.copyWith(color: customColor),
                          ),
                        ),
                        SizedBox(height: 20),
                        ratingListView(context: context),
                      ],
                    )
                  : reviewBody()
        ],
      ),
    );
  }

  reviewBody() {
    return Container(
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SmoothStarRating(
                  rating: 2.5,
                  size: 25,
                  filledIconData: Icons.star,
                  color: Colors.yellow[700],
                  halfFilledIconData: Icons.star_half,
                  borderColor: Colors.yellow[900],
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing: 2.0,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: conectedTextFormStyle(
                  lableText: 'رسالتك',
                ),
              ),
              SizedBox(height: 20),
              CustomButtonWithchild(
                color: customColor,
                onPress: () {},
                child: Center(
                  child: Text(
                    'ارسال',
                    style: AppTheme.heading.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
              color: (lecTapped == index) ? customColor : Colors.grey[400],
            ),
          ),
          SizedBox(
            width: 50,
            child: Divider(
              color: (lecTapped == index) ? customColor : Colors.transparent,
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  lectureBody() {
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
}
