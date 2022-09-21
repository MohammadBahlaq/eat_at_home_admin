import 'dart:convert';
import 'package:eat_at_home_restaurant/controller/data.dart';
import 'package:eat_at_home_restaurant/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderController with ChangeNotifier {
  List<Order> orders = [];
  List<Order> ordersDone = [];
  String status = "In Progresses";

  Future getOrders(int status) async {
    print("getOrders");
    print("length first method : ${orders.length}");
    orders.clear();
    ordersDone.clear();
    print("length after clear : ${orders.length}");
    String url = "${Data.apiPath}select_bills.php?status=$status";

    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    //notifyListeners();
    //return responsebody;

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
      print("length after loop : ${orders.length}");
      //removeDuplicate(orders);
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
      }
    }
    notifyListeners();
  }

  void removeDuplicate(List<Order> orders2) {
    Set<Order> ordersSet = {};
    ordersSet = orders2.toSet();
    orders2 = ordersSet.toList();

    // List<int> orders2 = [1, 1, 2, 2, 3, 4, 4];
    // print("orders2 D: $orders2");
    // Set<int> ordersSet = {};
    // ordersSet = orders2.toSet();
    // print("ordersSet D: $ordersSet");
    // orders2 = ordersSet.toList();
    // print("orders2 : $orders2");
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
}
