import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/couresApi.dart';
import 'package:almosawii/models/prodact.dart';
import 'package:almosawii/models/rating.dart';
import 'package:almosawii/services/dbhelper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

class Coursesedtails extends StatefulWidget {
  final Courses courses;

  const Coursesedtails({Key key, @required this.courses}) : super(key: key);
  @override
  _CoursesedtailsState createState() => _CoursesedtailsState();
}

class _CoursesedtailsState extends State<Coursesedtails> {
  bool viewRating = false;
  int tapded = 0;
  DbHehper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHehper();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.courses.lessons);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.video_code != "")
              ? VimeoPlayer(id: widget.courses.video_code, autoPlay: false)
              : Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.courses.image),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: customCachedNetworkImage(
                          context: context,
                          url: widget.courses.image,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: customColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          firtstScetons(),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              parseHtmlString(widget.courses.description),
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
          // (tapded == 0) ? courseContent() : ratingListView(context: context),
        ],
      ),
    );
  }

  // ratingListView({BuildContext context}) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     primary: false,
  //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     itemCount: widget.courses.ratings.length,
  //     itemBuilder: (context, index) {
  //       return Column(
  //         children: [
  //           Container(
  //             child: Row(
  //               children: [
  //                 Container(
  //                   height: 80,
  //                   width: 80,
  //                   decoration: BoxDecoration(
  //                     image: DecorationImage(
  //                       image: AssetImage(
  //                         'lib/images/ahmed.jpg',
  //                       ),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 10),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       widget.courses.ratings[index]['name_sender'],
  //                       style: AppTheme.heading,
  //                     ),
  //                     // RatingStar(
  //                     //   rating: widget.courses.ratings[index][],
  //                     // ),
  //                     Text(
  //                       widget.courses.ratings[index]['content'],
  //                       style: AppTheme.subHeading,
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
  //             child: Divider(
  //               color: customColor.withOpacity(.3),
  //               thickness: 2,
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  courseContent() {
    return Container();

    //  ListView.builder(
    //   shrinkWrap: true,
    //   primary: false,
    //   itemCount: widget.courses.lessons.length,
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: [
    //         Container(
    //           color: Colors.grey[300],
    //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //           child: Row(
    //             children: [
    //               Text(
    //                 '${index + 1}',
    //                 style: AppTheme.heading,
    //               ),
    //               SizedBox(width: 10),
    //               Container(
    //                 height: 20,
    //                 width: 20,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: Colors.green,
    //                 ),
    //                 child: Center(
    //                   child: Icon(
    //                     FontAwesomeIcons.check,
    //                     color: Colors.white,
    //                     size: 10,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: 10),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     widget.courses.lessons[index]['title'],
    //                     style: AppTheme.heading,
    //                   ),
    //                   Text(
    //                     parseHtmlString(
    //                       widget.courses.lessons[index]['description'],
    //                     ),
    //                     style: AppTheme.subHeading,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 10),
    //       ],
    //     );
    //   },
    // );
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
              widget.courses.name,
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
              rating: widget.courses.totalRating,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: customColor,
              onPressed: () async {
                setState(() {
                  increaseCartTotlaPrice(price: widget.courses.newPrice);
                });
                ConsultantProdect prodect = ConsultantProdect({
                  'consultantId': 1,
                  'dateId': 2,
                  'title': widget.courses.totalRating,
                  'price': widget.courses.newPrice,
                  'proImageUrl': widget.courses.image,
                  'date': '21/3/2021',
                  'time': '10 am',
                });
                // ignore: unused_local_variable
                int id = await helper.createProduct(prodect);
                cardDialog(context: context);
              },
              child: Text(
                'اشتري الان',
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
