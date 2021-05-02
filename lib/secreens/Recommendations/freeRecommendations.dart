import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/RecomendationsApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/ProChartVIP/proChartVIP.dart';
import 'package:almosawii/secreens/Recommendations/recommendationsDetailes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FreeRecommendations extends StatefulWidget {
  @override
  _FreeRecommendationsState createState() => _FreeRecommendationsState();
}

class _FreeRecommendationsState extends State<FreeRecommendations> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التوصيات المجانيه',
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            (User.userSkipLogIn == false) ? Container() : slider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'التوصيات',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                  fontSize: 20,
                ),
              ),
            ),
            FutureBuilder(
              future: RecomendationsApi.fetchAllRecomendations(type: "free"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data == null || snapshot.data.isEmpty)
                      ? Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'لا توجد توصيات مجانية في الوقت الحالى',
                                  style: AppTheme.heading,
                                  textAlign: TextAlign.center,
                                ),
                                // Text(
                                //   'اسحب الشاشه لاسفل لاعاده التحميل',
                                //   style: AppTheme.heading,
                                //   textAlign: TextAlign.center,
                                // ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => RecommendationsDetailes(
                                      recommend: snapshot.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    (snapshot
                                                            .data[index].name ??
                                                        ''),
                                                    style: AppTheme.subHeading,
                                                  ),
                                                  (snapshot.data[index]
                                                                  .theTime ==
                                                              '' ||
                                                          snapshot.data[index]
                                                                  .theTime ==
                                                              null)
                                                      ? Container()
                                                      : Text(
                                                          '(${(snapshot.data[index].theTime) ?? ''})',
                                                          style: AppTheme
                                                              .subHeading
                                                              .copyWith(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                  (snapshot.data[index]
                                                                  .percentageTxt ==
                                                              '' ||
                                                          snapshot.data[index]
                                                                  .percentageTxt ==
                                                              null)
                                                      ? Container()
                                                      : Text(
                                                          (snapshot.data[index]
                                                                  .percentageTxt) ??
                                                              '',
                                                          style: AppTheme
                                                              .subHeading
                                                              .copyWith(
                                                            color: (snapshot
                                                                        .data[
                                                                            index]
                                                                        .statusLoss ==
                                                                    'مكسب')
                                                                ? customColor
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Text(
                                                (snapshot
                                                        .data[index].dayDate) ??
                                                    '',
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  color: customColorDivider,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                (snapshot.data[index].status) ??
                                                    "",
                                                style: AppTheme.subHeading,
                                              ),
                                              SizedBox(width: 5),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (snapshot.data[index].entryPrice ==
                                                      '' ||
                                                  snapshot.data[index]
                                                          .entryPrice ==
                                                      null)
                                              ? Container()
                                              : Column(
                                                  children: [
                                                    Text(
                                                      'سعر الدخول',
                                                      style: AppTheme.heading,
                                                    ),
                                                    Text(
                                                      '(${(snapshot.data[index].entryPrice) ?? ''})',
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          (snapshot.data[index].outPrice ==
                                                      '' ||
                                                  snapshot.data[index]
                                                          .outPrice ==
                                                      null)
                                              ? Container()
                                              : Column(
                                                  children: [
                                                    Text(
                                                      'الهدف',
                                                      style: AppTheme.heading,
                                                    ),
                                                    Text(
                                                      '(${(snapshot.data[index].buyAreaGoals) ?? ''})',
                                                      style:
                                                          AppTheme.subHeading,
                                                    ),
                                                  ],
                                                ),
                                          (snapshot.data[index].stopBuy == '' &&
                                                  snapshot.data[index]
                                                          .stopSelling ==
                                                      '')
                                              ? Container()
                                              : (snapshot.data[index].stopBuy !=
                                                      '')
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          'وقف الخسارة',
                                                          style:
                                                              AppTheme.heading,
                                                        ),
                                                        Text(
                                                          '(${(snapshot.data[index].stopBuy) ?? ''})',
                                                          style: AppTheme
                                                              .subHeading,
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        Text(
                                                          'وقف الخسارة',
                                                          style:
                                                              AppTheme.heading,
                                                        ),
                                                        Text(
                                                          '(${(snapshot.data[index].stopSelling) ?? ''})',
                                                          style: AppTheme
                                                              .subHeading,
                                                        ),
                                                      ],
                                                    ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          (snapshot.data[index].points == '' ||
                                                  snapshot.data[index].points ==
                                                      null)
                                              ? Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 20,
                                                  ))
                                              : Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 100,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      color: customColor,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        (snapshot.data[index]
                                                                .points) ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTheme.heading
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 9,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(width: 10),
                                          (snapshot.data[index].buyOrSale ==
                                                      '' ||
                                                  snapshot.data[index]
                                                          .buyOrSale ==
                                                      null)
                                              ? Expanded(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: 20,
                                                  ))
                                              : Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    (snapshot.data[index]
                                                            .buyOrSale) ??
                                                        '',
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      color: (snapshot
                                                                      .data[
                                                                          index]
                                                                      .statusLoss ==
                                                                  'gain' ||
                                                              snapshot
                                                                      .data[
                                                                          index]
                                                                      .statusLoss ==
                                                                  'مكسب')
                                                          ? customColor
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                (snapshot.data[index]
                                                                .statusLoss ==
                                                            'gain' ||
                                                        snapshot.data[index]
                                                                .statusLoss ==
                                                            'مكسب')
                                                    ? SvgPicture.asset(
                                                        'lib/icons/stockUp.svg',
                                                        color: customColor,
                                                        height: 15,
                                                      )
                                                    : Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                          image: AssetImage(
                                                              'lib/images/chartlineDown.png'),
                                                          fit: BoxFit.cover,
                                                        )),
                                                      ),
                                                SizedBox(width: 20),
                                                (snapshot.data[index]
                                                                .smallPrice ==
                                                            '' ||
                                                        snapshot.data[index]
                                                                .smallPrice ==
                                                            null)
                                                    ? Container()
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'اقل خساره',
                                                            style: AppTheme
                                                                .heading,
                                                          ),
                                                          Text(
                                                            '(${(snapshot.data[index].smallPrice) ?? ''})',
                                                            style: AppTheme
                                                                .subHeading,
                                                          ),
                                                        ],
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      (snapshot.data[index].comment == '' ||
                                              snapshot.data[index].comment ==
                                                  null)
                                          ? Container()
                                          : Text(
                                              '(${snapshot.data[index].comment})',
                                              style: AppTheme.subHeading,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  slider() {
    return Container(
      color: customColor,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Text(
            'لعدم فقد أي جديد اشترك وستصلك الإشعارات بالتوصيات',
            style: AppTheme.subHeading.copyWith(
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProChartVIP(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white,
              child: Text(
                'اشترك الان',
                style: AppTheme.subHeading.copyWith(
                  color: customColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
