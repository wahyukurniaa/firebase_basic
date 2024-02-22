import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/SignIn');
              },
              child: const Text('Sign In with Email Account'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/SignUp');
              },
              child: const Text('Sign Up with Email Account'),
            ),
          ],
        ),
      ),
    );
  }
}
