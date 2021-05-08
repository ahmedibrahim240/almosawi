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
        child: FutureBuilder(
          future: RecomendationsApi.fetchAllRecomendations(type: "premium"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //title
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                (snapshot.data[index].name ??
                                                    ''),
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              (snapshot.data[index].buyOrSale ==
                                                          '' ||
                                                      snapshot.data[index]
                                                              .buyOrSale ==
                                                          null)
                                                  ? Container()
                                                  : Text(
                                                      (snapshot.data[index]
                                                              .buyOrSale) ??
                                                          '',
                                                      style: AppTheme.heading
                                                          .copyWith(
                                                        color: (snapshot
                                                                    .data[index]
                                                                    .buyOrSale ==
                                                                'شراء')
                                                            ? customColor
                                                            : Colors.red,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              (snapshot.data[index]
                                                              .statusLoss ==
                                                          'gain' ||
                                                      snapshot.data[index]
                                                              .statusLoss ==
                                                          'مكسب')
                                                  ? Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'lib/icons/stockUp.svg',
                                                          color: customColor,
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          ' ( ربح )',
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            color: customColor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'lib/images/chartlineDown.png'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          ' ( خساره )',
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: customColorDivider,
                                        thickness: 2,
                                      ),
                                    ],
                                  ),

                                  ///title
                                  ///سعر الهرجروح
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (snapshot.data[index].entryPrice == '' ||
                                              snapshot.data[index].entryPrice ==
                                                  null)
                                          ? Container()
                                          : Container(
                                              width: 85,
                                              child: Text(
                                                'سعر الدخول',
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                      (snapshot.data[index].entryPrice == '' ||
                                              snapshot.data[index].entryPrice ==
                                                  null)
                                          ? Container()
                                          : Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '(${(snapshot.data[index].entryPrice) ?? ''})',
                                                  style: AppTheme.subHeading
                                                      .copyWith(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      Container(
                                        child: Text(
                                          (snapshot.data[index].status) ?? "",
                                          style: AppTheme.subHeading.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///سعر الخروج
////الهدف
                                  (snapshot.data[index].buyAreaGoals == '' ||
                                          snapshot.data[index].buyAreaGoals ==
                                              null)
                                      ? Container()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 85,
                                              child: Text(
                                                'الهدف',
                                                style: AppTheme.subHeading
                                                    .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    '(${(snapshot.data[index].buyAreaGoals) ?? ''})',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),

                                  ///الهدف
                                  ///وقف الخساره
                                  (snapshot.data[index].stopBuy == '' &&
                                          snapshot.data[index].stopSelling ==
                                              '')
                                      ? Container()
                                      : (snapshot.data[index].stopBuy != '')
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 85,
                                                  child: Text(
                                                    'وقف الخسارة',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '(${(snapshot.data[index].stopBuy) ?? ''})',
                                                      style: AppTheme.subHeading
                                                          .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Container(
                                                  width: 85,
                                                  child: Text(
                                                    'وقف الخسارة',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '(${(snapshot.data[index].stopSelling) ?? ''})',
                                                      style: AppTheme.subHeading
                                                        ..copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                              ],
                                            ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      (snapshot.data[index].theTime == '' ||
                                              snapshot.data[index].theTime ==
                                                  null)
                                          ? Container()
                                          : Container(
                                              width: 100,
                                              padding: EdgeInsets.symmetric(
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
                                                          .theTime) ??
                                                      '',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      AppTheme.heading.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      (snapshot.data[index].points == '' ||
                                              snapshot.data[index].points ==
                                                  null)
                                          ? Container()
                                          : Text(
                                              (snapshot.data[index].points) ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.heading.copyWith(
                                                color: customColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  (snapshot.data[index].comment == '' ||
                                          snapshot.data[index].comment == null)
                                      ? Container()
                                      : Text(
                                          '(${snapshot.data[index].comment})',
                                          style: AppTheme.subHeading,
                                        ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      (snapshot.data[index].dayDate) ?? '',
                                      style: AppTheme.subHeading.copyWith(),
                                    ),
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
