import 'package:eat_at_home_restaurant/controller/order_controller.dart';
import 'package:eat_at_home_restaurant/view/order_detailes.dart';
import 'package:eat_at_home_restaurant/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDoneBuilder extends StatelessWidget {
  const OrderDoneBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = context.read<OrderController>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.81824,
      child: Selector<OrderController, int>(
        selector: (p0, p1) => p1.ordersDone.length,
        builder: (context, orderLength, child) {
          return orderLength == 0
              ? const Center(
                  child: Text(
                  "You don't have any Done bill",
                  style: TextStyle(fontSize: 18),
                ))
              : ListView.builder(
                  itemCount: orderLength,
                  itemBuilder: (context, i) {
                    return OrderCard(
                      index: i,
                      orderId: orderController.ordersDone[i].id,
                      totalPrice: orderController.ordersDone[i].totalPrice,
                      date: orderController.ordersDone[i].date,
                      time: orderController.ordersDone[i].time,
                      status: orderController.ordersDone[i].status,
                      name: orderController.ordersDone[i].name,
                      mobile: orderController.ordersDone[i].mobile,
                      onClickDone: () {
                        orderController.converStatus(
                          orderController.ordersDone[i].status == 1 ? 0 : 1,
                          orderController.ordersDone[i],
                        );
                      },
                      onCadrClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderDetailes(
                              billID: orderController.ordersDone[i].id,
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
