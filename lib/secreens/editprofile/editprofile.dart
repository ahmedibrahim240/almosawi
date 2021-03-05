import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String phoneNamber;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل بياناتك'),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاسم',
                    style: AppTheme.heading.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userName,
                    decoration: textFormInpuofEidtProfile(icon: Icons.edit),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'رقم الهاتف ',
                    style: AppTheme.heading.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userPhoneNamber,
                    decoration: textFormInpuofEidtProfile(
                      icon: Icons.edit,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'البريد الابكتروني ',
                    style: AppTheme.heading.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: userDate.userEmail,
                    decoration: textFormInpuofEidtProfile(icon: Icons.edit),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'الرقم السري',
                    style: AppTheme.heading.copyWith(fontSize: 15),
                  ),
                  TextFormField(
                    initialValue: '********',
                    decoration: textFormInputDecorationForPassword(
                      Icons.visibility_off,
                      Icons.lock,
                      'كلمة المرور',
                      () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      obscurePassword,
                    ),
                    obscureText: obscurePassword,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      onPress: () {},
                      text: 'حفظ',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
