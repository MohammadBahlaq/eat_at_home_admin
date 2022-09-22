import 'dart:convert';
import 'package:eat_at_home_restaurant/controller/data.dart';
import 'package:eat_at_home_restaurant/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderController with ChangeNotifier {
  List<Order> orders = [];
  List<Order> ordersDone = [];
  String status = "In Progresses";
  int loading = 0;

  Future getOrders(int status) async {
    orders.clear();
    ordersDone.clear();

    DateTime date = DateTime.now();

    String url = "${Data.apiPath}select_bills.php?status=$status"
        "&today=${date.day}/${date.month}/${date.year}&"
        "yestarday=${date.day - 1}/${date.month}/${date.year}";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);

    if (status == 1) {
      for (var order in responsebody) {
        orders.add(
          Order(
            id: order['id'],
            date: order['Date'],
            time: order['Time'],
            status: order['Status'],
            totalPrice: order['total_price'].toDouble(),
            userId: order['user_id'],
            name: order['name'],
            mobile: order['mobile'],
          ),
        );
      }
      setLoading(1);
    } else {
      for (var order in responsebody) {
        ordersDone.add(
          Order(
            id: order['id'],
            date: order['Date'],
            time: order['Time'],
            status: order['Status'],
            totalPrice: order['total_price'].toDouble(),
            userId: order['user_id'],
            name: order['name'],
            mobile: order['mobile'],
          ),
        );
        setLoading(1);
      }
    }

    notifyListeners();
  }

  Future<void> converStatus(int status, Order order) async {
    String url = "${Data.apiPath}update_status.php";

    var response = await http.post(
      Uri.parse(url),
      body: {
        "status": "$status",
        "billid": "${order.id}",
      },
    );

    if (int.parse(response.body) == 1 && status == 0) {
      orders.remove(order);
      ordersDone.add(order);
      notifyListeners();
    } else {
      ordersDone.remove(order);
      orders.add(order);
      notifyListeners();
    }
  }

  Future<void> setStatus(String value) async {
    status = value;
    await getOrders(status == "In Progresses" ? 1 : 0);
  }

  void setLoading(int loading) {
    this.loading = loading;
    notifyListeners();
  }
}
