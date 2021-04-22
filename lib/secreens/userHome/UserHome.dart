import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/MyRoomsApi.dart';
import 'package:almosawii/models/homeTapsModels.dart';
import 'package:almosawii/models/proChartVipApi.dart';
import 'package:almosawii/models/visitorHomeIconsApi.dart';
import 'package:almosawii/secreens/LearningSection/LearningSection.dart';
import 'package:almosawii/secreens/ProChartVIP/proChartVIP.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:almosawii/secreens/videosProChart/allVideosProChart.dart';
import 'package:flutter/material.dart';
import 'package:almosawii/secreens/prochartroom/prochartRoom.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<HomeTapsModels> lsitOfTapsData1 = [
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'غرفة',
      titleEn: 'Pro Chart',
    ),
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'توصيات',
      titleEn: 'Pro Chart VIP',
    ),
  ];
  List<HomeTapsModels> lsitOfTapsData2 = [
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'مكتبة الفيديو',
      titleEn: 'Video Pro Chart',
    ),
    HomeTapsModels(
      image: 'lib/images/eventicons.png',
      titleAr: 'قسم التعليم',
      titleEn: 'Pro Chart VIP',
    ),
  ];
  List<String> namesList = [
    'Silver',
    'Mosawi',
    "Elite",
  ];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
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
                    suerHomeAppBar(),
                    homeTabsFirst(list: lsitOfTapsData1),
                    contactWithAhmed(context),
                    homeTabsTow(list: lsitOfTapsData2),
                    homeTabsName(),
                  ],
                ),
        ),
      ),
    );
  }

  contactWithAhmed(BuildContext context) {
    return FutureBuilder(
      future: ProChartVIPModelsApi.futchProChartVIP(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
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

  suerHomeAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      color: Color(0xfff04B085),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ',Welcome',
            style: AppTheme.headingColorBlue.copyWith(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Ahmed Ibrahim',
                style: AppTheme.headingColorBlue.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  homeTabsFirst({List<HomeTapsModels> list}) {
    return FutureBuilder(
      future: VisitorHomeIconsApi.futchVisitorHomeIcons(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null)
              ? Container()
              : GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  childAspectRatio: .97,
                  shrinkWrap: true,
                  children: List.generate(
                    snapshot.data.userHomeIconsRow1.length,
                    (index) {
                      return (snapshot.data.userHomeIconsRow1[index] == '')
                          ? Container()
                          : InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ALLRomes(),
                                      ),
                                    );
                                    break;

                                  default:
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ProChartVIP(),
                                      ),
                                    );
                                }
                              },
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: (index == 0)
                                            ? Color(0xfffFF9B63)
                                            : Color(0xfff067FA5),
                                        width: 5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        child: customCachedNetworkImage(
                                            context: context,
                                            url: snapshot
                                                .data.userHomeIconsRow1[index]),
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              list[index].titleAr,
                                              textAlign: TextAlign.right,
                                              style: AppTheme.heading,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              list[index].titleEn,
                                              textAlign: TextAlign.left,
                                              style: AppTheme.heading
                                                  .copyWith(color: customColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  homeTabsTow({List<HomeTapsModels> list}) {
    return FutureBuilder(
      future: VisitorHomeIconsApi.futchVisitorHomeIcons(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null)
              ? Container()
              : GridView.count(
                  crossAxisCount: 2,
                  primary: false,
                  childAspectRatio: .97,
                  shrinkWrap: true,
                  children: List.generate(
                    snapshot.data.userHomeIconsRow2.length,
                    (index) {
                      return (snapshot.data.userHomeIconsRow2[index] == '')
                          ? Container()
                          : InkWell(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => AllVideosProChart(),
                                      ),
                                    );
                                    break;

                                  default:
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => LearningSection(),
                                      ),
                                    );
                                }
                              },
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: (index == 0)
                                            ? Color(0xfff6C089B)
                                            : Color(0xfffF00B27),
                                        width: 5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        child: customCachedNetworkImage(
                                            context: context,
                                            url: snapshot
                                                .data.userHomeIconsRow2[index]),
                                      ),
                                      Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              list[index].titleAr,
                                              textAlign: TextAlign.right,
                                              style: AppTheme.heading,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              list[index].titleEn,
                                              textAlign: TextAlign.left,
                                              style: AppTheme.heading
                                                  .copyWith(color: customColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  homeTabsName() {
    return FutureBuilder(
      future: MyRoomsApi.fetchAllMyRooms(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لا يوجد بينات حاليا /',
                        style: AppTheme.heading,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'اسحب الشاشه لاسفل لاعاده التحميل',
                        style: AppTheme.heading,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : GridView.count(
                  crossAxisCount: 3,
                  primary: false,
                  childAspectRatio: 1,
                  shrinkWrap: true,
                  children: List.generate(
                    snapshot.data.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProchartRoom(
                                rooms: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xfff04B085),
                                  width: 5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data[index].name,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Room',
                                  textAlign: TextAlign.left,
                                  style: AppTheme.subHeading,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
