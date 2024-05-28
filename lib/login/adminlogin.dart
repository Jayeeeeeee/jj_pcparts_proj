// admin_login.dart

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:jj_pcparts_proj/utils/constants/image_strings.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errorMessage;
  late bool isError;

  @override
  void initState() {
    errorMessage = "This is an error";
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
      appBar: AppBar(
        backgroundColor: JJColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        color: JJColors.primaryBackground,
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
                const SizedBox(height: 10),
                const Text(
                  'Admin Login',
                  style: TextStyle(
                    color: JJColors.primary,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username/Email',
                    prefixIcon: Icon(Icons.person_3_outlined),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
                        usernameController.text, passwordController.text);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: JJColors.white),
                  ),
                ),
                const SizedBox(height: 25),
                const SizedBox(height: 15),
                (isError)
                    ? Text(errorMessage, style: errortxtstyle)
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
      final adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Successful login, redirect to adminview page
        Navigator.pushReplacementNamed(context, '/admin_view');
      } else {
        setState(() {
          errorMessage = "Invalid Username or Password";
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = '$e';
        isError = true;
      });
    }
  }
}
