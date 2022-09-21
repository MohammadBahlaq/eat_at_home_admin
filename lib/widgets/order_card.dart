import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.index,
    required this.orderId,
    required this.totalPrice,
    required this.date,
    required this.time,
    required this.status,
    required this.name,
    required this.mobile,
    required this.onClickDone,
    required this.onCadrClick,
  });

  final int index;
  final int orderId;
  final double totalPrice;
  final String date;
  final String time;
  final int status;
  final String name;
  final String mobile;
  final void Function() onClickDone;
  final void Function() onCadrClick;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return InkWell(
      onTap: onCadrClick,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: mq.size.height * 0.01,
          horizontal: mq.size.width * 0.032,
        ),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
            ),
          ],
          color: status == 1 ? Colors.white : Colors.grey,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ORDER ID #$orderId",
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${totalPrice.toStringAsFixed(2)} JD",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: mq.size.height * 0.03),
            Text(
              "Date: $date - $time \n",
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: mq.size.width * 0.4,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: mq.size.height * 0.03),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: onClickDone,
                    child: Text(
                      status == 1 ? "Done" : "Restore",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: mq.size.width * 0.03),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    label: const Text(
                      "Call Customer",
                      style: TextStyle(fontSize: 13),
                    ),
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      final uriPhone = Uri(
                        scheme: "tel",
                        path: mobile,
                      );
                      launchUrl(uriPhone);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
