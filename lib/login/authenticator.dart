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
            return Container();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          } else if (snapshot.hasData) {
            return const CustomerView();
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
