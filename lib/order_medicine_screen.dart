import 'package:flutter/material.dart';
import 'medicine_homepage.dart'; 
import 'my_activity_screen.dart'; 

class OrderMedicineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black), 
          onPressed: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyActivityScreen()),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Column(
        children: [
          
          Container(
            height: 250, 
            width: double.infinity, 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://as1.ftcdn.net/v2/jpg/05/27/21/02/1000_F_527210234_QKG77DVk3OdWmr8xIfvW1Bl8Za3aMbfx.jpg',
                ),
                fit: BoxFit.cover, 
              ),
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        colors: [Color(0xFF1A535C), Color(0xFF4ECDC4)], 
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 36, 
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 139, 144, 35), 
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "We are here to help you for efficient way to Order your Product and as soon as fastest Delivery.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 104, 119, 34).withOpacity(0.8), 
                    ),
                  ),
                  SizedBox(height: 48),
                  HoverButton(), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class HoverButton extends StatefulWidget {
  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false; 

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true), 
      onExit: (_) => setState(() => _isHovered = false), 
      child: GestureDetector(
        onTap: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicineHomePage()),
          );
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), 
          decoration: BoxDecoration(
            color: _isHovered ? Color(0xFF1A535C) : Colors.white,
            borderRadius: BorderRadius.circular(24), 
            border: Border.all(
              color: _isHovered ? Color(0xFF1A535C) : Color(0xFFE3E6EB), 
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), 
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          padding: EdgeInsets.all(20), 
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Your Medicine",
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: _isHovered ? Colors.white : Color(0xFF1A535C),
                      ),
                    ),
                    SizedBox(height: 8), 
                    Text(
                      "Quick order, fastest Delivery.",
                      style: TextStyle(
                        fontSize: 16, 
                        color: _isHovered ? Colors.white.withOpacity(0.9) : Color(0xFF1A535C).withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12), 
                child: Image.network(
                  'https://images.pexels.com/photos/139398/thermometer-headache-pain-pills-139398.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.medication, size: 80, color: Colors.grey);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}