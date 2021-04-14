import 'package:http/http.dart' as http;
import 'dart:convert';

class TheBolg {
  var id;
  var name;
  final String contant;
  var date;
  var image;

  TheBolg({
    this.name,
    this.contant,
    this.date,
    this.image,
    this.id,
  });
}

List<TheBolg> blogList = [];

class TheBolgApi {
  static Future<List<TheBolg>> fetchAllTheBolg() async {
    List<TheBolg> listOfTheBolg = [];
    try {
      var response = await http.get(
        'https://ahmadalmosawi.com/wp-json/wp/v2/posts',
      );
      var jsonData = json.decode(response.body);
      print("jsonData:$jsonData");
      if (response.statusCode == 200) {
        for (var items in jsonData) {
          print("items:$items");
          TheBolg theBolg = TheBolg(
            id: items['id'],
            image: items['x_featured_media'],
            date: items['date'],
            contant: items['content']['rendered'],
            name: items['title']['rendered'],
          );
          listOfTheBolg.add(theBolg);
        }
      }
    } catch (e) {
      print('Erroro TheBolggggggggggggggg');
      print(e);
    }
    return listOfTheBolg;
  }
}
