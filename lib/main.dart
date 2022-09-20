import 'package:eat_at_home_restaurant/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
