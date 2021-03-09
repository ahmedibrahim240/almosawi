import 'package:almosawii/constants/constans.dart';
import 'package:almosawii/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          contactInformation(
            icon: FontAwesomeIcons.phone,
            title: '+96597330286',
          ),
          SizedBox(height: 10),
          contactInformation(
            icon: Icons.email,
            title: 'info@ahmedalmosawi.com',
          ),
          SizedBox(height: 20),
          Text(
            'لديك سؤال عن الفوركس أو تريد أن تسأل عن تحليل أو تريد المشاركة معنا؟',
            style: AppTheme.heading.copyWith(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'الاسم',
                    prefixIcon: Icons.person,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: textFormInputDecoration(
                    label: 'البريد الإلكتروني',
                    prefixIcon: Icons.email,
                    suffixIcon: Icons.edit,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  decoration: textFormInputDecoration(
                    label: 'رسالتك',
                    prefixIcon: Icons.message,
                    suffixIcon: Icons.edit,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          CustomButton(
            onPress: () {},
            text: 'ارسال',
          ),
        ],
      ),
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
