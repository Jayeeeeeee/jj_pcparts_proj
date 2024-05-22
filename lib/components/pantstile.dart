import 'package:flutter/material.dart';

import 'package:jj_pcparts_proj/models/products.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final void Function()? onTap;
  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(
          left: 30,
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              product.pname,
            ),

            //price + rating
            SizedBox(
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text('\$${product.pprice}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700])),

                    //rating
                    Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                    ),
                    Text(product.rating,
                        style: const TextStyle(color: Colors.grey))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
