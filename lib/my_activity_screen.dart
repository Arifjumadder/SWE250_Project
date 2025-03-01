import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'my_orders_screen.dart';
import 'my_coupon_screen.dart';
import 'help_center_screen.dart';
import 'previous_history_screen.dart';

class MyActivityScreen extends StatelessWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        title: Text(
          'My Activity',
          style: TextStyle(
            color: Color(0xFF1A535C), 
          ),
        ),
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: ListView(
        children: [
          
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A535C), Color(0xFF4ECDC4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF1A535C)), 
                ),
                SizedBox(height: 10),
           
                SizedBox(height: 5),
          
              ],
            ),
          ),
          
          HoverActivityTile(
            icon: Icons.person,
            title: "My Profile",
            subtitle: "View and edit your profile",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.shopping_bag,
            title: "My Orders",
            subtitle: "View your order history",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.shopping_cart,
            title: "My Cart",
            subtitle: "View items in your cart",
            onTap: () {},
          ),
          HoverActivityTile(
            icon: Icons.card_giftcard,
            title: "My Coupon",
            subtitle: "View and add coupons",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCouponScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.help_outline,
            title: "Help Center",
            subtitle: "Get help and support",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpCenterScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.history,
            title: "Previous History",
            subtitle: "View your previous activity",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreviousHistoryScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class HoverActivityTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HoverActivityTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  _HoverActivityTileState createState() => _HoverActivityTileState();
}

class _HoverActivityTileState extends State<HoverActivityTile> {
  bool _isHovered = false; 

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true), 
      onExit: (_) => setState(() => _isHovered = false), 
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), 
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? Color(0xFF1A535C) : Colors.white, 
            borderRadius: BorderRadius.circular(12), 
            border: Border.all(
              color: _isHovered ? Color(0xFF1A535C) : Color(0xFFE3E6EB), 
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6, 
                offset: Offset(0, 2), 
              ),
            ],
          ),
          padding: EdgeInsets.all(8), 
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold,
                        color: _isHovered ? Colors.white : Color(0xFF1A535C), 
                      ),
                    ),
                    SizedBox(height: 2), 
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 12, 
                        color: _isHovered ? Colors.white.withOpacity(0.9) : Color(0xFF1A535C).withOpacity(0.8), 
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6), 
                child: Icon(
                  widget.icon,
                  size: 24, 
                  color: _isHovered ? Colors.white : Color(0xFF1A535C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}