import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart'; 

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNoController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _storeAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false; 
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _idNoController.dispose();
    _storeNameController.dispose();
    _storeAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

 
  InputDecoration _premiumInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.8), size: 22),
      errorStyle: const TextStyle(color: Color(0xFFFF6F61), fontSize: 13),
      filled: true,
      fillColor: Colors.white.withOpacity(0.08), 
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 1), 
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF8C52FF), width: 2), 
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6F61), width: 1.5), 
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6F61), width: 2), 
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

 
  Future<void> _signup() async {
  
    if (!_formKey.currentState!.validate()) {
   
      if (!_agreeToTerms) {
        _showSnackBar("Please agree to the Terms and Conditions.");
      } else {
        _showSnackBar("Please correct the errors in the form.");
      }
      return;
    }

    if (!_agreeToTerms) {
      _showSnackBar("Please agree to the Terms and Conditions.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      _showSnackBar("Signup Successful! You can now log in.");
     
      Navigator.pop(context); 
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'weak-password':
         
          message = 'The password provided is too weak. It must be at least 6 characters and contain letters, numbers, and special characters.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled. Please contact support.';
          break;
        default:
          message = 'Signup failed: ${e.message ?? "An unknown error occurred."}';
      }
      _showSnackBar(message);
    } catch (e) {
      _showSnackBar("An unexpected error occurred: $e");
    } finally {
      setState(() {
        _isLoading = false; 
      });
    }
  }

  void _showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: backgroundColor ?? const Color(0xFF8C52FF).withOpacity(0.9),
        behavior: SnackBarBehavior.floating, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2833),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2833),
        elevation: 0, 
        title: const Text(
          'Create Your Account', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22, 
            letterSpacing: 0.8,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack( 
        children: [
          Padding(
            padding: const EdgeInsets.all(20), 
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    TextFormField(
                      controller: _nameController,
                      decoration: _premiumInputDecoration("Full Name", Icons.person),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15), 

                  
                    TextFormField(
                      controller: _emailController,
                      decoration: _premiumInputDecoration("Email Address", Icons.email),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _premiumInputDecoration("Phone Number", Icons.phone),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Phone number should only contain numbers';
                        }
                        if (value.length < 10 || value.length > 11) { 
                          return 'Phone number must be between 10-11 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _idNoController,
                      keyboardType: TextInputType.number,
                      decoration: _premiumInputDecoration("ID Number", Icons.badge),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ID number';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'ID number should only contain digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

         
                    TextFormField(
                      controller: _storeNameController,
                      decoration: _premiumInputDecoration("Store Name", Icons.store),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your store name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                
                    TextFormField(
                      controller: _storeAddressController,
                      decoration: _premiumInputDecoration("Store Address", Icons.location_on),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your store address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                  
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _premiumInputDecoration("Password", Icons.lock).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 4) {
                          return 'Password must be at least 4 characters long.';
                        }

                      
                        final RegExp hasDigit = RegExp(r'[0-9]');
                        final RegExp hasLetter = RegExp(r'[a-zA-Z]');
                        
                       
                        final RegExp hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>\-_+=;\[\]\\/`~]');

                        String errors = '';
                        if (!hasDigit.hasMatch(value)) {
                          errors += '• at least one number\n';
                        }
                        if (!hasLetter.hasMatch(value)) {
                          errors += '• at least one letter\n';
                        }
                        if (!hasSpecialChar.hasMatch(value)) {
                          errors += '• at least one special character (e.g., !@#\$%^&*)\n';
                        }

                        if (errors.isNotEmpty) {
                          return 'Password must contain:\n' + errors;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

             
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      decoration: _premiumInputDecoration("Confirm Password", Icons.lock_outline),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

              
                    CheckboxListTile(
                      value: _agreeToTerms,
                      onChanged: (val) {
                        setState(() {
                          _agreeToTerms = val ?? false;
                        });
                      },
                      title: Text(
                        "I agree to the Terms and Conditions",
                        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15),
                      ),
                      activeColor: const Color(0xFF4ECDC4),
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                      tileColor: Colors.white.withOpacity(0.05), 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    const SizedBox(height: 30), 

                 
                    SizedBox(
                      width: double.infinity,
                      height: 55, 
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signup,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), 
                          ),
                          elevation: 8, 
                          shadowColor: const Color(0xFF4CAF50).withOpacity(0.5), 
                          backgroundColor: Colors.transparent, 
                          foregroundColor: Colors.white, 
                        ).copyWith(
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color(0xFF4CAF50).withOpacity(0.2); 
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Ink( 
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)], 
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(minHeight: 55),
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white) 
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1, 
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25), 

                
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 16,
                                ),
                              ),
                              const TextSpan(
                                text: 'Log In',
                                style: TextStyle(
                                  color: Color(0xFF8C52FF), 
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
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
          ),
        
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5), 
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF8C52FF)), 
              ),
            ),
        ],
      ),
    );
  }
}