import 'package:almosawii/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecomendationsModels {
  final int id;
  final String name;
  final String status;
  final String ordered;
  var bigPrice;
  var smallPrice;
  var entryPrice;
  var outPrice;
  final String image;
  final String direction;
  final String forms;
  final String buy;
  final String selling;
  final String aimBuy;
  final String stopBuy;
  final String stopSelling;
  final String discount;
  final String createdAt;
  final String updatedAt;
  final String comment;
  final String type;
  final String statusLoss;

  RecomendationsModels({
    this.id,
    this.name,
    this.status,
    this.ordered,
    this.bigPrice,
    this.smallPrice,
    this.entryPrice,
    this.outPrice,
    this.image,
    this.direction,
    this.forms,
    this.buy,
    this.selling,
    this.aimBuy,
    this.stopBuy,
    this.stopSelling,
    this.discount,
    this.createdAt,
    this.updatedAt,
    this.comment,
    this.type,
    this.statusLoss,
  });
}

class RecomendationsApi {
  static Future<List<RecomendationsModels>> fetchAllRecomendations(
      {String type}) async {
    List<RecomendationsModels> listOfRecomendations = [];
    try {
      var response = await http.get(
        Utils.Recomendations_URL + "?type=$type",
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          RecomendationsModels recomendations = RecomendationsModels(
            id: items['id'],
            name: items['name'],
            status: items['status'],
            ordered: items['Ordered'],
            bigPrice: items['big_price'],
            smallPrice: items['small_price'],
            entryPrice: items['entry_price'],
            outPrice: items['out_price'],
            image: items['image'],
            direction: items['direction'],
            forms: items['forms'],
            buy: items['buy'],
            selling: items['selling'],
            aimBuy: items['aim_buy'],
            stopBuy: items['stop_buy'],
            stopSelling: items['stop_selling'],
            discount: items['Discount'],
            createdAt: items['created_at'],
            updatedAt: items['updated_at'],
            comment: items['comment'],
            type: items['type'],
            statusLoss: items['status_loss'],
          );
          listOfRecomendations.add(recomendations);
        }
      }
    } catch (e) {
      print('Erroro Recomendations');
      print(e);
    }
    return listOfRecomendations;
  }
}
