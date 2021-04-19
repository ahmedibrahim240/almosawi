import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/MyRoomsApi.dart';
import 'package:almosawii/secreens/my%20courses/components/videoscreens.dart';
import 'package:flutter/material.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

class ALLRomes extends StatefulWidget {
  @override
  _ALLRomesState createState() => _ALLRomesState();
}

class _ALLRomesState extends State<ALLRomes> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'غرفه pro Chart',
      )),
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
                future: MyRoomsApi.fetchAllMyRooms(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return (snapshot.data == null || snapshot.data.isEmpty)
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'لا يوجد بينات حاليا /',
                                  style: AppTheme.heading,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'اسحب الشاشه لاسفل لاعاده التحميل',
                                  style: AppTheme.heading,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Card(
                                    elevation: 3,
                                    child: InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(snapshot.data[index].name),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProchartRoom(
                                              rooms: snapshot.data[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Divider(
                                    color: customColorDivider,
                                    thickness: 2,
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

class ProchartRoom extends StatefulWidget {
  final MyRooms rooms;

  const ProchartRoom({
    Key key,
    this.rooms,
  }) : super(key: key);
  @override
  _ProchartRoomState createState() => _ProchartRoomState();
}

class _ProchartRoomState extends State<ProchartRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rooms.name),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: widget.rooms.chats.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: dateType(
                  context: context,
                  type: widget.rooms.chats[index]['type'],
                  data: widget.rooms.chats[index]['data'],
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  dateType({String type, String data, BuildContext context}) {
    // final assetsAudioPlayer = AssetsAudioPlayer();
    switch (type) {
      case 'text':
        return Card(
          elevation: 3,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              data,
              style: AppTheme.subHeading,
            ),
          ),
        );

        break;
      case 'image':
        return Card(
          elevation: 3,
          child: customCachedNetworkImage(context: context, url: data),
        );

        break;
      case 'video':
        return Card(
          elevation: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 260,
            child: ChewieVideo(
              videoUrl: data,
            ),
          ),
        );

        break;
      // case 'audio':
      //   return await assetsAudioPlayer.open(
      //     Audio.network(
      //       data,
      //       // metas: Metas(
      //       //   id: 'Online',
      //       //   title: 'Online',
      //       //   artist: 'Florent Champigny',
      //       //   album: 'OnlineAlbum',
      //       //   // image: MetasImage.network('https://www.google.com')
      //       //   image: MetasImage.network(
      //       //       'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      //       // ),
      //     ),
      //   );

      //   break;
      default:
        return null;
    }
  }
}
