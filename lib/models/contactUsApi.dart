import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContatUsModels {
  final String email;
  final String phone;
  final String whatsApp;

  ContatUsModels({
    this.email,
    this.phone,
    this.whatsApp,
  });
}

class ContactUsApi {
  static Future<ContatUsModels> futchContactUs() async {
    ContatUsModels aboutUs;
    try {
      var response = await http.get(Utils.GeneralData_URL);
      var jsonData = json.decode(response.body);
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        aboutUs = ContatUsModels(
          email: jsonData['data']['email'],
          phone: jsonData['data']['phone'],
          whatsApp: jsonData['data']['whatsApp'],
        );
      }
    } catch (e) {
      print('contatus Errrrrrrrrror');
      print(e);
    }
    return aboutUs;
  }
}
