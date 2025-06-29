

import 'package:firstapp/medicine_card.dart';
import 'package:flutter/material.dart';
import 'cart_page.dart'; 
import 'medicine.dart';

enum MedicineCategory { diabetic }

class DiabeticCarePage extends StatefulWidget {
  const DiabeticCarePage({Key? key, required Null Function(dynamic Medicine) onAddToCart}) : super(key: key);

  @override
  State<DiabeticCarePage> createState() => _DiabeticCarePageState();
}

class _DiabeticCarePageState extends State<DiabeticCarePage> {
  final List<Medicine> cartItems = [];

  final List<Medicine> diabeticItems = [
    Medicine(
      id: 'dia1',
      name: "NovoFine Needle 3 ml",
      company: "Technokit Healthcare Ltd",
      price: 11.25,
      originalPrice: 12.50,
      discount: "10% OFF",
      imagePath: "assets/images/navee.webp",
      category: MedicineCategory.diabetic,
    ),
    Medicine(
      id: 'dia2',
      name: "Insulin Syringe (Korean)100IU",
      company: "Technokit Healthcare Ltd",
      price: 10.80,
      originalPrice: 12.00,
      discount: "10% OFF",
      imagePath: "assets/images/insuline.webp",
      category: MedicineCategory.diabetic,
    ),
    Medicine(
      id: 'dia3',
      name: "DispoVan Syringe 100IU",
      company: "Technokit Healthcare Ltd",
      price: 9.00,
      originalPrice: 10.00,
      discount: "10% OFF",
      imagePath: "assets/images/dispo.webp",
      category: MedicineCategory.diabetic,
    ),
    Medicine(
      id: 'dia4',
      name: "GlucoLeader Test Strips",
      company: "Vivacheck Biotech Inc. Ltd",
      price: 452.76,
      originalPrice: 462.00,
      discount: "2% OFF",
      imagePath: "assets/images/gluco.webp",
      category: MedicineCategory.diabetic,
    ),
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
        title: const Text('Diabetic Care'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: diabeticItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final medicine = diabeticItems[index];
            return MedicineCard(
              medicine: medicine,
              onAddToCart: () => addToCart(medicine),
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
