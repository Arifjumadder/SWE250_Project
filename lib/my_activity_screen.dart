import 'package:flutter/material.dart';


import 'profile_screen.dart';
import 'my_orders_screen.dart';
import 'my_coupon_screen.dart';
import 'help_center_screen.dart';
import 'previous_history_screen.dart';
import 'my_cart_screen.dart'; 

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({super.key});

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen> {
  
  String _userName = 'Arif'; 

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2, 
        title: const Text(
          'My Activity',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5, 
          ),
        ),
        centerTitle: true, 
        iconTheme: const IconThemeData(color: Color(0xFF1A535C)), 
      ),
      backgroundColor: const Color(0xFFE0F2F1), 
      body: ListView(
        children: [
        
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0), 
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1A535C), Color(0xFF4ECDC4)], 
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CircleAvatar( 
                    radius: 50, 
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/arif.jpg'), 
                  ),
                ),
                const SizedBox(height: 10), 
                Text(
                  _userName, 
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

        
          HoverActivityTile(
            icon: Icons.person,
            title: "My Profile",
            subtitle: "View and edit your personal profile", 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.shopping_bag,
            title: "My Orders",
            subtitle: "Track your current and past orders", 
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
            subtitle: "Review items in your shopping cart", 
            onTap: () {
              Navigator.push( 
                context,
                MaterialPageRoute(builder: (context) => const MyCartScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.card_giftcard,
            title: "My Coupon",
            subtitle: "Manage your discount coupons and offers", 
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
            subtitle: "Get assistance and support for any queries", 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
              );
            },
          ),
          HoverActivityTile(
            icon: Icons.history,
            title: "Previous History",
            subtitle: "Access your past activities and data", 
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreviousHistoryScreen()),
              );
            },
          ),
          const SizedBox(height: 20), 
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
  State<HoverActivityTile> createState() => _HoverActivityTileState();
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
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), 
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF1A535C) : Colors.white, 
            borderRadius: BorderRadius.circular(15), 
            border: Border.all(
              color: _isHovered ? const Color(0xFF1A535C) : const Color(0xFFE3E6EB), 
              width: _isHovered ? 1.5 : 1, 
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? Colors.black.withOpacity(0.15) : Colors.black.withOpacity(0.05), 
                blurRadius: _isHovered ? 8 : 4, 
                offset: _isHovered ? const Offset(0, 3) : const Offset(0, 1), 
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 30,
                color: _isHovered ? Colors.white : const Color(0xFF1A535C), 
              ),
              const SizedBox(width: 15), 
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: _isHovered ? Colors.white : const Color(0xFF1A535C), 
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4), 
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                        fontSize: 13, 
                        color: _isHovered ? Colors.white.withOpacity(0.9) : const Color(0xFF1A535C).withOpacity(0.8), 
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios, 
                size: 20,
                color: _isHovered ? Colors.white.withOpacity(0.7) : const Color(0xFF1A535C).withOpacity(0.5), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}