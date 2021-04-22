import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/prodact.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/checkOut/checkOut.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../sharedPreferences.dart';

class Cart extends StatefulWidget {
  static List<ConsultantProdect> consultProdect = [];
  static double totalPraices = 0.0;

  static SharedPreferences sharedPreferences;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DbHehper helper;
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
    User.userBuyPlan = await MySharedPreferences.getUserBuyPlan();
  }

  @override
  void initState() {
    helper = DbHehper();
    getTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Cart.totalPraices:${Cart.totalPraices}');
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text('عربة التسوق'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => Wrapper()),
              (route) => false,
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: helper.allProduct(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            return (snapshot.data.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.shoppingCart,
                          color: customColor,
                          size: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'السله فارغه',
                          style: AppTheme.heading,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text(
                                        'الاسم: ',
                                        style: AppTheme.heading.copyWith(
                                          color: customColor,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index]['title'],
                                        style: AppTheme.subHeading.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'السعر: ',
                                            style: AppTheme.heading.copyWith(
                                              color: customColor,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]['price']
                                                .toString(),
                                            style: AppTheme.subHeading.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Icon(
                                            FontAwesomeIcons.poundSign,
                                            color: Colors.black,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        setState(() {
                                          if (snapshot.data[index]['type'] ==
                                              'plan') {
                                            setState(() {
                                              MySharedPreferences
                                                  .saveUserPayPlan(false);
                                            });
                                          }
                                        });
                                      });
                                      await helper.deleteProduct(
                                          snapshot.data[index]['id']);
                                      decreaseCartTotlaPrice(
                                        price: snapshot.data[index]['price'],
                                      );
                                    },
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: customCachedNetworkImage(
                                      context: context,
                                      url: snapshot.data[index]["proImageUrl"],
                                    ),
                                  ),
                                ),

                                // productDate(snapshot, index),
                              ],
                            ),
                          ),
                          (index == snapshot.data.length - 1)
                              ? totalPrieCard(
                                  context: context,
                                  data: snapshot,
                                )
                              : Container(),
                        ],
                      );
                    },
                  );
          }
        },
      ),
    );
  }

  Container totalPrieCard({
    BuildContext context,
    AsyncSnapshot data,
  }) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: customColor),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'السعر الكلي: ',
                    style: AppTheme.subHeading.copyWith(),
                  ),
                  Text(
                    Cart.totalPraices.toStringAsFixed(2),
                    style: AppTheme.subHeading.copyWith(
                      color: customColor,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: FlatButton.icon(
                  color: customColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (Cart.totalPraices == 0.0) {
                      print('TOOOOOOOOOOOOOTL PRICE + ZERRRRRRRO');
                      checkOut(item: data);
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CheckOut(
                            totalPrice: Cart.totalPraices.toString(),
                            data: data,
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.moneyCheckAlt,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: Text(
                    'الدفع',
                    style: AppTheme.subHeading.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkOut({var item}) async {
    List data = [];
    for (var items in item.data) {
      var obj = {
        'id': items['consultantId'],
        'type': items['type'],
      };
      data.add(obj);
    }
    print('data:::$data');
    try {
      print('User.userid:${User.userid}');
      var body = {
        'user_id': User.userid,
        'items': data,
        'total': Cart.totalPraices.toString(),
        'payment_data': null,
        'success': "success",
      };

      var response = await http.post(
        Utils.SubmitCartItems_URL,
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');

      print("jsonData::::$jsonData");

      // if (jsonData['status'] == 'success') {
      //   print('proChartRooms' + jsonData['UserData']['proChartRooms']);
      //   if (jsonData['UserData']['proChartRooms'] == '0' &&
      //       jsonData['UserData']['proChartVideos'] == '0' &&
      //       jsonData['UserData']['Courses'] == '0' &&
      //       jsonData['UserData']['Recomendations'] == '0') {
      //     setState(() {
      //       MySharedPreferences.saveUserSkipLogIn(false);
      //     });
      //   } else {
      //     setState(() {
      //       MySharedPreferences.saveUserSkipLogIn(true);
      //     });
      //   }
      //   User.userSkipLogIn = await MySharedPreferences.getUserSkipLogIn();
      // } else {
      //   setState(() {});
      // }
    } catch (e) {
      print('Cash wallpaper');
      setState(() {});

      print(e);
    }
  }
}
