import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomheVideoModels {
  final String homeVideo;
  final String homeVideoTitle;
  final String homeVideoTxt1;
  final String homeVideoTxt2;
  final String homeVideoTxt3;
  var homeNumbers;

  HomheVideoModels({
    this.homeVideo,
    this.homeVideoTitle,
    this.homeVideoTxt1,
    this.homeVideoTxt2,
    this.homeVideoTxt3,
    this.homeNumbers,
  });
}

class HomeVideoApi {
  static Future<HomheVideoModels> futchHomeVideo() async {
    HomheVideoModels aboutUs;
    try {
      var response = await http.get(Utils.GeneralData_URL);
      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        aboutUs = HomheVideoModels(
          homeVideo: jsonData['data']['HomeVideo'],
          homeVideoTitle: jsonData['data']['HomeVideoTitle'],
          homeVideoTxt1: jsonData['data']['HomeVideoTxt1'],
          homeVideoTxt2: jsonData['data']['HomeVideoTxt2'],
          homeVideoTxt3: jsonData['data']['HomeVideoTxt3'],
          homeNumbers: jsonData['data']['homeNumbers'],
        );
      }
    } catch (e) {
      print('contatus Errrrrrrrrror');
      print(e);
    }
    return aboutUs;
  }
}
