import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatefulWidget {
  final double totalAmount;
  final int totalItems;

  const OrderConfirmationPage({
    Key? key,
    required this.totalAmount,
    required this.totalItems,
  }) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phone = '';

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Order Placed"),
          content: Text(
              "Thank you $name! Your order for ${widget.totalItems} item(s) has been placed."),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Order"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryCard(),
            SizedBox(height: 20),
            _buildDeliveryForm(),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Confirm Order", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Items", style: TextStyle(fontSize: 16)),
              Text("${widget.totalItems}", style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price", style: TextStyle(fontSize: 16)),
              Text("৳${widget.totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          
          Row(
            children: [
              Icon(Icons.money, color: Colors.teal),
              SizedBox(width: 8),
              Text(
                "Payment Method: Cash On Delivery (COD)",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField("Full Name", (val) => name = val!),
          SizedBox(height: 12),
          _buildTextField("Phone Number", (val) => phone = val!, isPhone: true),
          SizedBox(height: 12),
          _buildTextField("Delivery Address", (val) => address = val!, maxLines: 3),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave,
      {bool isPhone = false, int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? "Required field" : null,
      onSaved: onSave,
    );
  }
}
