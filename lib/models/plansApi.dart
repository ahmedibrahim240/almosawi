import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Plans {
  final int id;
  final String name;

  // ignore: non_constant_identifier_names
  final String plan_time;

  var features;

  final double oldPrice;
  final double newPrice;

  Plans({
    this.id,
    this.features,
    this.name,
    // ignore: non_constant_identifier_names
    this.plan_time,
    this.oldPrice,
    this.newPrice,
  });
}

class PlansApi {
  static Future<List<Plans>> fetchAllPlans() async {
    List<Plans> listOfCourses = [];
    try {
      var response = await http.get(
        Utils.Plans_URL,
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          Plans plans = Plans(
            id: items['id'],
            name: items['name'],
            plan_time: items['plan_time'],
            features: items['Features'],
            oldPrice: double.parse(items['price_old']),
            newPrice: double.parse(items['price_new']),
          );
          listOfCourses.add(plans);
        }
      }
    } catch (e) {
      print('Erroro Coursesssssssssssssssss');
      print(e);
    }
    return listOfCourses;
  }
}
