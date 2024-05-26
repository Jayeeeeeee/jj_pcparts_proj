import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jj_pcparts_proj/models/products.dart';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController pnamecontroller = TextEditingController();
  TextEditingController ppricecontroller = TextEditingController();
  TextEditingController ratingcontroller = TextEditingController();
  TextEditingController pdescriptioncontroller = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  late String errormessage;
  late bool isError;
  String imageUrl = '';
  String selectedCategory = ''; // Set default category to an empty string

  @override
  void initState() {
    errormessage = "This is an error";
    isError = false;
    super.initState();
  }

  Future<void> _pickImage() async {
    try {
      final html.FileUploadInputElement input = html.FileUploadInputElement()
        ..click();
      input.onChange.listen((event) async {
        final files = input.files;
        if (files!.isNotEmpty) {
          final file = files.first;
          final reader = html.FileReader();
          reader.readAsDataUrl(file);

          reader.onLoadEnd.listen((loadEndEvent) async {
            // Display the picked image
            setState(() {
              imageUrl = reader.result as String;
            });
          });
        }
      });

      // Trigger the file dialog
      input.click();
    } catch (error) {
      print("Error picking image: $error");
    }
  }

  Future<void> _uploadImage(html.File file) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = storageRef.putBlob(file);
      await uploadTask.whenComplete(() async {
        imageUrl = await storageRef.getDownloadURL();
      });
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  Future<void> createProduct() async {
    if (imageUrl.isEmpty) {
      setState(() {
        errormessage = "Please select an image before saving the product.";
        isError = true;
      });
      return;
    }

    try {
      final docProduct = FirebaseFirestore.instance.collection('Product').doc();
      final newProduct = Product(
        id: docProduct.id,
        imageUrl: imageUrl,
        rating: ratingcontroller.text,
        pname: pnamecontroller.text,
        pprice: ppricecontroller.text,
        pdescription: pdescriptioncontroller.text,
        pcategory: categoryController.text, // Use categoryController.text
      );

      final json = newProduct.toJson();
      await docProduct.set(json);

      setState(() {
        pnamecontroller.text = "";
        ppricecontroller.text = "";
        pdescriptioncontroller.text = "";
        imageUrl = "";
        categoryController.text = ""; // Reset to an empty string
        Navigator.pop(context);
      });
    } catch (error) {
      setState(() {
        isError = true;
        errormessage = "Error creating the product. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                // Container with padding for Pick Image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Display the picked image at the top
                      imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              height: 100,
                            )
                          : Container(),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Pick Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: JJColors.primaryBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // Dropdown for Category
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                      categoryController.text =
                          newValue; // Update categoryController.text
                    });
                  },
                  items: <String>['', 'Men', 'Women', 'Unisex']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.isEmpty ? 'Select Category' : value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: pnamecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product name',
                    prefixIcon:
                        Icon(Icons.person_3_outlined, color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ppricecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Price',
                    prefixIcon: Icon(Icons.price_check_outlined,
                        color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: pdescriptioncontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description_outlined,
                        color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ratingcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rating',
                    prefixIcon: Icon(Icons.star, color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 45),
                Container(
                  decoration: BoxDecoration(
                    color: JJColors.primary, // Set the color to purple
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JJColors.primary,
                      minimumSize: const Size.fromHeight(55),
                    ),
                    onPressed: createProduct,
                    child: const Text(
                      'Create Product',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                isError
                    ? Text(
                        errormessage,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
