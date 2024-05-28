import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You successfully connected to Firebase!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('signed as: '),
            const SizedBox(
              height: 15,
            ),
            Text(user.email!),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
