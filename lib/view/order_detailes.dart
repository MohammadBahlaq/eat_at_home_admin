import 'package:eat_at_home_restaurant/controller/data.dart';
import 'package:eat_at_home_restaurant/controller/meal_controller.dart';
import 'package:eat_at_home_restaurant/widgets/meal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailes extends StatelessWidget {
  const OrderDetailes({super.key, required this.billID});

  final int billID;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MealController(),
      builder: (context, child) {
        final MealController mealController = context.read<MealController>();

        mealController.getItems(billID);
        return Scaffold(
          appBar:
              AppBar(title: const Text("ORDER DETAILES"), centerTitle: true),
          body: Selector<MealController, int>(
            selector: (p0, p1) => p1.meals.length,
            builder: (context, mealsLength, child) {
              return ListView.builder(
                itemCount: mealsLength,
                itemBuilder: (context, i) {
                  return MealCard(
                    name: mealController.meals[i].name,
                    category: mealController.meals[i].category,
                    image: "${Data.imgPath}${mealController.meals[i].image}",
                    count: mealController.meals[i].count,
                    subPrice: mealController.meals[i].subPrice,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
