

class Medicine {
  final String name;
  final String company;
  final String imagePath;
  final String discount;
  final double price;
  final double originalPrice;

  Medicine({
    required this.name,
    required this.company,
    required this.imagePath,
    required this.discount,
    required this.price,
    required this.originalPrice, required String id, required category,
  });
}
