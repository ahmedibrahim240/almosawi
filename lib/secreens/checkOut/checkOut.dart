import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';
import 'package:almosawii/secreens/cart/cart.dart';

import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOut extends StatefulWidget {
  final String totalPrice;

  final AsyncSnapshot data;

  const CheckOut({
    Key key,
    this.totalPrice,
    this.data,
  }) : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DbHehper helper;
  bool loading = false;
  @override
  void initState() {
    helper = DbHehper();
    super.initState();
  }

  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: customColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Wrapper()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'الدفع',
          style: AppTheme.heading.copyWith(color: Colors.white),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return MyFatoorah(
            request: MyfatoorahRequest(
              url: "https://apitest.myfatoorah.com",
              token:
                  "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
              currencyIso: Country.UAE,
              successUrl:
                  "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
              errorUrl:
                  "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
              invoiceAmount: Cart.totalPraices,
              language: ApiLanguage.Arabic,
            ),
            errorChild: Center(
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
            succcessChild: Center(
              child: Icon(
                Icons.done_all,
                color: Colors.greenAccent,
                size: 50,
              ),
            ),
            onResult: (PaymentResponse res) {
              print(res);

              checkOut(item: widget.data, paymentData: res.status);
            },
          );
        },
      ),
    );
  }

  checkOut({var item, var paymentData}) async {
    List data = [];
    try {
      print('User.userid:${User.userid}');
      for (var items in item.data) {
        var obj = {
          'id': items['consultantId'],
          'type': items['type'],
        };
        data.add(obj);
      }
      print('data:::$data');
      var body = {
        'user_id': User.userid,
        'items': data,
        'total': Cart.totalPraices.toString(),
        'payment_data': paymentData.toString(),
        'success': "success",
      };
      print(body);

      var response = await http.post(
        Utils.SubmitCartItems_URL,
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );

      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');

      print(jsonData);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Wrapper(),
        ),
      );

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
      print('Cash carrrrrrrrt');
      setState(() {});

      print(e);
    }
  }
}
