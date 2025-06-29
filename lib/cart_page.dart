import 'package:flutter/material.dart';
import 'medicine.dart';
import 'order_confirmation_page.dart';

class CartPage extends StatefulWidget {
  final List<Medicine> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Map<Medicine, int> quantityMap;

  @override
  void initState() {
    super.initState();
    quantityMap = {};
    for (var item in widget.cartItems) {
      quantityMap[item] = (quantityMap[item] ?? 0) + 1;
    }
  }

  void increaseQty(Medicine med) {
    setState(() {
      quantityMap[med] = (quantityMap[med] ?? 0) + 1;
    });
  }

  void decreaseQty(Medicine med) {
    setState(() {
      if (quantityMap[med]! > 1) {
        quantityMap[med] = quantityMap[med]! - 1;
      } else {
        quantityMap.remove(med);
      }
    });
  }

  void removeItem(Medicine med) {
    setState(() {
      quantityMap.remove(med);
    });
  }

  @override
  Widget build(BuildContext context) {
    double total = quantityMap.entries.fold(
        0, (sum, entry) => sum + (entry.key.price * entry.value));

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
              padding: EdgeInsets.all(12),
              children: quantityMap.entries.map((entry) {
                final medicine = entry.key;
                final qty = entry.value;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          medicine.imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medicine.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '৳${medicine.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                _qtyButton(
                                  icon: Icons.remove,
                                  onTap: () => decreaseQty(medicine),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    qty.toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                _qtyButton(
                                  icon: Icons.add,
                                  onTap: () => increaseQty(medicine),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => removeItem(medicine),
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
                      offset: Offset(0, -2)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '৳${total.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderConfirmationPage(
                              totalAmount: total,
                              totalItems:
                                  quantityMap.values.fold(0, (a, b) => a + b),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Place Order',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
