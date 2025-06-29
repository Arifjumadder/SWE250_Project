import 'package:flutter/material.dart';
import 'order_confirmation_page.dart';
import 'diapers_page.dart';

class DiaperCartPage extends StatefulWidget {
  final List<DiaperItem> cartItems;

  const DiaperCartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<DiaperCartPage> createState() => _DiaperCartPageState();
}

class _DiaperCartPageState extends State<DiaperCartPage> {
  late Map<DiaperItem, int> quantityMap;

  @override
  void initState() {
    super.initState();
    quantityMap = {};
    for (var item in widget.cartItems) {
      quantityMap[item] = (quantityMap[item] ?? 0) + 1;
    }
  }

  void increaseQty(DiaperItem item) {
    setState(() {
      quantityMap[item] = (quantityMap[item] ?? 0) + 1;
    });
  }

  void decreaseQty(DiaperItem item) {
    setState(() {
      if (quantityMap[item]! > 1) {
        quantityMap[item] = quantityMap[item]! - 1;
      } else {
        quantityMap.remove(item);
      }
    });
  }

  void removeItem(DiaperItem item) {
    setState(() {
      quantityMap.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = quantityMap.entries.fold(
      0,
      (sum, entry) => sum + (entry.key.price * entry.value),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF4F6F8),
      body: quantityMap.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
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
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '৳${item.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                _qtyButton(
                                  icon: Icons.remove,
                                  onTap: () => decreaseQty(item),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    qty.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                _qtyButton(
                                  icon: Icons.add,
                                  onTap: () => increaseQty(item),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => removeItem(item),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
      bottomNavigationBar: quantityMap.isNotEmpty
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, -2)),
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
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '৳${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (quantityMap.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderConfirmationPage(
                                totalAmount: total,
                                totalItems:
                                    quantityMap.values.fold(0, (a, b) => a + b),
                              ),
                            ),
                          ).then((value) {
                            Navigator.pop(context, true);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Your cart is empty!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
