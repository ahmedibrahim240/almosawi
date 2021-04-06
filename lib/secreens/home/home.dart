import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/courses.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/secreens/TradingAccount/tradingAccount.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:almosawii/secreens/home/homeTabs.dart';
import 'package:almosawii/secreens/home/homeVideo.dart';
import 'package:almosawii/secreens/theBlog/bolgDetailes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  static final route = '/home';

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
            SizedBox(height: 10),
            HomeTabs(),
            SizedBox(height: 10),
            contactWithAhmed(context),
            HomeVideo(),
            SizedBox(height: 10),
            successPartners(),
            SizedBox(height: 10),
            taps(),
            homeBaner(),
            SizedBox(height: 10),
            sectionTitle(title: 'الدورات التدريبية'),
            SizedBox(height: 10),
            corsesSections(),

            SizedBox(height: 10),
            // sectionTitle(title: 'المدونة'),
            // homeBolgList(),
          ],
        ),
      ),
    );
  }

  contactWithAhmed(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContactUs(),
          ),
        );
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff04B085),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 120,
              child: Text(
                'تواصل مع',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                FontAwesomeIcons.solidComment,
                size: 110,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              child: Text(
                'أ/أحمد الموسوي',
                style: AppTheme.heading.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  taps() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      children: [
        GridView.count(
          crossAxisCount: 2,
          primary: false,
          childAspectRatio: 1,
          shrinkWrap: true,
          children: List.generate(
            4,
            (index) {
              return Column(
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/images/logo.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'title',
                    style: AppTheme.heading,
                  ),
                ],
              );
            },
          ),
        ),
        CustomButtonWithchild(
          child: Center(
            child: Text(
              'فتح حساب تداول ',
              style: AppTheme.heading.copyWith(color: Colors.white),
            ),
          ),
          color: customColor,
          onPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TradingAccount(),
              ),
            );
          },
        ),
      ],
    );
  }

  successPartners() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'شركاء النجاح',
            style: AppTheme.heading,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SvgPicture.asset(
                    'lib/icons/ticklogo.svg',
                    height: 100,
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    'lib/icons/logo1.svg',
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: cartPartners(
                  title: 'عميل',
                  nummber: '1950',
                ),
              ),
              Expanded(
                flex: 1,
                child: cartPartners(
                  title: 'دورة مباشرة',
                  nummber: '310',
                ),
              ),
              Expanded(
                flex: 1,
                child: cartPartners(
                  title: 'دورة مسجلة',
                  nummber: '220',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  cartPartners({String title, String nummber}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 80,
        width: 90,
        decoration: BoxDecoration(
            color: customColor, borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                nummber,
                style: AppTheme.subHeading.copyWith(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                title,
                style: AppTheme.subHeading.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  homeBolgList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: 3,
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
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: customCachedNetworkImage(
                      context: context,
                      url: blogList[index].image,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 180,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blogList[index].date,
                        style: AppTheme.subHeading.copyWith(
                          color: customColorGray,
                          fontSize: 9,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          blogList[index].name,
                          style: AppTheme.heading.copyWith(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          blogList[index].contant,
                          style: AppTheme.subHeading.copyWith(
                            color: customColorGray,
                            fontSize: 9,
                          ),
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
    );
  }

  corsesSections() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 230,
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
          // TextButton(
          //   onPressed: onTap,
          //   child: Text(
          //     'عرض المزيد',
          //     style: AppTheme.subHeading.copyWith(
          //       fontSize: 12,
          //       color: customColorGray,
          //     ),
          //   ),
          // ),
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
          image: AssetImage('lib/images/panner.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
