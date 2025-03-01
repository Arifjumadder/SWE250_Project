import 'package:flutter/material.dart';

class PreviousHistoryScreen extends StatelessWidget {
  const PreviousHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Previous History',
          style: TextStyle(
            color: Color(0xFF1A535C), 
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF1A535C)), 
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 70,
              color: Color(0xFF1A535C), 
            ),
            SizedBox(height: 20),
            Text(
              'No Previous History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A535C),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have no previous history to display.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6D6D6D), 
              ),
            ),
            SizedBox(height: 30),
            HoverButton(
              text: "Go Back",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class HoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverButton({super.key, required this.text, required this.onTap});

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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          color: _isHovered ? Color(0xFF4ECDC4) : Color(0xFF1A535C),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(2, 3,),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

