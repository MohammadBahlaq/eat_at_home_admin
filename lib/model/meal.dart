class Meal {
  int? id;
  String name;
  String category;
  String image;
  int count;
  double subPrice;
  int? billID;
  Meal({
    this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.count,
    required this.subPrice,
    this.billID,
  });
}
