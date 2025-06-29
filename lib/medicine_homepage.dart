import 'package:firstapp/diabetic_care_page.dart';
import 'package:firstapp/otc_medicine.dart';
import 'package:flutter/material.dart';
import 'diapers_page.dart';
import 'women_choice_page.dart';


class MedicineHomePage extends StatelessWidget {
  const MedicineHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA8D8D8),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Medicine...',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.7)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.white, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.lightBlue.withOpacity(0.8), width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCategoryRow(context, 'OTC Medicine', 'Diabetic Care'),
                    buildCategoryRow(context, 'Diapers', "Women's Choice"),
                    buildCategoryRow(context, 'Baby Care', 'Personal Care'),
                    buildCategoryRow(context, 'Dental Care', 'Sexual Wellness'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryRow(BuildContext context, String label1, String label2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: CategoryButton(label: label1, onTap: () => navigateToPage(context, label1))),
          const SizedBox(width: 12),
          Expanded(child: CategoryButton(label: label2, onTap: () => navigateToPage(context, label2))),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, String label) {
    Widget? page;
    switch (label) {
      case 'OTC Medicine':
        page = const OtcMedicinePage(); 
        break;
      case 'Diabetic Care':
        page = DiabeticCarePage(onAddToCart: (Medicine ) {  },);
        break;
      case 'Diapers':
        page = DiapersPage();
        break;
      case "Women's Choice":
        page = WomenChoicePage();
        break;
      default:
        debugPrint('Navigation for "$label" not implemented yet.');
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page!), 
    );
    }
}

class CategoryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const CategoryButton({required this.label, this.onTap, Key? key}) : super(key: key);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 100,
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF6FA1A1) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? const Color(0xFF6FA1A1) : const Color(0xFFE3E6EB),
              width: _isHovered ? 3 : 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _isHovered ? Colors.white : const Color(0xFF4A4A4A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
