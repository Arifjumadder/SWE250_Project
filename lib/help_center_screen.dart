import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        
        title: Text(
          'Help Center',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF1A535C)), 
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A535C), 
              ),
            ),
            SizedBox(height: 15),
            Text(
              'We are here to help you. Choose a method to contact us:',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6D6D6D), 
              ),
            ),
            SizedBox(height: 20),
            HoverListTile(
              icon: Icons.call,
              title: "Call Support",
              onTap: () {
                print('Call Support clicked');
              },
            ),
            SizedBox(height: 10),
            HoverListTile(
              icon: Icons.message,
              title: "WhatsApp Support",
              onTap: () {
                print('WhatsApp clicked');
              },
            ),
          ],
        ),
      ),
    );
  }
}


class HoverListTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const HoverListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  _HoverListTileState createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered ? Color(0xFFB2DFDB) : Colors.white, 
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(widget.icon, color: Color(0xFF1A535C)),
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1A535C),
            ),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
