import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/chat.dart';
import 'package:almosawii/secreens/chatRome/chatRome.dart';
import 'package:flutter/material.dart';

class LastMessges extends StatefulWidget {
  @override
  _LastMessgesState createState() => _LastMessgesState();
}

class _LastMessgesState extends State<LastMessges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatRome(
                        title: chatList[index].title,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatList[index].message,
                            style: AppTheme.subHeading,
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                chatList[index].time,
                                style: AppTheme.subHeading.copyWith(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Divider(
                  color: customColorDivider,
                  thickness: 2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
