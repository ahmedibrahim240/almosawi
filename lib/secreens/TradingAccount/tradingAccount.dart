import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/proChartVipApi.dart';
import 'package:almosawii/models/tradingAccountModels.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TradingAccount extends StatefulWidget {
  @override
  _TradingAccountState createState() => _TradingAccountState();
}

class _TradingAccountState extends State<TradingAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'فتح حساب تداول ',
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        children: [
          FutureBuilder(
            future: ProChartVIPModelsApi.futchProChartVIP(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return (snapshot.data == null)
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data.trading.length,
                        itemBuilder: (context, index) {
                          return tradingAccountRow(
                            contant: snapshot.data.trading[index]['text'],
                            name: snapshot.data.trading[index]['title'],
                            icon: snapshot.data.trading[index]['image'],
                            index: index + 1,
                          );
                        },
                      );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'الاسم',
                    prefixIcon: Icons.person,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'الدوله',
                    prefixIcon: FontAwesomeIcons.globe,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'رقم الواتس',
                    prefixIcon: FontAwesomeIcons.whatsapp,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'البريد الإلكتروني',
                    prefixIcon: Icons.email,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'مبلغ الاستثمار',
                    prefixIcon: FontAwesomeIcons.dollarSign,
                    suffixIcon: Icons.edit,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: CustomButton(
              onPress: () {},
              text: 'اضافه ملف / صورة',
            ),
          ),
          CustomButton(
            onPress: () {},
            text: 'ارسال',
          ),
        ],
      ),
    );
  }

  tradingAccountRow({String name, String contant, String icon, int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              index.toString(),
              style: AppTheme.heading,
            ),
            SizedBox(width: 10),
            Container(
              width: 1,
              height: 30,
              color: customColorGray.withOpacity(.5),
            ),
            SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(icon),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: AppTheme.heading,
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          contant,
          style: AppTheme.subHeading.copyWith(
            color: customColorGray,
            fontSize: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Divider(
            color: customColor.withOpacity(.5),
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
