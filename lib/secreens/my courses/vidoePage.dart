import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

class MyCoursesVideoPage extends StatefulWidget {
  final String title;
  final String videoId;

  const MyCoursesVideoPage({Key key, this.title, this.videoId})
      : super(key: key);
  @override
  _MyCoursesVideoPageState createState() => _MyCoursesVideoPageState();
}

class _MyCoursesVideoPageState extends State<MyCoursesVideoPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (widget.videoId == '')
          ? Center(
              child: Container(
                child: Text(
                  'سيتوفر الفصل قريبا',
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
              ),
            )
          : VimeoPlayer(id: widget.videoId, autoPlay: false),
    );
  }
}
