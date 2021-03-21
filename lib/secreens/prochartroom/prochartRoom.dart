import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';

class ProchartRoom extends StatefulWidget {
  @override
  _ProchartRoomState createState() => _ProchartRoomState();
}

class _ProchartRoomState extends State<ProchartRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ChewieVideo(),
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'بلا بلا بللا بلا بلا بللابلا بلا بللا',
                  style: AppTheme.subHeading,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: customColorDivider,
                        thickness: 2,
                      ),
                    ),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
