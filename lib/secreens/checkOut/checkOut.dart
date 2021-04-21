import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';

import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

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
              currencyIso: Country.SaudiArabia,
              successUrl:
                  "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
              errorUrl:
                  "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
              invoiceAmount: 100,
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
            },
          );
        },
      ),
    );
  }

//   checkOut({
//     int consultId,
//     int availableId,
//     String availabeDate,
//     AsyncSnapshot snapshot,
//   }) async {
//     List<int> coursesID = [];
//     List<int> eventID = [];
//     var visit;
//     for (var items in snapshot.data) {
//       switch (items['type']) {
//         case 'visit':
//           visit = {
//             "visit_date": items['date'],
//             "consultant_id": items['consultantId'],
//             "available_id": items['dateId'],
//           };

//           break;
//         case 'courses':
//           print('items:${items['consultantId']}');
//           coursesID.add(items['consultantId']);
//           break;
//         case 'events':
//           print('items:${items['consultantId']}');

//           eventID.add(items['consultantId']);
//           break;
//       }
//     }
//     var body = {
//       'visit': visit,
//       'courses': coursesID,
//       'events': eventID,
//     };

//     // print(jsonEncode(body));
//     // print(jsonEncode(coursesID));
//     // print(jsonEncode(eventID));
//     try {
//       var response = await http.post(
//         Utils.CHECKOUT_URL,
//         body: jsonEncode(body),

//         // {
//         //   'visit': visit,
//         //   'courses': jsonEncode(coursesID),
//         //   'events': jsonEncode(eventID),
//         // },
//         headers: {
//           'x-api-key': User.userToken,
//           'Content-Type': 'application/json'
//         },
//       );

//       Map<String, dynamic> map = json.decode(response.body);
//       print(response.body);

//       if (map['success'] == true) {
//         setState(() {
//           loading = !loading;
//           _totalPrice = '';
//         });
//         print(map);
//         await helper.deleteAllProduct();
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (_) => SucessfullyBooked(),
//           ),
//         );
//       } else {
//         setState(() {
//           loading = !loading;
//         });

//         _scaffoldKey.currentState.showSnackBar(
//           new SnackBar(
//             content: new Text(
//                 'Your reservation failed,please try again${map['message']}'),
//           ),
//         );
//       }

//       // Navigator.pop(context);
//     } catch (e) {
//       setState(() {
//         loading = !loading;
//       });
//       print('erroooooooooooor');
//       print(e.toString());
//     }
//   }
// }

// class Visit {
//   // ignore: non_constant_identifier_names
//   final int consultant_id;
//   // ignore: non_constant_identifier_names
//   final int available_id;
//   // ignore: non_constant_identifier_names
//   final String visit_date;

//   // ignore: non_constant_identifier_names
//   Visit({this.consultant_id, this.available_id, this.visit_date});
}
