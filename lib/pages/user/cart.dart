import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/components/button.dart';

import 'package:jj_pcparts_proj/models/products.dart';
import 'package:jj_pcparts_proj/models/shop.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:jj_pcparts_proj/pages/user/customer_order.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  // remove from cart
  void removeFromCart(Product product, BuildContext context) {
    // get access to shop
    final shop = context.read<Shop>();

    // remove from cart
    shop.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: JJColors.primaryBackground,
        appBar: AppBar(
          foregroundColor: JJColors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart, color: JJColors.black),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Text(
                  "My Cart",
                  style: TextStyle(color: JJColors.black),
                ),
              ),
            ],
          ),
          backgroundColor: JJColors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            // CUSTOMER CART
            Expanded(
              child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                    // get pants from the cart
                    final Product product = value.cart[index];

                    //Display only one item for each unique product

                    if (index == 0 || product.id != value.cart[index - 1].id) {
                      //get quantity
                      final int quantity = value.getQuantity(product);

                      // get pants name
                      final String productName = product.pname;

                      // get pants price
                      final String productPrice = product.pprice;

                      // return list tile
                      return Container(
                        decoration: BoxDecoration(
                          color: JJColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl,
                            height: 50,
                            width: 50,
                          ),
                          title: Text(
                            "$productName x $quantity", // Display quantity
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "PHP  ${double.parse(productPrice).toStringAsFixed(2)} ",
                            style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey[300],
                            ),
                            onPressed: () => removeFromCart(product, context),
                          ),
                        ),
                      );
                    } else {
                      //Display an empty container for duplicate items
                      return Container();
                    }
                  }),
            ),

            // Total Price
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(24),
                child: Text(
                  "TOTAL: PHP ${double.parse(value.calculateTotal().toString()).toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // PAY BUTTON
            // Check if the cart is empty before enabling the pay button
            value.cart.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(
                      text: "BUY NOW",
                      onTap: () {}, // Disabled button
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(
                      text: "BUY NOW",
                      onTap: () {
                        // Navigate to the customer_page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomerOrder()),
                        );

                        MyButton.changeButtonColor(JJColors.primary);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
