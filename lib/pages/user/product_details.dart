import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/components/button.dart';
import 'package:jj_pcparts_proj/models/products.dart';
import 'package:jj_pcparts_proj/models/shop.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
// quantity
  int quantityCount = 0;

  // decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  // increment quantity
  void incrementQuantity() {
    setState(() {
      setState(() {
        quantityCount++;
      });
    });
  }

  void addToCart() {
    if (quantityCount > 0) {
      final shop = context.read<Shop>();

      shop.addToCart(widget.product, quantityCount);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                  backgroundColor: JJColors.primary,
                  content: const Text(
                    "Successfully added to cart",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.done, color: Colors.white))
                  ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ListView(
                  children: [
                    Image.network(
                      widget.product.imageUrl,
                      height: 200,
                      width: 200,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[800],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.product.rating)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.product.pname,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Description",
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    const SizedBox(height: 15),
                    Text(
                      widget.product.pdescription,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                color: JJColors.primary,
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "PHP ${widget.product.pprice}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: JJColors.secondary,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: decrementQuantity,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  quantityCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: JJColors.secondary,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: incrementQuantity,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(text: "Add To Cart", onTap: addToCart),
                  ],
                ))
          ],
        ));
  }
}
