import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: addproduct(),
  ));
}

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<addproduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _additionalField1Controller = TextEditingController();
  final TextEditingController _additionalField2Controller = TextEditingController();
  final TextEditingController _additionalField3Controller = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _additionalField4Controller = TextEditingController();
  final TextEditingController trackl = TextEditingController();



  late String _selectedCategory;
  final List<String> _categories = ['Fruits', 'Vegetables', 'Nuts & spices', 'Cereals'];

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
  }

  Future<void> _pickImage() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } else {
      print('Camera permission denied');
    }
  }

  Future<void> _saveProduct() async {
    var data = {
      "pname": _productNameController.text,
      "des": _descriptionController.text,
      "price": _priceController.text,
      "fname": _additionalField1Controller.text,
      "address": _additionalField2Controller.text,
      "location": _additionalField3Controller.text,
      "category": _selectedCategory,
      "quantity": _quantityController.text,


    };

    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User? user = _auth.currentUser;
      String? userId = user?.uid;



      DatabaseReference _database = FirebaseDatabase.instance.reference();
      String? dataKey = _database.child('Product').push().key;
      await _database.child('Product').child(userId! + dataKey!).set({
        "pname": _productNameController.text,
        "des": _descriptionController.text,
        "price": _priceController.text,
        "fname": _additionalField1Controller.text,
        "address": _additionalField2Controller.text,
        "location": _additionalField3Controller.text,
        "category": _selectedCategory,
        "quantity": _quantityController.text,
        "udkey": userId! + dataKey!,
        "fkey": userId,
        "gmap": trackl.text,



      });
      if (_imageFile != null) {
        final storageReference = FirebaseStorage.instance.ref().child('product_images/${userId! + dataKey!}.jpg');

        await storageReference.putFile(_imageFile!);
        final imageUrl = await storageReference.getDownloadURL();

        // Add the imageUrl to your data
        data["image"] = imageUrl;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Added Successfully',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blue,
          elevation: 4.0,
        ),
      );

      _productNameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _additionalField1Controller.clear();
      _additionalField2Controller.clear();
      _additionalField3Controller.clear();
      _imageUrlController.clear();
      _quantityController.clear();

      setState(() {
        _imageFile = null;
      });
    } catch (e) {
      print('Error saving product: $e');
      // Handle error saving product
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Capture Image'),
            ),
            _imageFile != null ? Image.file(_imageFile!) : Text('No image captured'),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value ?? _categories.first;
                });
              },
              decoration: InputDecoration(
                hintText: 'Select product category',
                labelText: 'Category',
              ),
            ),
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: _additionalField1Controller,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _additionalField2Controller,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _additionalField3Controller,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: trackl,
              decoration: InputDecoration(labelText: 'Track Location'),
            ),


          ],
        ),
      ),
    );
  }
}
