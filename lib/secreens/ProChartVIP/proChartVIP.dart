import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/proChartVipApi.dart';
import 'package:almosawii/secreens/ChoosePlan/choosePlan.dart';
import 'package:flutter/material.dart';

class ProChartVIP extends StatefulWidget {
  @override
  _ProChartVIPState createState() => _ProChartVIPState();
}

class _ProChartVIPState extends State<ProChartVIP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 40),
        children: [
          FutureBuilder(
            future: ProChartVIPModelsApi.futchAboutUs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return (snapshot.data == null)
                    ? Container()
                    : ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       border: Border.all(
                          //         color: customColor,
                          //       )),
                          //   child: Center(
                          //     child: customCachedNetworkImage(
                          //       context: context,
                          //       url: snapshot.data.image,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 20),
                          Text(
                            snapshot.data.title,
                            style: AppTheme.heading,
                          ),
                          SizedBox(height: 10),
                          Text(
                            parseHtmlString(
                              snapshot.data.des,
                            ),
                            style: AppTheme.subHeading,
                          ),
                          SizedBox(height: 20),
                        ],
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          CustomButton(
            onPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChoosePlan(),
                ),
              );
            },
            text: 'اشترك',
          ),
        ],
      ),
    );
  }
}
