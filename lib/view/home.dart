import 'package:eat_at_home_restaurant/controller/order_controller.dart';
import 'package:eat_at_home_restaurant/widgets/order_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/order_done_builder.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    print("Build page");
    final OrderController orderController = context.read<OrderController>();
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ORDERS"),
        centerTitle: true,
      ),
      body: Selector<OrderController, String>(
        selector: (p0, p1) => p1.status,
        builder: (context, status, child) {
          //orderController.getOrders(orderController.status == "In Progresses" ? 1 : 0);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: mq.size.height * 0.013,
                  right: mq.size.width * 0.03,
                  left: mq.size.width * 0.03,
                ),
                child: DropdownButton(
                  isExpanded: true,
                  value: status,
                  items: ["In Progresses", "Done"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    orderController.setStatus(value!);
                  },
                ),
              ),
              orderController.status == "In Progresses"
                  ? const OrderBuilder()
                  : const OrderDoneBuilder(),
            ],
          );
        },
      ),
    );
  }
}
