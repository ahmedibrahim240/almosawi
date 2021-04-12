import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/couresApi.dart';
import 'package:almosawii/secreens/my%20courses/vidoePage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

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
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.video_code != "")
              ? Container(
                  child: Column(
                  children: [
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
                    VimeoPlayer(id: widget.courses.video_code, autoPlay: false),
                  ],
                ))
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.courses.image),
                      fit: BoxFit.contain,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.courses.name,
                  style: AppTheme.heading,
                ),
                RatingStar(
                  rating: double.parse(widget.courses.totalRating.toString()),
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
                              parseHtmlString(widget.courses.description),
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

  ratingListView({BuildContext context}) {
    return (widget.courses.ratings.isEmpty)
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: widget.courses.ratings.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: (widget.courses.ratings[index]['img'] == "")
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                )
                              : customCachedNetworkImage(
                                  context: context,
                                  url: widget.courses.ratings[index]['img'],
                                ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.courses.ratings[index]['name_sender'],
                              style: AppTheme.heading,
                            ),
                            RatingStar(
                              rating: double.parse(
                                  widget.courses.ratings[index]['rate']),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 130,
                              child: Text(
                                widget.courses.ratings[index]['content'],
                                style: AppTheme.subHeading,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Divider(
                      color: customColor.withOpacity(.3),
                      thickness: 2,
                    ),
                  )
                ],
              );
            },
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
    return (widget.courses.lessons.isEmpty)
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.courses.lessons.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MyCoursesVideoPage(
                        title: widget.courses.lessons[index]['title'],
                        videoId: widget.courses.lessons[index]['video'],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                widget.courses.lessons[index]['title'],
                                style: AppTheme.heading,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 110,
                                child: Text(
                                  parseHtmlString(
                                    widget.courses.lessons[index]
                                        ['description'],
                                  ),
                                  style: AppTheme.subHeading,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
  }
}
