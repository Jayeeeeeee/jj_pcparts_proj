import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/login/authenticator.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errorMessage;
  late bool isError;
  late bool registrationSuccess;

  @override
  void initState() {
    errorMessage = "This is an error";
    isError = false;
    registrationSuccess = false;
    super.initState();
  }

  // Function to check if all text fields are filled
  bool areFieldsFilled() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create an account',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: JJColors.primary),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter name',
                  prefixIcon: Icon(Icons.person_3_outlined),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: JJColors
                      .primaryBackground, // Set the button color to purple
                ),
                onPressed: () {
                  if (areFieldsFilled()) {
                    registerUser();
                  } else {
                    // Show a message or take any action for incomplete fields
                    showError("Fill all fields.");
                  }
                },
                child: const Text(
                  'REGISTER',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              registrationSuccess
                  ? const Text(
                      "Account successfully created!",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  // Navigate to the Login page
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              (isError)
                  ? Text(
                      errorMessage,
                      style: errortxtstyle,
                    )
                  : Container(),
            ],
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

  Future createUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.uid;
    final docUser = FirebaseFirestore.instance.collection('User').doc(userId);

    final newUser = User(
      id: userId,
      name: nameController.text,
      email: emailController.text,
    );

    final json = newUser.toJson();
    await docUser.set(json);
    goToAuthenticator();
  }

  void showError(String message) {
    setState(() {
      isError = true;
      errorMessage = message;
    });
  }

  Future registerUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      createUser();
      setState(() {
        registrationSuccess = true;
        isError = false;
        errorMessage = "";
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      showError(e.message.toString());
      setState(() {
        registrationSuccess = false;
      });
    }
  }

  void goToAuthenticator() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Authenticator(),
      ),
    );
  }
}
