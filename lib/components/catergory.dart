import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

class CategoryContainer extends StatelessWidget {
  final String categoryName;
  final VoidCallback onPressed;

  const CategoryContainer({
    super.key,
    required this.categoryName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: JJColors.white,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: const Color.fromARGB(0, 187, 5, 5),
          shape: const CircleBorder(),
          shadowColor: const Color.fromARGB(0, 188, 11, 11),
        ),
        child: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
