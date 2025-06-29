import 'dart:typed_data'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();


  final _nameController = TextEditingController(text: 'Arif');
  final _storeNameController = TextEditingController(text: 'Discount shop');
  final _idNoController = TextEditingController(text: '101');
  final _addressController = TextEditingController(text: 'SUST Gate');
  final _numberController = TextEditingController(text: '01309316735');

  Uint8List? _imageBytes; 
  bool _isCameraHovered = false; 

  
  Future<void> _pickImage() async {
    debugPrint('Attempting to pick image...');
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      debugPrint('Image picked successfully. Name: ${pickedFile.name}');
      final Uint8List bytes = await pickedFile.readAsBytes(); 
      setState(() {
        _imageBytes = bytes; 
        debugPrint('Image state updated. Bytes length: ${_imageBytes?.length}');
      });
    } else {
      debugPrint('Image picking cancelled or no image selected.');
    }
  }

  
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Updated Profile:\n'
            'Name: ${_nameController.text}\n'
            'Store: ${_storeNameController.text}\n'
            'ID: ${_idNoController.text}\n'
            'Address: ${_addressController.text}\n'
            'Number: ${_numberController.text}',
            style: const TextStyle(fontSize: 15),
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: const Color(0xFF1A535C),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(15),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _storeNameController.dispose();
    _idNoController.dispose();
    _addressController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          'Personal Profile',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1A535C)),
        actions: [
          TextButton(
            onPressed: _submitForm,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color.fromARGB(255, 155, 118, 25),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFE0F2F1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        
                        key: ValueKey(_imageBytes != null ? _imageBytes.hashCode : 'default_profile_image'),
                        radius: 65,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _imageBytes != null
                            ? MemoryImage(_imageBytes!) 
                            : const AssetImage('assets/images/arif.jpg') as ImageProvider, 
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: MouseRegion(
                        onEnter: (_) => setState(() => _isCameraHovered = true),
                        onExit: (_) => setState(() => _isCameraHovered = false),
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _isCameraHovered ? const Color(0xFF0F3B43) : const Color(0xFF1A535C),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(_isCameraHovered ? 0.3 : 0.15),
                                  blurRadius: _isCameraHovered ? 12 : 6,
                                  spreadRadius: _isCameraHovered ? 2 : 1,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField('Name', _nameController, icon: Icons.person),
              const SizedBox(height: 15),
              _buildTextField('Store Name', _storeNameController, icon: Icons.store),
              const SizedBox(height: 15),
              _buildTextField('ID No', _idNoController, icon: Icons.badge),
              const SizedBox(height: 15),
              _buildTextField('Address', _addressController, icon: Icons.location_on),
              const SizedBox(height: 15),
              _buildTextField('Number', _numberController,
                  keyboardType: TextInputType.phone, icon: Icons.phone),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, IconData? icon}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFF1A535C), fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF1A535C), fontWeight: FontWeight.w500),
        prefixIcon: icon != null ? Icon(icon, color: const Color(0xFF1A535C).withOpacity(0.7)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFB2DFDB), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFB2DFDB), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF1A535C), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}