import 'package:almosawii/models/userData.dart';
import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMassege {
  final int id;
  final String date;
  final String content;
  final String status;
  final String title;
  final String name;
  var comments;

  MyMassege({
    this.date,
    this.content,
    this.status,
    this.title,
    this.comments,
    this.id,
    this.name,
  });
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
            id: items['messageID'],
            content: items['content'],
            title: items['title'],
            name: items['name'],
            status: items['status'],
            comments: items['comments'],
          );
          listOfMyMassege.add(myMassege);
        }
      }
    } catch (e) {
      print('Erroro MYMessage');
      print(e);
    }
    return listOfMyMassege;
  }
}
