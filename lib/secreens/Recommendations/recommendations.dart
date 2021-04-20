import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/RecomendationsApi.dart';
import 'package:almosawii/secreens/Recommendations/recommendationsDetailes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التوصيات'),
      ),
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
              : FutureBuilder(
                  future:
                      RecomendationsApi.fetchAllRecomendations(type: "premium"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return (snapshot.data == null || snapshot.data.isEmpty)
                          ? Container(
                              child: Center(
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .data[index].name,
                                                        style:
                                                            AppTheme.subHeading,
                                                      ),
                                                      Text(
                                                        '(${snapshot.data[index].txtBesideName})',
                                                        style:
                                                            AppTheme.subHeading,
                                                      ),
                                                      Text(
                                                        snapshot.data[index]
                                                            .percentageTxt,
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
                                                    snapshot
                                                        .data[index].dayDate,
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
                                                    snapshot.data[index].status,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'سعر الدخول',
                                                    style: AppTheme.heading,
                                                  ),
                                                  Text(
                                                    '(${(snapshot.data[index].entryPrice) ?? ''})',
                                                    style: AppTheme.subHeading,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'سعر الخروج',
                                                    style: AppTheme.heading,
                                                  ),
                                                  Text(
                                                    '(${(snapshot.data[index].outPrice) ?? ''})',
                                                    style: AppTheme.subHeading,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'اكبر مكسب',
                                                    style: AppTheme.heading,
                                                  ),
                                                  Text(
                                                    '(${(snapshot.data[index].bigPrice) ?? ''})',
                                                    style: AppTheme.subHeading,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 80,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  color: Colors.deepOrange,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    (snapshot.data[index]
                                                            .theTime) ??
                                                        '',
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                (snapshot.data[index]
                                                        .buyOrSale) ??
                                                    '',
                                                style:
                                                    AppTheme.heading.copyWith(
                                                  color: (snapshot.data[index]
                                                              .statusLoss ==
                                                          'مكسب')
                                                      ? customColor
                                                      : Colors.red,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  (snapshot.data[index]
                                                              .statusLoss ==
                                                          'gain')
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
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'اقل خساره',
                                                        style: AppTheme.heading,
                                                      ),
                                                      Text(
                                                        '(${(snapshot.data[index].smallPrice) ?? ''})',
                                                        style:
                                                            AppTheme.subHeading,
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
