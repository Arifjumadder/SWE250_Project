import 'package:flutter/material.dart';

class MedicineHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA8D8D8), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for Medicine',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)), 
                prefixIcon: Icon(Icons.search, color: Colors.black.withOpacity(0.5)), 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white), 
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white), 
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.8)), 
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.8), 
              ),
            ),
            SizedBox(height: 60), 
            
            Row(
              children: [
                Expanded(child: CategoryButton(label: 'OTC Medicine')),
                SizedBox(width: 8),
                Expanded(child: CategoryButton(label: 'Diabetic Care')),
              ],
            ),
            SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(child: CategoryButton(label: 'Diapers')),
                SizedBox(width: 8),
                Expanded(child: CategoryButton(label: 'Baby Care')),
              ],
            ),
            SizedBox(height: 8),
           
            Row(
              children: [
                Expanded(child: CategoryButton(label: 'Women\'s Choice')),
                SizedBox(width: 8),
                Expanded(child: CategoryButton(label: 'Sexual Wellness')),
              ],
            ),
            SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(child: CategoryButton(label: 'Dental Care')),
                SizedBox(width: 8),
                Expanded(child: CategoryButton(label: 'Personal Care')),
              ],
            ),
            SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(child: CategoryButton(label: 'Supplement')),
                SizedBox(width: 8),
                Expanded(child: CategoryButton(label: 'Devices')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String label;

  CategoryButton({required this.label});

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
      child: InkWell(
        onTap: () {
          
          print('${widget.label} tapped');
        },
        child: Container(
          height: 90, 
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? Color(0xFF6FA1A1) : Colors.white, 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered ? Color(0xFF6FA1A1) : Color(0xFFE3E6EB), 
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: _isHovered ? Colors.white : Color(0xFF4A4A4A), 
                fontWeight: FontWeight.bold,
                fontSize: 20, 
              ),
            ),
          ),
        ),
      ),
    );
  }
}