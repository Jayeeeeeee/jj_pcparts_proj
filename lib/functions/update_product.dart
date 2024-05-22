import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/models/products.dart';
import 'dart:html' as html;
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController pnameController = TextEditingController();
  TextEditingController ppriceController = TextEditingController();
  TextEditingController pdescriptionController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  late String errormessage;
  late bool isError;
  String imageUrl = '';

  @override
  void initState() {
    errormessage = "This is an error";
    isError = false;
    pnameController.text = widget.product.pname;
    ppriceController.text = widget.product.pprice as String;
    pdescriptionController.text = widget.product.pdescription;
    ratingController.text = widget.product.rating;
    imageUrl = widget.product.imageUrl;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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

                // const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: JJColors.primary, // Set the color to purple
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Update Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        height: 100,
                      )
                    : Container(),
                const SizedBox(height: 15),
                TextField(
                  controller: pnameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Name',
                    prefixIcon:
                        Icon(Icons.person_2_outlined, color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ppriceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter price',
                    prefixIcon:
                        Icon(Icons.attach_money, color: JJColors.primary),
                  ),
                ),

                const SizedBox(height: 15),
                TextField(
                  controller: pdescriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Description',
                    prefixIcon: Icon(Icons.description_outlined,
                        color: JJColors.primary),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ratingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Rating',
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
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () async {
                      await updateProduct(widget.product.id);

                      // Update the user object in the widget

                      // Notify the parent widget that the user has been updated
                      setState(() {});
                    },
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                (isError)
                    ? Text(
                        errormessage,
                        style: errortxtstyle,
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateProduct(String id) async {
    final docProduct = FirebaseFirestore.instance.collection('Product').doc(id);
    docProduct.update({
      'pname': pnameController.text,
      'pprice': ppriceController.text,
      'pdescription': pdescriptionController.text,
      'rating': ratingController.text,
      'imageUrl': imageUrl,
    });

    // Reset error message
    setState(() {
      errormessage = "";
    });

    Navigator.pop(context);
  }

  var errortxtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    letterSpacing: 1,
    fontSize: 18,
  );
  var txtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    fontSize: 38,
  );
}
