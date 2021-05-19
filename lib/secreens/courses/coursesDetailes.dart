import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/couresApi.dart';
import 'package:almosawii/models/prodact.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:almosawii/sharedPreferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:almosawii/secreens/my%20courses/components/videoscreens.dart';

class Coursesedtails extends StatefulWidget {
  final Courses courses;

  const Coursesedtails({Key key, @required this.courses}) : super(key: key);
  @override
  _CoursesedtailsState createState() => _CoursesedtailsState();
}

class _CoursesedtailsState extends State<Coursesedtails> {
  bool viewRating = false;
  int tapded = 0;
  String type = 'course';
  DbHehper helper;
  bool cantAdd = false;
  var courseFromSQL;
  getUsercantBuy() async {
    User.userCantBuy = await MySharedPreferences.getUserCantBuy();
  }

  getCouresByIdFlomSQl() async {
    courseFromSQL = await helper.getProductById(widget.courses.id);

    if (courseFromSQL != null) {
      if (courseFromSQL.type == 'course') {
        if (courseFromSQL.consultantId == widget.courses.id) {
          setState(() {
            cantAdd = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    getUsercantBuy();
    super.initState();
    helper = DbHehper();
    getCouresByIdFlomSQl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          (widget.courses.video_code != "" && widget.courses.video_code != null)
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
                    FutureBuilder(
                      future: CoursesApi.getVideoMp4Link(
                          id: widget.courses.video_code),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return (snapshot.data == null ||
                                  snapshot.data.isEmpty)
                              ? Container()
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  child: ChewieVideo(
                                    videoUrl: snapshot.data,
                                  ),
                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
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
          firtstScetons(),
          (widget.courses.description == '' ||
                  widget.courses.description == null)
              ? Container()
              : Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    parseHtmlString((widget.courses.description) ?? ''),
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
                              width: MediaQuery.of(context).size.width - 110,
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

  courseContent() {
    return (widget.courses.lessons.isEmpty)
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.courses.lessons.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                              width: MediaQuery.of(context).size.width - 91,
                              child: Text(
                                parseHtmlString(
                                  widget.courses.lessons[index]['description'],
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Text(
                widget.courses.name,
                style: AppTheme.heading,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (widget.courses.newPrice == null)
                    ? Container()
                    : Text(
                        widget.courses.newPrice.toString() + '\$',
                        style: AppTheme.heading.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: customColor,
                        ),
                      ),
                SizedBox(width: 10),
                (widget.courses.oldPrice == null)
                    ? Container()
                    : Text(
                        (widget.courses.oldPrice != '0')
                            ? '${widget.courses.oldPrice}\$'
                            : "مجاناً",
                        style: AppTheme.subHeading.copyWith(
                          fontSize: (widget.courses.newPrice == null) ? 14 : 10,
                          fontWeight: FontWeight.w700,
                          color: (widget.courses.newPrice == null)
                              ? customColor
                              : customColorGray,
                          decoration: (widget.courses.newPrice == null)
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
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
              rating: double.parse(widget.courses.totalRating.toString()),
            ),
            (cantAdd)
                ? Container()
                // ignore: deprecated_member_use
                : RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: customColor,
                    onPressed: () async {
                      print('User.userCantBuy${User.userCantBuy}');
                      if (User.userCantBuy == true) {
                        sikpDialog(context: context);
                      } else {
                        setState(() {
                          // Cart.totalPraices = (widget.courses.newPrice == null)
                          //     ? double.parse(widget.courses.oldPrice.toString())
                          //     : double.parse(widget.courses.newPrice.toString());
                          increaseCartTotlaPrice(
                            price: (widget.courses.newPrice == null)
                                ? double.parse(
                                    widget.courses.oldPrice.toString())
                                : double.parse(
                                    widget.courses.newPrice.toString()),
                          );
                        });
                        ConsultantProdect prodect = ConsultantProdect({
                          'consultantId': widget.courses.id,
                          'type': type,
                          'date': '',
                          'dateId': 0,
                          'time': '',
                          'title': widget.courses.name,
                          'price': (widget.courses.newPrice == null)
                              ? double.parse(widget.courses.oldPrice.toString())
                              : double.parse(
                                  widget.courses.newPrice.toString()),
                          'proImageUrl': widget.courses.image,
                        });
                        // ignore: unused_local_variable
                        int id = await helper.createProduct(prodect);
                        cardDialog(context: context);
                      }
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
