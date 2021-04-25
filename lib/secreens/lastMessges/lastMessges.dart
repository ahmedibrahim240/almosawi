import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/MyMessagesApi.dart';
import 'package:almosawii/secreens/chatRome/chatRome.dart';
import 'package:almosawii/secreens/contactUs/contactUs.dart';
import 'package:flutter/material.dart';

class LastMessges extends StatefulWidget {
  @override
  _LastMessgesState createState() => _LastMessgesState();
}

class _LastMessgesState extends State<LastMessges> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المرسلات السابقة'),
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
                future: MyMessageApi.fetchAllMyMassege(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return (snapshot.data == null || snapshot.data.isEmpty)
                        ? Center(
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ContactUs()),
                                );
                              },
                              color: customColor,
                              child: Text(
                                'اشترك الان',
                                style: AppTheme.heading
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ChatRome(
                                            title: 'Ahmed AlMOSAWI',
                                            message: snapshot.data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        elevation: 3,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                parseHtmlString(snapshot
                                                    .data[index].content),
                                                style: AppTheme.subHeading,
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                    snapshot.data[index].date,
                                                    style: AppTheme.subHeading
                                                        .copyWith(
                                                      fontSize: 10,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Divider(
                                      color: customColorDivider,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
      ),
    );
  }
}
