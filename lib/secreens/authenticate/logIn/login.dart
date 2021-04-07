import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:almosawii/secreens/wrapper/wrapper.dart';
import 'package:almosawii/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:almosawii/models/userData.dart';

import '../passwordRecovery.dart';

class LogIn extends StatefulWidget {
  final Function toggleView;
  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool obscurePassword = true;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: (loading)
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                LogoContainar(
                  text: 'تسجيل دخول',
                ),
                SizedBox(height: 20),
                Text(
                  'مرحبا بك ',
                  style: AppTheme.heading.copyWith(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      primary: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                decoration: textFormInputDecoration(
                                  prefixIcon: Icons.person,
                                  label: 'اسم المستخدم',
                                ),
                                validator: (val) =>
                                    val.isEmpty ? emailEror : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                style: TextStyle(color: Colors.black),
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
                                validator: (val) =>
                                    val.isEmpty ? passwordEror : null,
                                obscureText: obscurePassword,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              Center(
                                child: Text(
                                  error,
                                  style: AppTheme.headingColorBlue,
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () async {
                                  MySharedPreferences.saveUserSkipLogIn(true);
                                  MySharedPreferences.saveUserSingIn(false);

                                  User.userLogIn =
                                      await MySharedPreferences.getUserSingIn();
                                  User.userSkipLogIn = await MySharedPreferences
                                      .getUserSkipLogIn();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => Wrapper(),
                                    ),
                                    (routes) => false,
                                  );
                                },
                                child: Text(
                                  "الدخول كزائر ؟",
                                  style: AppTheme.heading.copyWith(
                                    color: customColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              CustomButton(
                                onPress: () async {
                                  MySharedPreferences.saveUserSkipLogIn(false);
                                  MySharedPreferences.saveUserSingIn(true);
                                  User.userLogIn =
                                      await MySharedPreferences.getUserSingIn();
                                  User.userSkipLogIn = await MySharedPreferences
                                      .getUserSkipLogIn();
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (_) => Wrapper(),
                                    ),
                                    (routes) => false,
                                  );
                                },
                                text: 'دخول',
                              ),
                              SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PasswordRecovery(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'هل نسيت كلمه السر  ؟ ',
                                  style: AppTheme.heading,
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ليس لديك حساب ؟",
                                        style: AppTheme.subHeadingColorBlue
                                            .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => widget.toggleView(),
                                        child: Text(
                                          "إنشاء حساب",
                                          style: AppTheme.headingColorBlue
                                              .copyWith(
                                            fontWeight: FontWeight.w900,
                                            color: customColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
    );
  }
}
