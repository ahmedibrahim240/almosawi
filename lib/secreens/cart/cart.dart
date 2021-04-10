import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/prodact.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  double totalPrice = 0.0;
  DbHehper helper;
  getTotalPrice() async {
    Cart.totalPraices = await MySharedPreferences.getTotalPrice();
  }

  @override
  void initState() {
    helper = DbHehper();
    getTotalPrice();
    super.initState();
  }

  culcTotalPrice(double price) {
    totalPrice = totalPrice + price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
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
          print('!snapshot.hasData:${!snapshot.hasData}');
          if (!snapshot.hasData) {
            print('isEmpaty');
            return Container(
              height: 100,
              width: 100,
              color: Colors.amber,
              child: Text(
                'is empty',
                style: AppTheme.heading.copyWith(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            print(' snapshot.data.isEmpty:${snapshot.data.isEmpty}');
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
                                          decreaseCartTotlaPrice(
                                            price: snapshot.data[index]
                                                ['price'],
                                          );
                                        });
                                      });

                                      await helper.deleteProduct(
                                          snapshot.data[index]['id']);
                                    },
                                  ),
                                  leading: CircleAvatar(
                                    maxRadius: 30,
                                    backgroundImage: NetworkImage(
                                      snapshot.data[index]["proImageUrl"],
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

  Padding productDate(AsyncSnapshot snapshot, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: AppTheme.heading.copyWith(
                      color: customColor,
                    ),
                  ),
                  Text(
                    snapshot.data[index]['date'],
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    'Time: ',
                    style: AppTheme.heading.copyWith(
                      color: customColor,
                    ),
                  ),
                  Text(
                    snapshot.data[index]['time'],
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container totalPrieCard({
    BuildContext context,
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
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => CheckOut(
                    //       totalPrice: totalPrice.toString(),
                    //       consultantid: consualtId,
                    //       avilableId: availableId,
                    //       productId: prodectId,
                    //       avilableDate: availableDate,
                    //     ),
                    //   ),
                    // );
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
}
