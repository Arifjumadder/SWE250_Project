import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idNoController = TextEditingController();
  bool _isFormValid = false;
  bool _attemptedSubmit = false;
  String? _phoneError;
  String? _idNoError;
  String? _passwordError;

  void _validatePhoneNumber(String value) {
    setState(() {
      if (value.isEmpty) {
        _phoneError = null;
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        _phoneError = 'Phone number should only contain numbers';
      } else if (value.length > 11) {
        _phoneError = 'Phone number should only be 11 digits';
      } else {
        _phoneError = null;
      }
    });
  }

  void _validateIdNo(String value) {
    setState(() {
      if (value.isEmpty) {
        _idNoError = null;
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        _idNoError = 'ID No should only contain numerical digits';
      } else {
        _idNoError = null;
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordError = null;
      } else if (value.length < 6) {
        _passwordError = 'Password should contain at least 6 digits';
      } else if (!RegExp(r'^(?=.[0-9])(?=.[a-zA-Z])').hasMatch(value)) {
        _passwordError = 'Password should contain both numerical and non-numerical values';
      } else {
        _passwordError = null;
      }
    });
  }

  void _validateForm() {
    setState(() {
      _attemptedSubmit = true;
      _isFormValid = _formKey.currentState!.validate() && _phoneError == null && _idNoError == null && _passwordError == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2833), 
      appBar: AppBar(
        title: Text(
          'Registration',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F2833), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.person, color: Colors.white), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.email, color: Colors.white), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Enter phone number',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.phone, color: Colors.white), 
                  errorText: _phoneError,
                  errorStyle: TextStyle(color: const Color(0xFFFF6F61)), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                keyboardType: TextInputType.phone,
                onChanged: _validatePhoneNumber,
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _idNoController,
                decoration: InputDecoration(
                  labelText: 'Enter ID No',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.badge, color: Colors.white),
                  errorText: _idNoError,
                  errorStyle: TextStyle(color: const Color(0xFFFF6F61)), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                keyboardType: TextInputType.number,
                onChanged: _validateIdNo,
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Store Name',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.store, color: Colors.white), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Store Address',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.location_on, color: Colors.white), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Create a password',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  errorText: _passwordError,
                  errorStyle: TextStyle(color: const Color(0xFFFF6F61)), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                obscureText: true,
                onChanged: _validatePassword,
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm a password',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)), 
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Password does not match, please try again';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white), 
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, 
                    ),
                  ),
                ),
              ),
              if (_attemptedSubmit && !_isFormValid)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please fulfill the above condition',
                    style: TextStyle(color: const Color(0xFFFF6F61)), 
                  ),
                ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Login now',
                          style: TextStyle(
                            color: const Color(0xFF8C52FF), 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}