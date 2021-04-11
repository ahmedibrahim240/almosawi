import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VisitorHomeIcons {
  var visitorHomeIcons;
  var userHomeIconsRow1;
  var userHomeIconsRow2;
  VisitorHomeIcons({
    this.userHomeIconsRow1,
    this.userHomeIconsRow2,
    this.visitorHomeIcons,
  });
}

class VisitorHomeIconsApi {
  static Future<VisitorHomeIcons> futchVisitorHomeIcons() async {
    VisitorHomeIcons aboutUs;
    try {
      var response = await http.get(Utils.GeneralData_URL);
      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');

      if (response.statusCode == 200) {
        aboutUs = VisitorHomeIcons(
          visitorHomeIcons: jsonData['data']['VisitorHomeIcons'],
          userHomeIconsRow1: jsonData['data']['UserHomeIconsRow1'],
          userHomeIconsRow2: jsonData['data']['UserHomeIconsRow2'],
        );
      }
    } catch (e) {
      print('contatus Errrrrrrrrror');
      print(e);
    }
    return aboutUs;
  }
}
