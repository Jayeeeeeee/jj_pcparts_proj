import 'package:flutter/material.dart';

import 'package:jj_pcparts_proj/models/products.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

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
          color: JJColors.white,
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
              style: const TextStyle(color: JJColors.black),
            ),

            //price + rating
            SizedBox(
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //price
                    Text('\$${product.pprice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: JJColors.black)),

                    //rating
                    const Icon(
                      Icons.star,
                      color: JJColors.rating,
                    ),
                    Text(product.rating,
                        style: const TextStyle(color: JJColors.grey))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
