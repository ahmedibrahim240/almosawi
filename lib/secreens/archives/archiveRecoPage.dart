import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/RecomendationsApi.dart';
import 'package:almosawii/secreens/Recommendations/recommendationsDetailes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArchiveRecomPage extends StatefulWidget {
  final String title;
  final List<RecomendationsModels> recommend;

  const ArchiveRecomPage({Key key, this.title, this.recommend})
      : super(key: key);
  @override
  _ArchiveRecomPageState createState() => _ArchiveRecomPageState();
}

class _ArchiveRecomPageState extends State<ArchiveRecomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: widget.recommend.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RecommendationsDetailes(
                    recommend: widget.recommend[index],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.recommend[index].name,
                                  style: AppTheme.subHeading,
                                ),
                                Text(
                                  '(${widget.recommend[index].txtBesideName})',
                                  style: AppTheme.subHeading,
                                ),
                                Text(
                                  widget.recommend[index].percentageTxt,
                                  style: AppTheme.subHeading.copyWith(
                                    color:
                                        (widget.recommend[index].statusLoss ==
                                                'مكسب')
                                            ? customColor
                                            : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              widget.recommend[index].dayDate,
                              style: AppTheme.subHeading.copyWith(
                                color: customColorDivider,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.recommend[index].status,
                              style: AppTheme.heading,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'نقطه ${widget.recommend[index].points}',
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
                              'سعر الدخول',
                              style: AppTheme.heading,
                            ),
                            Text(
                              '(${(widget.recommend[index].entryPrice) ?? ''})',
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
                              '(${(widget.recommend[index].outPrice) ?? ''})',
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
                              '(${(widget.recommend[index].bigPrice) ?? ''})',
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.deepOrange,
                          ),
                          child: Center(
                            child: Text(
                              (widget.recommend[index].theTime) ?? '',
                              style: AppTheme.heading.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          (widget.recommend[index].buyOrSale) ?? '',
                          style: AppTheme.heading.copyWith(
                            color:
                                (widget.recommend[index].statusLoss == 'مكسب')
                                    ? customColor
                                    : Colors.red,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (widget.recommend[index].statusLoss == 'gain')
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'اقل خساره',
                                  style: AppTheme.heading,
                                ),
                                Text(
                                  '(${(widget.recommend[index].smallPrice) ?? ''})',
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
                      '(${(widget.recommend[index].comment) ?? ''})',
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
  }
}
