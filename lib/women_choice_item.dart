class WomenChoiceItem {
  final String name;
  final String company;
  final String imagePath;
  final String discount;
  final double price;
  final double originalPrice;

  WomenChoiceItem({
    required this.name,
    required this.company,
    required this.imagePath,
    required this.discount,
    required this.price,
    required this.originalPrice,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WomenChoiceItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          company == other.company;

  @override
  int get hashCode => name.hashCode ^ company.hashCode;
}
