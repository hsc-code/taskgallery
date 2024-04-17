import 'package:flutter/material.dart';

class AboutDisplayField extends StatelessWidget {
  final String text1;
  final String text2;
  const AboutDisplayField({super.key,
    required this.text1,
    required this.text2});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.indigo,
              spreadRadius: 1, // Spread radius
              blurRadius: 4, // Blur radius
              offset: const Offset(0,1), // Offset in the X and Y direction
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  text1,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                ':  $text2',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}