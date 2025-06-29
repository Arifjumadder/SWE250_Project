import 'package:flutter/material.dart';
import 'women_choice_item.dart'; 
import 'order_confirmation_page.dart'; 

class WomensCartPage extends StatefulWidget {
  final Map<WomenChoiceItem, int> cartItems;

  const WomensCartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _WomensCartPageState createState() => _WomensCartPageState();
}

class _WomensCartPageState extends State<WomensCartPage> {
  late Map<WomenChoiceItem, int> quantityMap;

  @override
  void initState() {
    super.initState();
    quantityMap = Map.from(widget.cartItems);
  }

  void increaseQty(WomenChoiceItem item) {
    setState(() {
      quantityMap.update(item, (value) => value + 1);
    });
  }

  void decreaseQty(WomenChoiceItem item) {
    setState(() {
      if (quantityMap[item]! > 1) {
        quantityMap.update(item, (value) => value - 1);
      } else {
        quantityMap.remove(item);
      }
    });
  }

  void removeItem(WomenChoiceItem item) {
    setState(() {
      quantityMap.remove(item);
    });
  }

  double get totalPrice => quantityMap.entries.fold(
      0, (sum, entry) => sum + (entry.key.price * entry.value));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFFE0F2F1),
      body: quantityMap.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: quantityMap.entries.map((entry) {
                final item = entry.key;
                final qty = entry.value;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item.imagePath,
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.company,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '৳${item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          _qtyButton(
                              icon: Icons.add,
                              onTap: () => increaseQty(item),
                              color: Colors.green),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              qty.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _qtyButton(
                              icon: Icons.remove,
                              onTap: () => decreaseQty(item),
                              color: Colors.redAccent),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red, size: 28),
                        onPressed: () => removeItem(item),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: quantityMap.isNotEmpty
          ? Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, -3)),
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(fontSize: 18, color: Color(0xFF1A535C)),
                      ),
                      Text(
                        '৳${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.payment, size: 28),
                      label: const Text(
                        'Place Order',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationPage(
                              totalAmount: totalPrice,
                              totalItems: quantityMap.values.fold(0, (a, b) => a + b),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF1A535C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _qtyButton(
      {required IconData icon, required VoidCallback onTap, required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.1),
          border: Border.all(color: color.withOpacity(0.5), width: 1.5),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}