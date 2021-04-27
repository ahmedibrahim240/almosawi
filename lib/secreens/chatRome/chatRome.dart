import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/MyMessagesApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:almosawii/models/utils.dart';

import 'dart:io';
import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:dio/dio.dart';

class ChatRome extends StatefulWidget {
  final String title;
  final MyMassege message;
  final int messageID;

  const ChatRome({Key key, this.title, this.message, this.messageID})
      : super(key: key);
  @override
  _ChatRomeState createState() => _ChatRomeState();
}

class _ChatRomeState extends State<ChatRome> {
  List<String> messageList = [];
  TextEditingController _messageController = TextEditingController();
  List<File> listFiles = [];
  bool loading = false;

  get customColorbottomBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: widget.message.comments.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parseHtmlString(
                                      widget.message.name,
                                    ),
                                    style: AppTheme.subHeading,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    parseHtmlString(
                                      widget.message.comments[index]['content'],
                                    ),
                                    style: AppTheme.subHeading,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: messageTextFiled(),
            ),
          ],
        ),
      ),
    );
  }

  sentData({
    String message,
    int messageID,
    List<File> files,

    // ignore: non_constant_identifier_names
  }) async {
    print(files.isEmpty);
    try {
      var data;
      // ignore: prefer_is_not_empty
      if (!files.isEmpty) {
        var filesForm = [];
        for (var items in files) {
          filesForm.add(await MultipartFile.fromFile(
            items.path,
            filename: items.path.split('/').last,
          ));
        }

        print('filesForm:$filesForm');

        print('filesForm[0]:${filesForm[0]}');
        data = FormData.fromMap({
          'Comment': message,
          "files": filesForm,
        });
      } else {
        print(files.isEmpty);

        data = FormData.fromMap({
          'Comment': message,
          "files": [],
        });
      }
      Dio dio = new Dio();
      Response response = await dio.post(
          Utils.MyMessages_URL + '/${User.userid}/$messageID',
          data: data);

      if (response.data['status'] == 'success') {
        showMyDialog(
          context: context,
          message: "تم ارسال الرسالة بنجاح",
        );
        setState(() {
          loading = !loading;
        });

        listFiles.clear();
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
          context: context,
          message: response.data['errorArr'].toString(),
        );
      }
      listFiles.clear();
    } catch (e) {
      print('Cash errrrrrrrrrrrrrrror');
      setState(() {
        loading = !loading;
      });
      showMyDialog(
        context: context,
        message: "حدث خطا اثناء الارسال يرجي المحاوله مجددا",
      );

      listFiles.clear();
      print(e);
    }
  }

  Container serviesMessage({String message}) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: customColorbottomBar,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          message,
          textDirection: TextDirection.ltr,
          style: AppTheme.subHeading,
        ),
      ),
    );
  }

  Container messageTextFiled() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: customColor2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              maxLines: null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText:
                    (loading) ? 'جاري ارسال الرساله....' : 'اكتب تعليق ....',
                hintStyle: AppTheme.subHeading.copyWith(
                  fontSize: 10,
                  color: customColorIcon,
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  List<File> res = await FilePicker.getMultiFile(
                    type: FileType.any,
                  );
                  if (res == null) {
                  } else {
                    listFiles = res;
                    fileDialog(
                      context: context,
                      message: 'تم اضاقه ${listFiles.length} ملفات',
                    );
                  }
                },
                icon: Icon(Icons.upload_file),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    loading = !loading;
                    messageList.add(_messageController.text);
                    sentData(
                      message: _messageController.text,
                      messageID: widget.message.id,
                      files: listFiles,
                    );
                    _messageController.text = '';
                  });
                },
                child: Container(
                  child: Icon(
                    Icons.send,
                    color: customColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> fileDialog({BuildContext context, String message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    (message) ??
                        'تم اضافة الطلب لستكمال عمليه الشراء عليه الذهاب الي عربة التسوق',
                    style: AppTheme.subHeading,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'حسنا',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'الغاء',
                style: AppTheme.heading.copyWith(
                  color: customColor,
                ),
              ),
              onPressed: () {
                listFiles.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
