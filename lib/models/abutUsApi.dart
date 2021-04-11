import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutUsModels {
  final String image;
  final String title;
  final String des;

  AboutUsModels({
    this.image,
    this.title,
    this.des,
  });
}

class AboutUsApi {
  static Future<AboutUsModels> futchAboutUs() async {
    AboutUsModels aboutUs;
    try {
      var response = await http.get(Utils.GeneralData_URL);
      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        aboutUs = AboutUsModels(
          title: jsonData['data']['AboutUs']['title'],
          image: jsonData['data']['AboutUs']['image'],
          des: jsonData['data']['AboutUs']['des'],
        );
      }
    } catch (e) {
      print('AboutUs Errrrrrrrrror');
      print(e);
    }
    return aboutUs;
  }
}
