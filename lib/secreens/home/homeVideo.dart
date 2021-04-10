import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
// import 'package:vimeoplayer_trinity/vimeoplayer_trinity.dart';

class HomeVideo extends StatefulWidget {
  @override
  _HomeVideoState createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  String conant =
      'محاضرة مجانية، طريقك للنجاح وتطوير عملك في مجال التداول والفوركس مع أحمد الموسوي';
  List<String> rowText = [
    'تمنحك بداية صحيحة وتتعرف على مكان الخلل في طريقة التداول',
    'تستفيد من أخطائي في التداول',
    'تمدك بكل ما تحتاجه لتصبح متداولا محترفا، وتمكنك من جني أرباح من سوق التداول انطلاقا من تجربتي الخاصة',
  ];
  List ides = ['395212534', '528749215', '509764916'];
  int index = 0;
  String id;
  @override
  void initState() {
    if (index == 0) {
      id = ides[index];
    } else {
      addVideo();
    }
    super.initState();
  }

  addVideo() {
    print('length:${ides.length}');
    setState(() {
      index = index + 1;
    });

    if (index >= ides.length) {
      setState(() {
        index = 0;
        id = ides[index];
      });
    } else {
      setState(() {
        id = ides[index];
      });
    }
    print('id:$id');
    print('index:$index');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'lib/images/homeback.jpg',
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Column(
              children: [
                VimeoPlayer(id: id, autoPlay: false),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      addVideo();
                    });
                  },
                  child: Text('add video'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black.withOpacity(.5),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Text(
                  conant,
                  style: AppTheme.subHeading.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: rowText.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: Text(
                                rowText[index],
                                style: AppTheme.subHeading.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
