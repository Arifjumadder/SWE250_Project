import 'package:flutter/material.dart';
import 'diaper_cart_page.dart';

class DiaperItem {
  final String name;
  final String company;
  final String imagePath;
  final String discount;
  final double price;
  final double originalPrice;

  DiaperItem({
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
      other is DiaperItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          company == other.company;

  @override
  int get hashCode => name.hashCode ^ company.hashCode;
}

class DiapersPage extends StatefulWidget {
  const DiapersPage({Key? key}) : super(key: key);

  @override
  State<DiapersPage> createState() => _DiapersPageState();
}

class _DiapersPageState extends State<DiapersPage> {
  List<DiaperItem> cartItems = [];

  final List<DiaperItem> items = [
    DiaperItem(
      name: "Bashundhara Baby Diaper Mini",
      company: "Bashundhara Paper Mills Ltd.",
      imagePath: "assets/images/diapermini.webp",
      discount: "10% OFF",
      price: 126.00,
      originalPrice: 140.00,
    ),
    DiaperItem(
      name: "Avonee Pant Style Diaper M 40s",
      company: "Unimax Industries Ltd",
      imagePath: "assets/images/avonee.webp",
      discount: "25% OFF",
      price: 667.50,
      originalPrice: 890.00,
    ),
    DiaperItem(
      name: "Avonee Pant Style Diaper S 42s",
      company: "Unimax Industries Ltd",
      imagePath: "assets/images/avono1.webp",
      discount: "25% OFF",
      price: 667.50,
      originalPrice: 890.00,
    ),
    DiaperItem(
      name: "SuperMom Baby Diaper M (6-11kg)",
      company: "Square Toiletries Ltd.",
      imagePath: "assets/images/supermom.webp",
      discount: "10% OFF",
      price: 144.00,
      originalPrice: 160.00,
    ),
  ];

  void addToCart(DiaperItem item) {
    setState(() {
      cartItems.add(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void goToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaperCartPage(cartItems: cartItems),
      ),
    ).then((value) {
      if (value == true) {
       
        setState(() {
          cartItems.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diapers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return DiaperItemCard(
              item: item,
              onAddToCart: () => addToCart(item),
            );
          },
        ),
      ),
      floatingActionButton: cartItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: goToCartPage,
              icon: const Icon(Icons.shopping_cart),
              label: Text(cartItems.length.toString()),
              backgroundColor: Colors.teal,
            )
          : null,
    );
  }
}

class DiaperItemCard extends StatefulWidget {
  final DiaperItem item;
  final VoidCallback onAddToCart;

  const DiaperItemCard({Key? key, required this.item, required this.onAddToCart})
      : super(key: key);

  @override
  State<DiaperItemCard> createState() => _DiaperItemCardState();
}

class _DiaperItemCardState extends State<DiaperItemCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedScale(
        scale: _isHovering ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Card(
          elevation: _isHovering ? 8 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: _isHovering
                ? const BorderSide(color: Colors.lightBlue, width: 2)
                : BorderSide.none,
          ),
          shadowColor: Colors.grey.withOpacity(_isHovering ? 0.5 : 0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.asset(
                        widget.item.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                                child: Icon(Icons.broken_image,
                                    size: 40, color: Colors.grey)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.item.discount,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widget.item.company,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '৳${widget.item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '৳${widget.item.originalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: widget.onAddToCart,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      _isHovering ? 0.5 : 0.3),
                                  blurRadius: _isHovering ? 8 : 5,
                                  spreadRadius: _isHovering ? 2 : 1,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.teal,
                              child: const Icon(Icons.add,
                                  color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
