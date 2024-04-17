import 'package:flutter/material.dart';
import 'package:taskgallery/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white), // Set the color of the icon
        ),
        dividerColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
