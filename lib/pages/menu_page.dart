import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/components/catergory.dart';

import 'package:jj_pcparts_proj/components/product_tile.dart';

import 'package:jj_pcparts_proj/models/shop.dart';
import 'package:jj_pcparts_proj/pages/product_details_page.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // navigate to pants item detail page
  void navigateToProductDetails(int index) {
    // get the shop and it's menu
    final shop = context.read<Shop>();
    final productMenu = shop.productMenu;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsPage(
          product: productMenu[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get the shop and it's menu
    final shop = context.read<Shop>();
    final productMenu = shop.productMenu;

    return Scaffold(
      backgroundColor: JJColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: const Text('OnlyPants'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cartpage');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 29,
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 196, 193, 193),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 159, 154, 154),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 190, 188, 188)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 189, 187, 187)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Search ",
              ),
            ),
          ),

          // Category section with 3 buttons aligned in row
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CategoryContainer(categoryName: 'Category 1', onPressed: () {}),
              const SizedBox(width: 20),
              CategoryContainer(categoryName: 'Category 2', onPressed: () {}),
              const SizedBox(width: 20),
              CategoryContainer(categoryName: 'Category 3', onPressed: () {}),
            ],
          ),

          // Available Products section
          const SizedBox(height: 20),

          // Clickable products aligned column
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                // Set the background color to grey
                child: Wrap(
                  spacing: 5.0, // Adjust spacing between products
                  runSpacing: 10.0, // Adjust spacing between rows
                  children: productMenu
                      .map((product) => ProductTile(
                            product: product,
                            onTap: () => navigateToProductDetails(
                                productMenu.indexOf(product)),
                          ))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
