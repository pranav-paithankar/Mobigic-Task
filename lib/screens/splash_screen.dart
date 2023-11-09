import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'grid_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.eco_rounded,
                color: Colors.purple,
                size: 100,
              ),
            ),
            SizedBox(height: 30),
            TypewriterAnimatedTextKit(
              text: ['Word Search Game'],
              textStyle: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              speed: Duration(milliseconds: 200),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GridScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.white,
                textStyle: TextStyle(fontSize: 30),
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}
