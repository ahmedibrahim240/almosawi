import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/recommendModels.dart';
import 'package:flutter/material.dart';

class RecommendationsDetailes extends StatefulWidget {
  final RecommendModels recommend;

  const RecommendationsDetailes({Key key, @required this.recommend})
      : super(key: key);
  @override
  _RecommendationsDetailesState createState() =>
      _RecommendationsDetailesState();
}

class _RecommendationsDetailesState extends State<RecommendationsDetailes> {
  bool tappd = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.recommend.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'العملة /الزوج',
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(width: 10),
              (count == 2)
                  ? Container(
                      child: Text(
                        ' تم دخول الصفقة من قبل',
                        style: AppTheme.headingColorBlue.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Expanded(
                      child: CustomButtonWithchild(
                        child: Text(
                          (tappd) ? 'خروج' : 'دخول',
                          style: AppTheme.heading.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        color: (tappd) ? Colors.red : customColor,
                        onPress: () {
                          setState(() {
                            tappd = !tappd;
                            count = count + 1;
                          });
                        },
                      ),
                    ),
            ],
          ),
          Text(
            widget.recommend.title,
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'االأتجاة',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.contant,
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'النموذج',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.contant.toString(),
            style: AppTheme.heading,
          ),
          Text(
            'مناطق الشرائية',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.stockNumber.toString(),
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'مناطق البيعية',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.stockNumber.toString(),
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'الأهداف لمناطق الشرائية',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.stockNumber.toString(),
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'إيقاف الخسارة لمناطق الشراء',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.stockNumber.toString(),
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
          Text(
            'إيقاف الخسارة لمناطق البيع',
            style: AppTheme.heading.copyWith(
              color: customColor,
              fontSize: 16,
            ),
          ),
          Text(
            widget.recommend.stockNumber.toString(),
            style: AppTheme.heading,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
