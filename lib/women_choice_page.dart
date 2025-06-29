import 'package:flutter/material.dart';
import 'women_choice_item.dart';
import 'womens_cart.dart';

class WomenChoicePage extends StatefulWidget {
  const WomenChoicePage({Key? key}) : super(key: key);

  @override
  State<WomenChoicePage> createState() => _WomenChoicePageState();
}

class _WomenChoicePageState extends State<WomenChoicePage> {
  Map<WomenChoiceItem, int> cartItems = {};

  final List<WomenChoiceItem> items = [
    WomenChoiceItem(
      name: "Joya Ultra Comfort Wings 8 Pa...",
      company: "SMC Enterprise Limited",
      imagePath: "assets/images/joya.webp",
      discount: "5% OFF",
      price: 95.00,
      originalPrice: 100.00,
    ),
    WomenChoiceItem(
      name: "Whisper Ultra Comfort XL 15 Pa...",
      company: "Sun Pharmaceutical Ltd.",
      imagePath: "assets/images/wishper.webp",
      discount: "5% OFF",
      price: 346.75,
      originalPrice: 365.00,
    ),
    WomenChoiceItem(
      name: "Freedom Belt System 8 Pads",
      company: "ACI Consumer Brands",
      imagePath: "assets/images/freedom.webp",
      discount: "5% OFF",
      price: 57.00,
      originalPrice: 60.00,
    ),
    WomenChoiceItem(
      name: "Joya Extra Heavy Flow Wings 8...",
      company: "SMC Enterprise Limited",
      imagePath: "assets/images/heavy.webp",
      discount: "5% OFF",
      price: 104.50,
      originalPrice: 110.00,
    ),
  ];

  void addToCart(WomenChoiceItem item) {
    setState(() {
      cartItems.update(item, (value) => value + 1, ifAbsent: () => 1);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${item.name} added to cart'),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.teal,
    ));
  }

  void goToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WomensCartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Women's Choice",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
   
      ),
      body: Stack( 
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return WomenChoiceItemCard(
                  item: item,
                  onAddToCart: () => addToCart(item),
                );
              },
            ),
          ),
          Positioned(
            bottom: 16, 
            right: 16, 
            child: FloatingActionButton(
              onPressed: goToCartPage,
              backgroundColor: Colors.teal, 
              child: Stack(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                  if (cartItems.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                        child: Text(
                          cartItems.values.fold(0, (sum, qty) => sum + qty).toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class WomenChoiceItemCard extends StatefulWidget {
  final WomenChoiceItem item;
  final VoidCallback onAddToCart;

  const WomenChoiceItemCard({Key? key, required this.item, required this.onAddToCart})
      : super(key: key);

  @override
  _WomenChoiceItemCardState createState() => _WomenChoiceItemCardState();
}

class _WomenChoiceItemCardState extends State<WomenChoiceItemCard> {
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.asset(
                        widget.item.imagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        ),
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
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                        Text(
                          '৳${widget.item.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                              fontSize: 14),
                        ),
                        Text(
                          '৳${widget.item.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: widget.onAddToCart,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(_isHovering ? 0.5 : 0.3),
                                blurRadius: _isHovering ? 8 : 5,
                                spreadRadius: _isHovering ? 2 : 1,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.teal,
                            child: const Icon(Icons.add, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
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