import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/plansApi.dart';
import 'package:almosawii/models/prodact.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../sharedPreferences.dart';

class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  int _currentPage = 0;
  bool loading = false;
  DbHehper helper;
  getBuyPlan() async {
    User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
    User.userCantBuy = await MySharedPreferences.getUserCantBuy();
  }

  @override
  void initState() {
    getBuyPlan();
    super.initState();
    helper = DbHehper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  Center(
                    child: Icon(
                      FontAwesomeIcons.solidHandPointDown,
                      color: customColor,
                      size: 100,
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder(
                    future: PlansApi.fetchAllPlans(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return (snapshot.data == null || snapshot.data.isEmpty)
                            ? Container(
                                child: Center(
                                  child: Text(
                                    'اسحب الشاشه لاسفل لاعاده التحويل ',
                                    style: AppTheme.heading,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : CarouselSlider.builder(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  height: 500,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                ),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index, i) {
                                  return Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      elevation: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: (_currentPage == index)
                                              ? Colors.transparent
                                              : customColor,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 250,
                                                height: 500,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: 20,
                                                          ),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                15,
                                                              ),
                                                              topRight: Radius
                                                                  .circular(
                                                                15,
                                                              ),
                                                            ),
                                                            color: customColor,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              (snapshot
                                                                      .data[
                                                                          index]
                                                                      .name
                                                                      .toString()) ??
                                                                  '',
                                                              style: AppTheme
                                                                  .heading
                                                                  .copyWith(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        (snapshot.data[index]
                                                                    .oldPrice ==
                                                                null)
                                                            ? Container()
                                                            : Text(
                                                                '${(snapshot.data[index].oldPrice) ?? ''} \$',
                                                                style: AppTheme
                                                                    .heading
                                                                    .copyWith(
                                                                  color:
                                                                      customColor,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                ),
                                                              ),
                                                        Text(
                                                          'كل ' +
                                                                  (snapshot
                                                                      .data[
                                                                          index]
                                                                      .plan_time
                                                                      .toString()) ??
                                                              "" + ' شهور',
                                                          style: AppTheme
                                                              .heading
                                                              .copyWith(
                                                            fontSize: 14,
                                                            color: customColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    (snapshot
                                                                .data[index]
                                                                .features
                                                                .isEmpty ||
                                                            snapshot
                                                                    .data[index]
                                                                    .features
                                                                    .isEmpty ==
                                                                null)
                                                        ? Container()
                                                        : Card(
                                                            elevation: 0,
                                                            child: Container(
                                                              height: 270,
                                                              child: ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                primary: false,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                itemCount: snapshot
                                                                    .data[index]
                                                                    .features
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        i) {
                                                                  return Column(
                                                                    children: [
                                                                      contant(
                                                                        title: snapshot
                                                                            .data[index]
                                                                            .features[i]['txt'],
                                                                        status: snapshot
                                                                            .data[index]
                                                                            .features[i]['status'],
                                                                      ),
                                                                      Divider(
                                                                        color:
                                                                            customColorDivider,
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                      
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      color: customColor,
                                                      onPressed: () async {
                                                        print('userSkipLogIn' +
                                                            User.userSkipLogIn
                                                                .toString());
                                                        if (User.userCantBuy ==
                                                            true) {
                                                          sikpDialog(
                                                              context: context);
                                                        } else {
                                                          if (User.userBuyPlan ==
                                                              true) {
                                                            cardDialog(
                                                                context:
                                                                    context,
                                                                message:
                                                                    'انت بالفعل مشارك في خطه عليك استكمال عمليه الاشاراك اول او حذف الخطه من السله حتي تسطيع الاشتراك في خطة اخري');
                                                          } else {
                                                            {
                                                              setState(() {
                                                                MySharedPreferences
                                                                    .saveUserPayPlan(
                                                                        true);

                                                                increaseCartTotlaPrice(
                                                                  price: (snapshot
                                                                              .data[
                                                                                  index]
                                                                              .newPrice ==
                                                                          null)
                                                                      ? double.parse(snapshot
                                                                          .data[
                                                                              index]
                                                                          .oldPrice
                                                                          .toString())
                                                                      : double.parse(snapshot
                                                                          .data[
                                                                              index]
                                                                          .newPrice
                                                                          .toString()),
                                                                );
                                                              });
                                                              ConsultantProdect
                                                                  prodect =
                                                                  ConsultantProdect({
                                                                'consultantId':
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                'type': 'plan',
                                                                'date': '',
                                                                'dateId': 0,
                                                                'time': '',
                                                                'title': snapshot
                                                                    .data[index]
                                                                    .name,
                                                                'price': (snapshot.data[index].newPrice ==
                                                                        null)
                                                                    ? double.parse(snapshot
                                                                        .data[
                                                                            index]
                                                                        .oldPrice
                                                                        .toString())
                                                                    : double.parse(snapshot
                                                                        .data[
                                                                            index]
                                                                        .newPrice
                                                                        .toString()),
                                                                'proImageUrl':
                                                                    '',
                                                              });
                                                              // ignore: unused_local_variable
                                                              int id = await helper
                                                                  .createProduct(
                                                                prodect,
                                                              );
                                                              cardDialog(
                                                                context:
                                                                    context,
                                                              );
                                                            }
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                        'اشترك الان',
                                                        style: AppTheme.heading
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    SizedBox(height: 3),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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

  contant({String title, String status}) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: (status == '1') ? BoxShape.circle : BoxShape.rectangle,
            color: (status == '1') ? Colors.green : Colors.red,
          ),
          child: Center(
            child: Icon(
              (status == '1') ? FontAwesomeIcons.check : Icons.close,
              color: Colors.white,
              size: (status == '1') ? 10 : 20,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          (title.toString()) ?? '',
          style: AppTheme.heading.copyWith(
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
