//! EXAMPLE CARS
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

//TODO: add cars from backend
class MysqlCrud {
  static var _recipes;
  static Future<List> getCarsDetails() async {
    final response = await http.get(
      Uri.parse("http://192.168.43.99:8012/car_market/display_details.php"),
    );
    var body = response.body;

    _recipes = json.decode(response.body);

    return json.decode(response.body);
  }

  static Future<List> getCarsIcons() async {
    final response = await http.get(
      Uri.parse("http://192.168.43.99:8012/car_market/display_icons.php"),
    );
    //_recipes =json.decode(response.body);
    return json.decode(response.body);
  }

  static Future<List> fetchAds() async {
    var api = Uri.parse('http://192.168.43.99:8012/car_market/bannerApi.php');
    var response = await http.get(api);
    //print(response.body);
    // _recipes =json.decode(response.body);
    var bannerApi = jsonDecode(response.body);
    return bannerApi;
  }

  static Future<List> getNewCarsDetails() async {
    final response = await http.get(
      Uri.parse("http://192.168.43.99:8012/car_market/display_New_cars.php"),
    );
    //_recipes =json.decode(response.body);
    return json.decode(response.body);
  }

  static Future<List> getUsedCarsDetails() async {
    final response = await http.get(
      Uri.parse("http://192.168.43.99:8012/car_market/display_used_cars.php"),
    );
    return json.decode(response.body);
  }

  static Future addFavoriteCars(
      String id, String isFavorite, String tableName) async {
    var url = Uri.parse(
        'http://192.168.43.99:8012/car_market/add_favorite_cars.php'); //Inserting Api Calling
    var response = await http.post(url,
        body: {'id': id, 'IsFavorite': isFavorite, 'tableName': tableName});

    var data = json.decode(response.body);
    if (data == "Failed") {
      Fluttertoast.showToast(
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        msg: 'Failed Added',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        msg: 'Successful Added',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  static Future<List> getFavoriteCars() async {
    final response = await http.get(
      Uri.parse(
          "http://192.168.43.99:8012/car_market/display_favorite_cars.php"),
    );

    return json.decode(response.body);
  }
}

List<Map> cars = [
  for (var r in MysqlCrud._recipes)
    {
      'carName': r.carName,
      'carClass': r.carClass,
      'carPower': r.carPower,
      'people': r.people,
      'bags': r.bags,
      'carImage': r.carImage,
      'carPrice': r.carPrice,
      'isRotated': r.IsFavorite,
      'carRating': r.carRating,
    },
  /*{
      'carName': 'Hyundai i30 N 2021',
      'carClass': 'Sport',
      'carPower': 280,
      'people': '1-4',
      'bags': '1-3',
      'carImage': 'assets/images/i30n.png',
      'carPrice': 20,
      'isRotated': false,
      'carRating': '5.0',
    },
    {
      'carName': 'Volkswagen Golf EVO 2020',
      'carClass': 'Economy',
      'carPower': 150,
      'people': '1-5',
      'bags': '1-4',
      'carImage': 'assets/images/golf.png',
      'carPrice': 15,
      'isRotated': true,
      'carRating': '4.2',
    },
    {
      'carName': 'Toyota Yaris COMFORT 2020',
      'carClass': 'City',
      'carPower': 72,
      'people': '1-4',
      'bags': '1-2',
      'carImage': 'assets/images/yaris.png',
      'carPrice': 10,
      'isRotated': false,
      'carRating': '4.8',
    }*/
];
