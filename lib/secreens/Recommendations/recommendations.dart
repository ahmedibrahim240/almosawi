import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/recommendModels.dart';
import 'package:almosawii/secreens/Recommendations/recommendationsDetailes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Recommendations extends StatefulWidget {
  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: [
            // slider(),
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
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: recommendList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RecommendationsDetailes(
                          recommend: recommendList[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        recommendList[index].title,
                                        style: AppTheme.subHeading,
                                      ),
                                      Text(
                                        '(${recommendList[index].stockNumber})',
                                        style: AppTheme.subHeading,
                                      ),
                                      Text(
                                        (recommendList[index].stockRatio < 0)
                                            ? '${recommendList[index].stockRatio}%'
                                            : '+${recommendList[index].stockRatio}%',
                                        style: AppTheme.subHeading.copyWith(
                                          color:
                                              (recommendList[index].stockRatio <
                                                      0)
                                                  ? Colors.red
                                                  : customColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    recommendList[index].date,
                                    style: AppTheme.subHeading
                                        .copyWith(color: customColorDivider),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    (recommendList[index].stockRatio < 0)
                                        ? 'نشط'
                                        : 'انتظر',
                                    style: AppTheme.heading,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'نقطه +222',
                                    style: AppTheme.heading.copyWith(
                                      color: customColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'اكير مكسب',
                                    style: AppTheme.heading,
                                  ),
                                  Text(
                                    '(${recommendList[index].biggestGain})',
                                    style: AppTheme.subHeading,
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
                                    '(${recommendList[index].lessLoss})',
                                    style: AppTheme.subHeading,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'سعر الدخول',
                                    style: AppTheme.heading,
                                  ),
                                  Text(
                                    '(${recommendList[index].entryPrice})',
                                    style: AppTheme.subHeading,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepOrange,
                                ),
                                child: Center(
                                  child: Text(
                                    'طول المده',
                                    style: AppTheme.heading
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              Text(
                                'شراء / بيع ',
                                style: AppTheme.heading.copyWith(
                                  color: customColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (recommendList[index].stockRatio < 0)
                                      ? SvgPicture.asset(
                                          'lib/icons/stockUp.svg',
                                          color: customColor,
                                          height: 15,
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: AssetImage(
                                                'lib/images/chartlineDown.png'),
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                  SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'سعر الخروج',
                                        style: AppTheme.heading,
                                      ),
                                      Text(
                                        '(${recommendList[index].checkOutPrice})',
                                        style: AppTheme.subHeading,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            '(${recommendList[index].contant})',
                            style: AppTheme.subHeading,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
