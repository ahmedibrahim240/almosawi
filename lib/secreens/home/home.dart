import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/contactUsApi.dart';
import 'package:almosawii/models/couresApi.dart';
import 'package:almosawii/models/homeVideoApi.dart';
import 'package:almosawii/models/proChartVipApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/ProChartVIP/proChartVIP.dart';
import 'package:almosawii/secreens/TradingAccount/tradingAccount.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:almosawii/secreens/courses/coursesDetailes.dart';
import 'package:almosawii/secreens/home/homeVideo.dart';
import 'package:almosawii/secreens/userHome/UserHome.dart';
import 'package:flutter/material.dart';
import '../../sharedPreferences.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
    User.userLogIn = await MySharedPreferences.getUserSingIn();
    User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
    User.userBuyPlan = await MySharedPreferences.getUserBuyPlan();
    User.userCantBuy = await MySharedPreferences.getUserCantBuy();
    User.userPassword = await MySharedPreferences.getUserUserPassword();
    User.userToken = await MySharedPreferences.getUserToken();
  }

  @override
  void initState() {
    getTotalPrice();
    super.initState();
    print("UserSkiping LOgIN:${User.userSkipLogIn}");
  }

  @override
  Widget build(BuildContext context) {
    if (User.userSkipLogIn == true) {
      return Home();
    } else {
      return UserHome();
    }
  }
}

class Home extends StatefulWidget {
  static final route = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  List<String> numberTitleList = ['عميل', 'دورة مباشرة', 'دورة مسجلة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
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
                children: [
                  HomeVideo(),
                  SizedBox(height: 10),
                  homeProChartSection(),
                  // HomeTabs(),
                  SizedBox(height: 10),
                  successPartners(),
                  SizedBox(height: 10),
                  acountFeatures(),
                  SizedBox(height: 10),
                  homeBaner(),
                  SizedBox(height: 10),
                  contactWithAhmed(context),
                  SizedBox(height: 10),
                  sectionTitle(title: 'الدورات التدريبية'),
                  SizedBox(height: 10),
                  corsesSections(),
                  SizedBox(height: 10),
                ],
              ),
      ),
    );
  }

  homeProChartSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: HomeVideoApi.futchHomeVideo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null)
                    ? Container()
                    : Card(
                        elevation: 3,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: customColor,
                                width: 5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: customCachedNetworkImage(
                                    context: context,
                                    url:
                                        snapshot.data.homeProChartSectionImage),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (snapshot.data.homeProChartSectionTitle) ??
                                        "",
                                    textAlign: TextAlign.center,
                                    style: AppTheme.heading,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: Text(
                                      (snapshot.data.homeProChartSectionTxt) ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.heading.copyWith(
                                        color: customColorGray,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      color: customColor,
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'اشترك الان',
                                          style: AppTheme.heading.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ProChartVIP(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: HomeVideoApi.futchHomeVideo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null)
                    ? Container()
                    : Card(
                        elevation: 3,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xfff067FA5),
                                width: 5,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: customCachedNetworkImage(
                                    context: context,
                                    url:
                                        snapshot.data.homeYourDealSectionImage),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (snapshot.data.homeYourDealSectionTitle) ??
                                        '',
                                    textAlign: TextAlign.center,
                                    style: AppTheme.heading,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: Text(
                                      (snapshot.data.homeYourDealSectionTxt) ??
                                          '',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.heading.copyWith(
                                        color: customColorGray,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Container(
                                      color: Color(0xfff067FA5),
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'تتبع صفقتك الآن',
                                          style: AppTheme.heading.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      launchInBrowser(
                                          'https://ahmadalmosawi.com/V2/calculator.html');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  contactWithAhmed(BuildContext context) {
    return FutureBuilder(
      future: ProChartVIPModelsApi.futchProChartVIP(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data == null)
              ? Container()
              : (snapshot.data.contactUsBanner == '')
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ContactUs(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 355,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        child: customCachedNetworkImage(
                          context: context,
                          url: snapshot.data.contactUsBanner,
                        ),
                      ),
                    );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  parteners() {
    return FutureBuilder(
      future: ContactUsApi.futchContactUs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data == null)
              ? Container()
              : ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      primary: false,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      children: List.generate(
                        snapshot.data.parteners.length,
                        (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: customCachedNetworkImage(
                              context: context,
                              url: snapshot.data.parteners[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  acountFeatures() {
    return FutureBuilder(
      future: ContactUsApi.futchContactUs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null)
              ? Container()
              : ListView(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      primary: false,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      children: List.generate(
                        snapshot.data.acountFeatures.length,
                        (index) {
                          return Column(
                            children: [
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: customCachedNetworkImage(
                                  context: context,
                                  url: snapshot.data.acountFeatures[index]
                                      ['image'],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                snapshot.data.acountFeatures[index]['title'],
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
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
          parteners(),
          SizedBox(height: 10),
          FutureBuilder(
            future: HomeVideoApi.futchHomeVideo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null)
                    ? Container()
                    : Container(
                        height: 90,
                        child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.homeNumbers.length,
                          itemBuilder: (context, index) {
                            return cartPartners(
                              title: numberTitleList[index],
                              nummber: snapshot.data.homeNumbers[index],
                            );
                          },
                        ),
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
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
        height: 110,
        width: 90,
        decoration: BoxDecoration(
            color: customColor, borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                nummber,
                style: AppTheme.subHeading.copyWith(
                  color: Colors.white,
                  fontSize: 22,
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

  corsesSections() {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      height: 240,
      child: FutureBuilder(
        future: CoursesApi.fetchAllCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return (snapshot.data == null || snapshot.data.isEmpty)
                ? Container()
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return courses(
                        courses: snapshot.data[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Coursesedtails(
                                courses: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  courses({int index, Function onTap, Courses courses}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 190,
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
                  url: courses.image,
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: 200,
              child: Text(
                courses.name,
                style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
              ),
            ),
            SizedBox(height: 5),
            RatingStar(
              rating: double.parse(courses.totalRating.toString()),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                (courses.newPrice == null)
                    ? Container()
                    : Text(
                        '${courses.newPrice}\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                          color: customColor,
                        ),
                      ),
                SizedBox(width: 5),
                Text(
                  (courses.oldPrice == null)
                      ? Container()
                      : (courses.oldPrice != '0')
                          ? '${courses.oldPrice}\$'
                          : "مجاناً",
                  style: AppTheme.headingColorBlue.copyWith(
                    fontSize: 10,
                    color:
                        (courses.newPrice == null) ? customColor : Colors.black,
                    decoration: (courses.newPrice == null)
                        ? TextDecoration.none
                        : TextDecoration.lineThrough,
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

  homeBaner() {
    return FutureBuilder(
      future: ProChartVIPModelsApi.futchProChartVIP(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null)
              ? Container()
              : (snapshot.data.homeAdImage == '' ||
                      snapshot.data.homeAdImage == null)
                  ? Container()
                  : Container(
                      height: 120,
                      padding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      child: customCachedNetworkImage(
                        context: context,
                        url: snapshot.data.homeAdImage,
                      ),
                    );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
