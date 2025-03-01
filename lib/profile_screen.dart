import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String _name = '';
  String _storeName = '';
  String _idNo = '';
  String _address = '';
  String _number = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Updated Successfully!'),
          backgroundColor: Color(0xFF1A535C),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        title: Text(
          'Personal Profile',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              'Edit',
              style: TextStyle(
                color: Color.fromARGB(255, 155, 118, 25),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFE0F2F1), 
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Name', (value) => _name = value!),
              SizedBox(height: 15),
              _buildTextField('Store Name', (value) => _storeName = value!),
              SizedBox(height: 15),
              _buildTextField('ID No', (value) => _idNo = value!),
              SizedBox(height: 15),
              _buildTextField('Address', (value) => _address = value!),
              SizedBox(height: 15),
              _buildTextField('Number', (value) => _number = value!, isPhone: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave, {bool isPhone = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1A535C), width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Color(0xFF1A535C)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1A535C), width: 2),
        ),
      ),
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onSaved: onSave,
    );
  }
}
