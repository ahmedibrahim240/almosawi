import 'dart:convert';
import 'dart:io';

import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/contactUsApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:almosawii/models/utils.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:gx_file_picker/gx_file_picker.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email;
  String name;
  String phone;
  String message;
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                firstSections(),
                SizedBox(height: 20),
                Text(
                  'لديك سؤال عن الفوركس أو تريد أن تسأل عن تحليل أو تريد المشاركة معنا؟',
                  style: AppTheme.heading.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                contactUsForm(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: CustomButton(
                    onPress: () async {
                      List<File> res = await FilePicker.getMultiFile(
                        type: FileType.any,
                      );
                      if (res == null) {
                        print('NOOOOOOOOO FILE PICE');
                      } else {
                        files = res;
                        fileDialog(
                          context: context,
                          message: 'تم اضاقه ${files.length} ملفات',
                        );
                      }
                    },
                    text: 'اضافه ملف / صورة',
                  ),
                ),
                CustomButton(
                  onPress: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = !loading;
                      });

                      sentData(
                        userName: name,
                        user_id: User.userid,
                        message: message,
                        mobile: phone,
                        email: email,
                        files: files,
                        deviceToken: User.userToken,
                      );
                    }
                  },
                  text: 'ارسال',
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
                files.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  contactUsForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: textFormInputDecoration(
              label: 'الاسم',
              prefixIcon: Icons.person,
              suffixIcon: Icons.edit,
            ),
            validator: (val) => val.isEmpty ? nameEror : null,
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: textFormInputDecoration(
              label: 'البريد الإلكتروني',
              prefixIcon: Icons.email,
              suffixIcon: Icons.edit,
            ),
            validator: (val) => val.isEmpty ? emailEror : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: textFormInputDecoration(
              label: 'رقم الهاتف',
              prefixIcon: Icons.phone,
              suffixIcon: Icons.edit,
            ),
            validator: (val) => val.isEmpty ? phoneEror : null,
            onChanged: (val) {
              setState(() {
                phone = val;
              });
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            maxLines: null,
            decoration: textFormInputDecoration(
              label: 'رسالتك',
              prefixIcon: Icons.message,
              suffixIcon: Icons.edit,
            ),
            validator: (val) => val.isEmpty ? 'برجاء ادخال رسالتك' : null,
            onChanged: (val) {
              setState(() {
                message = val;
              });
            },
          ),
        ],
      ),
    );
  }

  sentData({
    String userName,
    String email,
    String mobile,
    String message,
    // ignore: non_constant_identifier_names
    int user_id,
    List<File> files,
    String deviceToken,
  }) async {
    try {
      var data;
      if (files != null) {
        data = FormData.fromMap({
          'userName': userName,
          'email': email,
          'mobile': mobile,
          'message': message,
          'user_id': user_id.toString(),
          'DeviceToken': deviceToken,
          "files[]": [
            for (var items in files)
              {
                await MultipartFile.fromFile(
                  items.path,
                  filename: items.path.split('/').last,
                ),
              }.toList(),
          ]
        });
      } else {
        data = FormData.fromMap({
          'userName': userName,
          'email': email,
          'mobile': mobile,
          'message': message,
          'user_id': user_id.toString(),
          'DeviceToken': deviceToken,
          "files[]": [],
        });
      }

      // for (var items in files) {
      //   // data = {
      //   //   'userName': userName,
      //   //   'email': email,
      //   //   'mobile': mobile,
      //   //   'message': message,
      //   //   'user_id': user_id.toString(),
      //   //   'DeviceToken': deviceToken,
      //   //   "files[]": [
      //   //     MultipartFile.fromFileSync(
      //   //       items.path,
      //   //       filename: phootos,
      //   //     ),
      //   //   ]
      //   // };
      //   data = FormData.fromMap({
      //     'userName': userName,
      //     'email': email,
      //     'mobile': mobile,
      //     'message': message,
      //     'user_id': user_id.toString(),
      //     'DeviceToken': deviceToken,
      //     "files[]": [
      //       await MultipartFile.fromFile(
      //         items.path,
      //         filename: items.path.split('/').last,
      //       ),
      //     ]
      //   });
      // }
      print(data);

      // var body = {
      //   'userName': userName,
      //   'email': email,
      //   'mobile': mobile,
      //   'message': message,
      //   'user_id': user_id.toString(),
      //   'files[]': files,
      //   'DeviceToken': deviceToken,
      // };
      Dio dio = new Dio();
      Response response = await dio.post(Utils.ContactUs_URL, data: data);
      print(response.data.toString());
      // var response = await http.post(
      //   Utils.ContactUs_URL,
      //   body: jsonEncode(body),
      //   headers: {'Content-Type': 'application/json'},
      // );

      // Map<String, dynamic> map = json.decode(response.body);
      // print("body:$body");

      if (response.data['status'] == 'success') {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
            context: context, message: response.data['message'].toString());
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(
            context: context, message: response.data['errorArr'].toString());
      }

      // Navigator.pop(context);
    } catch (e) {
      print('Cash errrrrrrrrrrrrrrror');
      setState(() {
        loading = !loading;
      });

      print(e);
    }
  }

  firstSections() {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/ahmed.jpg'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'معلومات الإتصال',
          style: AppTheme.heading,
        ),
        SizedBox(height: 10),
        FutureBuilder(
          future: ContactUsApi.futchContactUs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return (snapshot.data == null)
                  ? Container()
                  : ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        contactInformation(
                          icon: FontAwesomeIcons.phone,
                          title: snapshot.data.phone,
                        ),
                        SizedBox(height: 10),
                        contactInformation(
                          icon: Icons.email,
                          title: snapshot.data.email,
                        ),
                      ],
                    );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  contactInformation({String title, IconData icon}) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10),
        Text(
          title,
          style: AppTheme.heading.copyWith(
            fontSize: 16,
            color: customColorGray,
          ),
        )
      ],
    );
  }
}
