import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/components/button.dart';

import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:jj_pcparts_proj/utils/constants/image_strings.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JJColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 25,
            ),

            // Shop name
            const Text(
              "JJ PC Parts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'DM Serif Display',
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Icon
            Padding(
              padding: const EdgeInsets.fromLTRB(150, 25, 150, 50),
              child: Image.asset(JJImages.appLogo),
            ),
            const SizedBox(
              height: 25,
            ),
            // Title
            const Text(
              "The Best and Affordable PC Parts You will ever find!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'DM Serif Display'),
            ),
            const Text(
              "Shop Now!",
              style: TextStyle(
                color: Colors.grey,
                height: 2,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // Get started button
            MyButton(
              text: "Get Started",
              onTap: () {
                //go to menu page
                Navigator.pushNamed(context, '/menupage');
              },
            )
          ],
        ),
      ),
    );
  }
}
