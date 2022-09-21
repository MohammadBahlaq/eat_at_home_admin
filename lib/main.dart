import 'package:eat_at_home_restaurant/controller/order_controller.dart';
import 'package:eat_at_home_restaurant/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderController()),
      ],
      builder: (context, child) {
        print("main Build");
        final OrderController orderController = context.read<OrderController>();
        orderController
            .getOrders(orderController.status == "In Progresses" ? 1 : 0);
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      home: const Home(),
      routes: {
        "home": (context) => const Home(),
        //"detailes": (context) => const OrderDetailes(),
      },
    );
  }
}
