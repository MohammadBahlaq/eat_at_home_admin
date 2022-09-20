import 'dart:convert';
import 'package:eat_at_home_restaurant/model/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'data.dart';

class MealController with ChangeNotifier {
  List<Meal> meals = [];

  Future<void> getItems(int billID) async {
    meals.clear();
    String url = "${Data.apiPath}select_items_bill.php?billid=$billID";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);

    for (var meal in responsebody) {
      meals.add(
        Meal(
          name: meal['name'],
          category: meal['category'],
          image: meal['photo'],
          count: meal['count'],
          subPrice: meal['sub_price'],
        ),
      );
    }
    notifyListeners();
  }
}
