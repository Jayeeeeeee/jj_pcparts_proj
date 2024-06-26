// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:jj_pcparts_proj/utils/constants/image_strings.dart';
import 'package:jj_pcparts_proj/utils/constants/sizes.dart';
import 'package:jj_pcparts_proj/utils/constants/text_strings.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late String errormessage;
  late bool isError;

  @override
  void initState() {
    errormessage = "This is an error";
    isError = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: JJColors.white, actions: [
        IconButton(
          icon: const Icon(
            Icons.admin_panel_settings_outlined,
            color: JJColors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/adminlogin');
          },
        )
      ]),
      body: Container(
        color: JJColors.primaryBackground, // Set background color to grey
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      JJImages.appLogo,
                      height: 150,
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Adjust spacing as needed
                const Text(
                  'JJ PC Parts',
                  style: TextStyle(
                    color: JJColors.primary,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: usernamecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: JJTexts.username,
                    prefixIcon: Icon(Icons.person_3_outlined),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  controller: passwordcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: JJTexts.password,
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: JJColors.primary,
                  ),
                  onPressed: () {
                    checkLogin(
                        usernamecontroller.text, passwordcontroller.text);
                  },
                  child: const Text(
                    JJTexts.login,
                    style: TextStyle(color: JJColors.white),
                  ),
                ),
                const SizedBox(
                  height: JJSizes.spaceBtwSections,
                ),
                ElevatedButton(
                  //
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: JJColors.primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    JJTexts.createAccount,
                    style: TextStyle(color: JJColors.white),
                  ),
                ), //
                const SizedBox(height: 15),
                (isError)
                    ? Text(errormessage, style: errortxtstyle)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var errortxtstyle = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    letterSpacing: 1,
    fontSize: 18,
  );

  Future checkLogin(username, password) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      if (user != null) {
        // Successful login, redirect to customerview page
        Navigator.pushReplacementNamed(context, '/customerview');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message.toString();
        isError = true;
      });
    }
  }
}
