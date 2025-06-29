import 'package:flutter/material.dart';


class CartItem {
  final String name;
  final double price;
  final int quantity;
  final String imagePath; 

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  double get subtotal => price * quantity;
}

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {

  final List<CartItem> _cartItems = [
    CartItem(
      name: "Joya Ultra Comfort Wings 8 Pads",
      price: 95.00,
      quantity: 2,
      imagePath: "assets/images/joya.webp", 
    ),
    CartItem(
      name: "Whisper Ultra Comfort XL 15 Pads",
      price: 346.75,
      quantity: 1,
      imagePath: "assets/images/wishper.webp", 
    ),
    CartItem(
      name: "Freedom Belt System 8 Pads",
      price: 57.00,
      quantity: 3,
      imagePath: "assets/images/freedom.webp", 
    ),
  ];

  void _increaseQuantity(int index) {
    setState(() {
      _cartItems[index] = CartItem(
        name: _cartItems[index].name,
        price: _cartItems[index].price,
        quantity: _cartItems[index].quantity + 1,
        imagePath: _cartItems[index].imagePath,
      );
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index] = CartItem(
          name: _cartItems[index].name,
          price: _cartItems[index].price,
          quantity: _cartItems[index].quantity - 1,
          imagePath: _cartItems[index].imagePath,
        );
      } else {
        _cartItems.removeAt(index); 
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart!'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  double get _totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1A535C)),
      ),
      backgroundColor: const Color(0xFFE0F2F1), 
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start adding some amazing products.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return CartItemCard(
                        item: item,
                        onIncrease: () => _increaseQuantity(index),
                        onDecrease: () => _decreaseQuantity(index),
                        onRemove: () => _removeItem(index),
                      );
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A535C),
                ),
              ),
              Text(
                '৳${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF4ECDC4), 
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
               
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Proceeding to checkout for ৳${_totalPrice.toStringAsFixed(2)}'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: const Color(0xFF1A535C),
                  ),
                );
               
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 24),
              label: const Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF1A535C), 
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                shadowColor: const Color(0xFF1A535C).withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatefulWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.blue.shade200.withOpacity(0.6)
                  : Colors.grey.shade300,
              blurRadius: _isHovered ? 12 : 8,
              offset: _isHovered ? const Offset(0, 6) : const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: _isHovered ? const Color(0xFF4ECDC4) : Colors.transparent, 
            width: _isHovered ? 2 : 0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.item.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1A535C),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '৳${widget.item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4ECDC4).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.5)),
                        ),
                        child: Text(
                          'Total: ৳${widget.item.subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A535C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                _quantityButton(
                  icon: Icons.add,
                  onTap: widget.onIncrease,
                  color: const Color(0xFF4ECDC4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.item.quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A535C),
                    ),
                  ),
                ),
                _quantityButton(
                  icon: Icons.remove,
                  onTap: widget.onDecrease,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: widget.onRemove,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade400,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(color: color.withOpacity(0.7), width: 1),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}