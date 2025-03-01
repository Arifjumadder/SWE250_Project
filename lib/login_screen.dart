
import 'package:firstapp/registration_screen.dart';
import 'package:flutter/material.dart';
import 'order_medicine_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2833),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, 
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.white), 
                  labelText: 'Enter your email',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFFFFD700)),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1), 
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.white), 
                  suffixIcon: Icon(Icons.visibility, color: Colors.white), 
                  labelText: 'Enter your password',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.8)), 
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
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: const Color(0xFFFF6F61), 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                   
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderMedicineScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Login Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8), 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'SignUp now',
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