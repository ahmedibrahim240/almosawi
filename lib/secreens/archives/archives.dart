import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/RecomendationsApi.dart';
import 'package:almosawii/models/recommendModels.dart';
import 'package:almosawii/secreens/Recommendations/recommendations.dart';
import 'package:almosawii/secreens/archives/archiveRecoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Archives extends StatefulWidget {
  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أرشيف التوصيات'),
      ),
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
            : FutureBuilder(
                future: RecomendationsApi.fetchAllArchiveRecomendations(
                    type: "archive"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return (snapshot.data == null || snapshot.data.isEmpty)
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
                        : ListView(
                            shrinkWrap: true,
                            primary: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'الاسم',
                                      style: AppTheme.heading.copyWith(
                                        color: customColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'المعدل',
                                      style: AppTheme.heading.copyWith(
                                        color: customColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ArchiveRecomPage(
                                            title: snapshot
                                                .data[index].currencyName,
                                            recommend: snapshot
                                                .data[index].recomendations,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data[index].currencyName,
                                              style:
                                                  AppTheme.heading.copyWith(),
                                            ),
                                            (snapshot.data[index].arrow == 'up')
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
                                                      ),
                                                    ),
                                                  ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data[index].number,
                                                  style:
                                                      AppTheme.heading.copyWith(
                                                    color: (snapshot.data[index]
                                                                .arrow !=
                                                            'up')
                                                        ? Colors.red
                                                        : customColor,
                                                  ),
                                                ),
                                                Transform.rotate(
                                                  angle: 180 * 3.14 / 180,
                                                  child: Icon(
                                                    Icons.arrow_back_ios,
                                                    size: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
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
