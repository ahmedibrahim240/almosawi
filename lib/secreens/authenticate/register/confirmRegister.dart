import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:code_fields/code_fields.dart';

class ConfirmPassword extends StatefulWidget {
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final _formKey = GlobalKey<FormState>();
  final int codeLength = 4;

  String validateCode(String code) {
    if (code.length < codeLength)
      return "من فضلك اكمل الكود";
    else {
      bool isNumeric = int.tryParse(code) != null;
      if (!isNumeric) return "برجاء ادخال الكود المرسل";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: ListView(
          primary: true,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "كود التفعيل",
                    style: AppTheme.heading.copyWith(
                      color: customColor,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "أدخل كود الذي تم إرسالة علي هذا االربيد" +
                          '\n text@text.com',
                      textAlign: TextAlign.center,
                      style: AppTheme.subHeading.copyWith(),
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: CodeFields(
                      length: codeLength,
                      validator: validateCode,
                      inputDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: customColorGray,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: customColor,
                          ),
                        ),
                      ),
                      textStyle: TextStyle(color: Colors.black),
                      autofocus: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Resend code ?",
                        style: AppTheme.headingColorBlue.copyWith(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      text: 'send',
                      onPress: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => Wrapper(),
                          ),
                          (routes) => false,
                        );
                      },
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
