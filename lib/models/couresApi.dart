import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Courses {
  final int id;
  final String name;
  final String status;
  // ignore: non_constant_identifier_names
  final String video_code;
  final String description;
  final String image;
  final String badge;
  var lessons;
  final double totalRating;
  final double oldPrice;
  final double newPrice;

  Courses({
    this.id,
    this.image,
    this.lessons,
    this.badge,
    this.name,
    this.status,
    // ignore: non_constant_identifier_names
    this.video_code,
    this.description,
    this.totalRating,
    this.oldPrice,
    this.newPrice,
  });
}

class CoursesApi {
  static Future<List<Courses>> fetchAllCourses() async {
    List<Courses> listOfCourses = [];
    try {
      var response = await http.get(
        Utils.Courses_URL,
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Courses courses = Courses(
            id: items['id'],
            image: items['image'],
            name: items['name'],
            description: items['description'],
            video_code: items['video_code'],
            status: items['status'],
            lessons: items['lessons'],
            totalRating: double.parse(items['TotalRating'].toString()),
            oldPrice: double.parse(items['price_old']),
            newPrice: double.parse(items['price_new']),
          );
          listOfCourses.add(courses);
        }
      }
    } catch (e) {
      print('Erroro Coursesssssssssssssssss');
      print(e);
    }
    return listOfCourses;
  }
}
