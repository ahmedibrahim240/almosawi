import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProChartVIPModels {
  final String title;
  final String image;
  final String des;
  final String homeAdImage;
  final String contactUsBanner;

  ProChartVIPModels({
    this.homeAdImage,
    this.title,
    this.image,
    this.des,
    this.contactUsBanner,
  });
}

class ProChartVIPModelsApi {
  static Future<ProChartVIPModels> futchAboutUs() async {
    ProChartVIPModels aboutUs;
    try {
      var response = await http.get(Utils.GeneralData_URL);
      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        aboutUs = ProChartVIPModels(
          title: jsonData['data']['ProChartVIP']['title'],
          image: jsonData['data']['ProChartVIP']['image'],
          des: jsonData['data']['ProChartVIP']['des'],
          homeAdImage: jsonData['data']['HomeAdImage'],
          contactUsBanner: jsonData['data']['contactUsBanner'],
        );
      }
    } catch (e) {
      print('AboutUs ProChartVIPModels');
      print(e);
    }
    return aboutUs;
  }
}
