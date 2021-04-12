import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/RecomendationsApi.dart';
import 'package:almosawii/models/recommendModels.dart';
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
      appBar: AppBar(),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: [
                    slider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        'التوصيات',
                        style: AppTheme.heading.copyWith(
                          color: customColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: RecomendationsApi.fetchAllRecomendations(
                          type: "free"),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return (snapshot.data == null ||
                                  snapshot.data.isEmpty)
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
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                RecommendationsDetailes(
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            snapshot.data[index]
                                                                .name,
                                                            style: AppTheme
                                                                .subHeading,
                                                          ),
                                                          Text(
                                                            '(${snapshot.data[index].txtBesideName})',
                                                            style: AppTheme
                                                                .subHeading,
                                                          ),
                                                          Text(
                                                            snapshot.data[index]
                                                                .percentageTxt,
                                                            style: AppTheme
                                                                .subHeading
                                                                .copyWith(
                                                              color: (double.parse(snapshot
                                                                          .data[
                                                                              index]
                                                                          .discount) <
                                                                      0)
                                                                  ? Colors.red
                                                                  : customColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        snapshot.data[index]
                                                            .dayDate,
                                                        style: AppTheme
                                                            .subHeading
                                                            .copyWith(
                                                          color:
                                                              customColorDivider,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data[index].status,
                                                        style: AppTheme.heading,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        'نقطه ${snapshot.data[index].points}',
                                                        style: AppTheme.heading
                                                            .copyWith(
                                                          color: customColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'اكير مكسب',
                                                        style: AppTheme.heading,
                                                      ),
                                                      (snapshot.data[index]
                                                                  .bigPrice ==
                                                              null)
                                                          ? Container()
                                                          : Text(
                                                              '(${snapshot.data[index].bigPrice})',
                                                              style: AppTheme
                                                                  .subHeading,
                                                            ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'اقل خساره',
                                                        style: AppTheme.heading,
                                                      ),
                                                      Text(
                                                        (snapshot.data[index]
                                                                    .smallPrice ==
                                                                null)
                                                            ? Container()
                                                            : '(${snapshot.data[index].smallPrice})',
                                                        style:
                                                            AppTheme.subHeading,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'سعر الدخول',
                                                        style: AppTheme.heading,
                                                      ),
                                                      (snapshot.data[index]
                                                                  .entryPrice ==
                                                              null)
                                                          ? Container()
                                                          : Text(
                                                              '(${snapshot.data[index].entryPrice})',
                                                              style: AppTheme
                                                                  .subHeading,
                                                            ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.deepOrange,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        snapshot.data[index]
                                                            .theTime,
                                                        style: AppTheme.heading
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data[index].buyOrSale,
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      color: (snapshot
                                                                  .data[index]
                                                                  .statusLoss ==
                                                              'gain')
                                                          ? customColor
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      (snapshot.data[index]
                                                                  .statusLoss ==
                                                              'gain')
                                                          ? SvgPicture.asset(
                                                              'lib/icons/stockUp.svg',
                                                              color:
                                                                  customColor,
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
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                            ),
                                                      SizedBox(width: 20),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'سعر الخروج',
                                                            style: AppTheme
                                                                .heading,
                                                          ),
                                                          (snapshot.data[index]
                                                                      .outPrice ==
                                                                  null)
                                                              ? Container()
                                                              : Text(
                                                                  '(${snapshot.data[index].outPrice})',
                                                                  style: AppTheme
                                                                      .subHeading,
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Text(
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
              onPressed: () {},
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
