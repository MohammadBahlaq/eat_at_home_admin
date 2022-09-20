class Order {
  int id;
  String date;
  String time;
  int status;
  double totalPrice;
  int userId;
  String name;
  String mobile;

  Order({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.totalPrice,
    required this.userId,
    required this.name,
    required this.mobile,
  });
}
