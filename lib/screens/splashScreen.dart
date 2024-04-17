import 'dart:async';
import 'package:flutter/material.dart';
import 'galleryScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashPage();
}
class _SplashPage extends State<SplashScreen> {


  @override
  void initState() {
    Timer(const Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GalleryScreen(),));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_screen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
              child: Text('Photo Gallery',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,color: Colors.white),)
          ),
        )

    );

  }
}
