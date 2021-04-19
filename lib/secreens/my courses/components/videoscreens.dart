import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideo extends StatefulWidget {
  final String videoUrl;

  const ChewieVideo({Key key, @required this.videoUrl}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ChewieVideoState();
  }
}

class _ChewieVideoState extends State<ChewieVideo> {
  VideoPlayerController _videoPlayerController1;

  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // runVideo();
  }

  @override
  void deactivate() {
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    // _controller.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
      widget.videoUrl,
    );
    await _videoPlayerController1.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      allowFullScreen: true,
      fullScreenByDefault: true,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _chewieController != null &&
              _chewieController.videoPlayerController.value.initialized
          ? Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.white,
              ),
              child: Chewie(
                controller: _chewieController,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'loading',
                ),
              ],
            ),
    );

    //  Column(
    //   children: [
    //     // YoutubePlayerBuilder(
    //     //   player: YoutubePlayer(
    //     //     controller: _controller,
    //     //   ),
    //     //   builder: (context, player) {
    //     //     return Container();
    //     //   },
    //     // ),
    //     Center(
    //       child: _chewieController != null &&
    //               _chewieController.videoPlayerController.value.initialized
    //           ? Theme(
    //               data: Theme.of(context).copyWith(
    //                 dialogBackgroundColor: Colors.white,
    //               ),
    //               child: Chewie(
    //                 controller: _chewieController,
    //               ),
    //             )
    //           : Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: const [
    //                 CircularProgressIndicator(),
    //                 SizedBox(height: 20),
    //                 Text(
    //                   'loading',
    //                 ),
    //               ],
    //             ),
    //     ),
    //   ],
    // );
  }
}
