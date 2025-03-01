import 'package:flutter/material.dart';

class MyCouponScreen extends StatefulWidget {
  const MyCouponScreen({super.key});

  @override
  _MyCouponScreenState createState() => _MyCouponScreenState();
}

class _MyCouponScreenState extends State<MyCouponScreen> {
  bool _showCouponInput = false; 
  bool _isAddCouponHovered = false; 
  bool _isSubmitHovered = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'My Coupons',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFF1A535C)),
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100), 
          Icon(
            Icons.local_offer_outlined,
            size: 50,
            color: Color(0xFF1A535C),
          ),
          SizedBox(height: 15),
          Text(
            'You have no Coupons',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF1A535C),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15),
          
          MouseRegion(
            onEnter: (_) => setState(() => _isAddCouponHovered = true),
            onExit: (_) => setState(() => _isAddCouponHovered = false),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showCouponInput = !_showCouponInput;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A535C),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: _isAddCouponHovered
                    ? Color(0xFF1A535C).withOpacity(0.6)
                    : Color.fromARGB(255, 73, 177, 193).withOpacity(0.4),
                elevation: _isAddCouponHovered ? 10 : 4,
              ),
              child: Text(
                _showCouponInput ? 'Hide Add Coupon' : 'Add a Coupon',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              height: _showCouponInput ? 200 : 0, 
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _showCouponInput
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Coupon Code',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A535C),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your coupon code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              MouseRegion(
                                onEnter: (_) => setState(() => _isSubmitHovered = true),
                                onExit: (_) => setState(() => _isSubmitHovered = false),
                                child: ElevatedButton(
                                  onPressed: () {
                                    print('Coupon code submitted');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1A535C),
                                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    shadowColor: _isSubmitHovered
                                        ? Color(0xFF1A535C).withOpacity(0.6)
                                        : Color(0xFF1A535C).withOpacity(0.4),
                                    elevation: _isSubmitHovered ? 10 : 4,
                                  ),
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showCouponInput = false;
                                  });
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}



