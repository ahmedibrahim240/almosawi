import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/theBolg.dart';
import 'package:almosawii/models/videoProChartApi.dart';
import 'package:almosawii/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';
import 'package:vimeoplayer/vimeoplayer.dart';

class VideosProChartDetaills extends StatefulWidget {
  final VideoProChart videoProChart;

  const VideosProChartDetaills({Key key, this.videoProChart}) : super(key: key);
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
          (widget.videoProChart.videoCode == '')
              ? Container(
                  child: customCachedNetworkImage(
                    context: context,
                    url: widget.videoProChart.image,
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: VimeoPlayer(
                    id: widget.videoProChart.videoCode,
                    autoPlay: false,
                  ),
                ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              widget.videoProChart.title,
              style: AppTheme.heading.copyWith(color: customColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              parseHtmlString(widget.videoProChart.description),
              textAlign: TextAlign.justify,
              style: AppTheme.subHeading,
            ),
          ),
        ],
      ),
    );
  }
}
