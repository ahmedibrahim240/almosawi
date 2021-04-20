import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/contactUsApi.dart';
import 'package:almosawii/models/userData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                    onPress: () {},
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
    var files,
    String deviceToken,
  }) async {
    try {
      var body = {
        'userName': userName,
        'email': email,
        'mobile': mobile,
        'message': message,
        'user_id': user_id.toString(),
        'files[]': files,
        'DeviceToken': deviceToken,
      };
      var response = await http.post(
        Utils.ContactUs_URL,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      Map<String, dynamic> map = json.decode(response.body);
      print("map:$map");

      if (map['status'] == 'success') {
        setState(() {
          loading = !loading;
        });
        showMyDialog(context: context, message: map['message'].toString());
      } else {
        setState(() {
          loading = !loading;
        });
        showMyDialog(context: context, message: map['errorArr'].toString());
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
