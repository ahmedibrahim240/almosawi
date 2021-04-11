import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/contactUsApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/ProChartVIP/proChartVIP.dart';
import 'package:almosawii/secreens/Recommendations/recommendations.dart';
import 'package:almosawii/secreens/aboutUs/aboutUs.dart';
import 'package:almosawii/secreens/archives/archives.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:almosawii/secreens/editprofile/editprofile.dart';
import 'package:almosawii/secreens/lastMessges/lastMessges.dart';
import 'package:almosawii/secreens/my%20courses/mycourses.dart';
import 'package:almosawii/secreens/notifcations/notifcations.dart';
import 'package:almosawii/secreens/prochartroom/prochartRoom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../sharedPreferences.dart';
import '../splashscreen.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            moreLogo(),
            customdivider(),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => EditProfile(),
                  ),
                );
              },
              icon: Icon(Icons.person),
              tilte: 'الصفحة الشخصية',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Cart(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.shoppingCart),
              tilte: 'عربة التسوق',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Recommendations(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'lib/icons/stockUp.svg',
                color: customColor,
                height: 20,
              ),
              tilte: 'التوصيات',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Archives(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'lib/icons/upanddown.svg',
                color: customColor,
                height: 20,
              ),
              tilte: 'أرشيف التوصيات',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyCourses(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'lib/icons/courses.svg',
                color: customColor,
                height: 20,
              ),
              tilte: 'دوراتي',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProChartVIP(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'lib/icons/stok2.svg',
                color: customColor,
                height: 20,
              ),
              tilte: 'قسم ال Pro Chart VIP ',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Notifcations(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'lib/icons/notifcations.svg',
                color: customColor,
                height: 20,
              ),
              tilte: ' الإشعارات',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProchartRoom(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.comments),
              tilte: 'غرفة بروشارت',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LastMessges(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.comments),
              tilte: 'المراسلات السابقة',
            ),
            customdivider(),
            moreBody(
              onTap: () {},
              icon: Icon(FontAwesomeIcons.star),
              tilte: 'تقيمك للتطبيق ',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AboutUs(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.infoCircle),
              tilte: 'من نحن ',
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ContactUs(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.solidQuestionCircle),
              tilte: 'اتصل بنا ',
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: ContactUsApi.futchContactUs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return (snapshot.data == null)
                      ? Container()
                      : moreBody(
                          onTap: () {
                            launchToWhatsApp(
                                phoneNum: snapshot.data.whatsApp,
                                context: context);
                          },
                          icon: Icon(FontAwesomeIcons.whatsapp),
                          tilte: 'تواصل عبر الواتس اب',
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 20),
            moreBody(
              onTap: () {},
              icon: Icon(FontAwesomeIcons.shareSquare),
              tilte: 'شارك التطبيق ',
            ),
            customdivider(),
            moreBody(
              onTap: () {
                setState(
                  () {
                    if (User.userSkipLogIn == true) {
                      MySharedPreferences.saveUserSkipLogIn(false);
                    }
                    MySharedPreferences.saveUserUserid(null);
                  },
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => SplashScreen(),
                  ),
                );
              },
              icon: Icon(FontAwesomeIcons.signOutAlt),
              tilte:
                  (User.userSkipLogIn == true) ? 'تسجيل دخول' : 'تسجيل خروج ',
            ),
          ],
        ),
      ),
    );
  }

  Row moreLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'ALMOSAWI',
          style: AppTheme.heading,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/logo.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  Padding customdivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Divider(
        color: customColor2.withOpacity(.2),
        thickness: 2,
      ),
    );
  }

  moreBody({String tilte, Widget icon, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            child: icon,
          ),
          SizedBox(width: 20),
          Text(
            tilte,
            style: AppTheme.heading,
          ),
        ],
      ),
    );
  }
}
