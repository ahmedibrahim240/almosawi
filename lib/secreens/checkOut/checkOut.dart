import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/cart/cart.dart';
import 'package:almosawii/secreens/checkOut/components/creatVisaCard.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: FlatButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                flitter(
                  context: context,
                  child: AddFileBottomSheet(),
                );
                setState(() {});
              },
              icon: Icon(
                FontAwesomeIcons.moneyCheckAlt,
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'اضف فيزا',
                style: AppTheme.subHeading.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'الدفع',
          style: AppTheme.heading.copyWith(color: Colors.white),
        ),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              primary: true,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 160,
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    children: [
                      Center(
                        child: Text(
                          'اختر طريقت الدفع ',
                          style: AppTheme.heading.copyWith(
                            color: customColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FutureBuilder(
                        future: helper.allvisa(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return (snapshot.data.isEmpty)
                                ? Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 10),
                                      child: FlatButton.icon(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                            color: customColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          flitter(
                                            context: context,
                                            child: AddFileBottomSheet(),
                                          );
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.moneyCheckAlt,
                                          color: customColor,
                                          size: 20,
                                        ),
                                        label: Text(
                                          'اضف فيزا',
                                          style: AppTheme.subHeading.copyWith(
                                            color: customColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      print(snapshot.data[index]);
                                      return RadioListTile(
                                        groupValue: id,
                                        value: index,
                                        title: Card(
                                          elevation: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          (snapshot.data[index][
                                                                      'type'] ==
                                                                  'visa')
                                                              ? FontAwesomeIcons
                                                                  .ccVisa
                                                              : FontAwesomeIcons
                                                                  .ccMastercard,
                                                          color: Colors.blue,
                                                        ),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '***********' +
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          'visaNumber']
                                                                      .toString()
                                                                      .substring(
                                                                          0, 3),
                                                              style: AppTheme
                                                                  .subHeading,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '***********' +
                                                                  snapshot.data[
                                                                          index]
                                                                          [
                                                                          'cvvNumber']
                                                                      .toString()
                                                                      .substring(
                                                                          0, 3),
                                                              style: AppTheme
                                                                  .subHeading,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              snapshot.data[
                                                                      index]
                                                                  ['exDate'],
                                                              style: AppTheme
                                                                  .subHeading,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "Card Number",
                                                          style: AppTheme
                                                              .subHeading,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "cvv",
                                                          style: AppTheme
                                                              .subHeading,
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "Expriy Date",
                                                          style: AppTheme
                                                              .subHeading,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 30,
                                                child: FlatButton.icon(
                                                  onPressed: () async {
                                                    await helper.deletevisa(
                                                      snapshot.data[index]
                                                          ['id'],
                                                    );
                                                    setState(() {});
                                                  },
                                                  color: Colors.red,
                                                  label: Text(
                                                    'حذف',
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            id = val;
                                          });
                                        },
                                      );
                                    },
                                  );
                          }
                        },
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: customColor),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "السعر الكلي" + ' : ',
                                      style: AppTheme.heading.copyWith(
                                        color: customColor,
                                      ),
                                    ),
                                    Text(
                                      Cart.totalPraices.toString(),
                                      style: AppTheme.heading,
                                    ),
                                  ],
                                ),
                                //
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomButtonWithchild(
                        color: customColor,
                        onPress: () {
                          // setState(() {
                          //   loading = !loading;
                          // });
                          // checkOut(
                          //   consultId: widget.consultantid,
                          //   availableId: widget.avilableId,
                          //   availabeDate: widget.avilableDate,
                          //   snapshot: widget.data,
                          // );
                        },
                        child: Text(
                          'تاكيد',
                          style: AppTheme.heading.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
