import 'package:eat_at_home_restaurant/controller/order_controller.dart';
import 'package:eat_at_home_restaurant/view/order_detailes.dart';
import 'package:eat_at_home_restaurant/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBuilder extends StatelessWidget {
  const OrderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = context.read<OrderController>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.81824,
      child: Selector<OrderController, int>(
        selector: (p0, p1) => p1.orders.length,
        builder: (context, orderLength, child) {
          return orderLength == 0
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: orderLength,
                  itemBuilder: (context, i) {
                    return OrderCard(
                      index: i,
                      orderId: orderController.orders[i].id,
                      totalPrice: orderController.orders[i].totalPrice,
                      date: orderController.orders[i].date,
                      time: orderController.orders[i].time,
                      status: orderController.orders[i].status,
                      name: orderController.orders[i].name,
                      mobile: orderController.orders[i].mobile,
                      onClickDone: () {
                        orderController.converStatus(
                          orderController.orders[i].status == 1 ? 0 : 1,
                          orderController.orders[i],
                        );
                      },
                      onCadrClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderDetailes(
                              billID: orderController.orders[i].id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
