import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';

class VideosProChartDetaills extends StatefulWidget {
  final TheBolg theBolg;

  const VideosProChartDetaills({Key key, this.theBolg}) : super(key: key);
  @override
  _VideosProChartDetaillsState createState() => _VideosProChartDetaillsState();
}

class _VideosProChartDetaillsState extends State<VideosProChartDetaills> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          Card(
            elevation: 3,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: ChewieVideo(),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    widget.theBolg.name,
                    style: AppTheme.heading,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              widget.theBolg.contant,
              textAlign: TextAlign.justify,
              style: AppTheme.subHeading,
            ),
          ),
        ],
      ),
    );
  }
}
