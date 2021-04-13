import 'package:almosawii/models/userData.dart';
import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMassege {
  final String date;
  final String content;
  final String title;
  var comments;

  MyMassege({this.date, this.content, this.title, this.comments});
}

class MyMessageApi {
  static Future<List<MyMassege>> fetchAllMyMassege() async {
    List<MyMassege> listOfMyMassege = [];
    try {
      var response = await http.get(
        Utils.MyMessages_URL + '/${User.userid}',
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          MyMassege myMassege = MyMassege(
            date: items['date'],
            content: items['content'],
            title: items['title'],
            comments: items['comments'],
          );
          listOfMyMassege.add(myMassege);
        }
      }
    } catch (e) {
      print('Erroro Coursesssssssssssssssss');
      print(e);
    }
    return listOfMyMassege;
  }
}
