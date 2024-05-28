import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: JJColors.black,
          borderRadius: BorderRadius.circular(13),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: JJColors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward,
              color: JJColors.white,
            ),
          ],
        ),
      ),
    );
  }

  static void changeButtonColor(Color primaryColor) {}
}
