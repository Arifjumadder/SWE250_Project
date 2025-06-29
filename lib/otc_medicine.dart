import 'package:flutter/material.dart';
import 'medicine.dart';
import 'medicine_card.dart';
import 'cart_page.dart';

class OtcMedicinePage extends StatefulWidget {
  const OtcMedicinePage({Key? key}) : super(key: key);

  @override
  State<OtcMedicinePage> createState() => _OtcMedicinePageState();
}

class _OtcMedicinePageState extends State<OtcMedicinePage> {
  List<Medicine> cartItems = [];

  final List<Medicine> medicines = [
    Medicine(name: "Sergel 20 mg", company: "Healthcare Pharmaceuticals Ltd.", imagePath: "assets/images/serr.webp", discount: "8% OFF", price: 6.44, originalPrice: 7.00, id: '', category: null),
    Medicine(name: "Napa 500 mg", company: "Beximco Pharmaceuticals Ltd.", imagePath: "assets/images/napa.webp", discount: "10% OFF", price: 10.80, originalPrice: 12.00, id: '', category: null),
    Medicine(name: "Ceevit 250 mg", company: "Square Pharmaceuticals PLC.", imagePath: "assets/images/cevit.webp", discount: "10% OFF", price: 17.10, originalPrice: 19.00, id: '', category: null),
    Medicine(name: "Monas 10 mg", company: "ACME Laboratories Ltd.", imagePath: "assets/images/monas.jpg", discount: "10% OFF", price: 236.25, originalPrice: 262.50, id: '', category: null),
    Medicine(name: "Pantonix 20 mg", company: "Incepta Pharmaceuticals Ltd.", imagePath: "assets/images/pantonix.webp", discount: "10% OFF", price: 88.20, originalPrice: 98.00, id: '', category: null),
    Medicine(name: "Fexo 120 mg", company: "Square Pharmaceuticals PLC.", imagePath: "assets/images/fexo.jpg", discount: "10% OFF", price: 81.00, originalPrice: 90.00, id: '', category: null),
  ];

  void addToCart(Medicine medicine) {
    setState(() {
      cartItems.add(medicine);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${medicine.name} added to cart'),
      duration: Duration(seconds: 1),
    ));
  }

  void goToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTC Medicine'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: medicines.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.70, 
          ),
          itemBuilder: (context, index) {
            return MedicineCard(
              medicine: medicines[index],
              onAddToCart: () => addToCart(medicines[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: goToCartPage,
        icon: const Icon(Icons.shopping_cart),
        label: Text(cartItems.length.toString()),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
