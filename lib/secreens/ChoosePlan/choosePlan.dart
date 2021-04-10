import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/plansApi.dart';
import 'package:almosawii/secreens/ChoosePlan/choosePlandetailes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          Text(
            'اختر الخطة',
            style: AppTheme.heading,
          ),
          SizedBox(height: 10),
          Text(
            'التي تناسبك الان',
            style: AppTheme.heading,
          ),
          Center(
            child: Icon(
              FontAwesomeIcons.handPointDown,
              color: customColor,
              size: 100,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: PlansApi.fetchAllPlans(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(
                            'networkError',
                            style: AppTheme.heading,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          height: 300,
                          reverse: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index, i) {
                          return Container(
                            child: GestureDetector(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: (_currentPage == index)
                                        ? customColor
                                        : Colors.transparent,
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 250,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    snapshot.data[index].name,
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      fontSize: 20,
                                                      color: (_currentPage ==
                                                              index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    snapshot.data[index].date,
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      fontSize: 20,
                                                      color: (_currentPage ==
                                                              index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 30),
                                                  Text(
                                                    '${snapshot.data[index].newPrice} \$',
                                                    style: AppTheme.heading
                                                        .copyWith(
                                                      color: (_currentPage ==
                                                              index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ChoosePlanDetailes(
                                                        plan: snapshot
                                                            .data[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35)),
                                                color: (_currentPage == index)
                                                    ? Colors.white
                                                    : customColor,
                                                child: Text(
                                                  'التفاصيل',
                                                  style:
                                                      AppTheme.heading.copyWith(
                                                    color:
                                                        (_currentPage == index)
                                                            ? customColor
                                                            : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
    );
  }
}
