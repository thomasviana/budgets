import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
