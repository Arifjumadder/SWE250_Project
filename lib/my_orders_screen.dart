import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
       
        title: Text(
          'My Orders',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF1A535C)), 
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Center(
        child: Text(
          'You have no orders',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF6D6D6D), 
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
