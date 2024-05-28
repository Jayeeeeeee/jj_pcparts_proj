import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/components/button.dart';

import 'package:jj_pcparts_proj/models/products.dart';
import 'package:jj_pcparts_proj/models/shop.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
              backgroundColor: const Color(0x00f7f7f7),
              appBar: AppBar(
                foregroundColor: Colors.black,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.black),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text("My Cart",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                backgroundColor: const Color(0x00f7f7f7),
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
                        // get pants name
                        final String productName = product.pname;
                        // get pants price
                        final String productPrice = product.pprice;

                        // return list stile
                        return Container(
                          decoration: BoxDecoration(
                            color: JJColors.lightContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                            right: 20,
                          ),
                          child: ListTile(
                            title: Text(
                              productName,
                              style: const TextStyle(
                                color: JJColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              productPrice,
                              style: const TextStyle(
                                color: JJColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: JJColors.grey,
                              ),
                              onPressed: () => removeFromCart(product, context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Total Price
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Total Price: ${value.calculateTotal()}",
                      ),
                    ),
                  ),

                  // PAY BUTTON
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: MyButton(text: "Pay Now", onTap: () {}),
                  ),
                ],
              ),
            ));
  }
}
