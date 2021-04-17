import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/recommendModels.dart';
import 'package:almosawii/secreens/Recommendations/recommendations.dart';
import 'package:flutter/material.dart';

class Archives extends StatefulWidget {
  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أرشيف التوصيات'),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          gardViewOfAllCourses(context: context),
        ],
      ),
    );
  }

  gardViewOfAllCourses({BuildContext context}) {
    return GridView.count(
      crossAxisCount: 1,
      primary: false,
      childAspectRatio: 1,
      shrinkWrap: true,
      children: List.generate(
        recommendList.length,
        (index) {
          return Column(
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
                      color: (recommendList[index].stockRatio < 0)
                          ? Colors.red
                          : customColor,
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/graph.jpeg'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomButton(
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Recommendations(),
                    ),
                  );
                },
                text: 'عرض نصائح أستاذ احمد',
              ),
            ],
          );
        },
      ),
    );
  }
}
