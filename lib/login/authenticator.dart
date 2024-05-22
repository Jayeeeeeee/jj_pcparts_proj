import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:jj_pcparts_proj/login/login_page.dart';
import 'package:jj_pcparts_proj/pages/user/customerview.dart';

class _AuthenticatorState extends State<Authenticator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Remove the loading circle
            // return const Center(
            //   child: CircularProgressIndicator(),
            // );
            return Container(); // Empty container for placeholder
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something wrong'),
            );
          } else if (snapshot.hasData) {
            return CustomerView();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}

class Authenticator extends StatefulWidget {
  const Authenticator({super.key});

  @override
  State<Authenticator> createState() => _AuthenticatorState();
}
