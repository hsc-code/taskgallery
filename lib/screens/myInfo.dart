import 'package:flutter/material.dart';
import '../utils.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});


  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    double childAspectRatio;
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    if (screenWidth > 1000) {
      crossAxisCount = 4;
    } else if (screenWidth > 500) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    if (screenWidth > 1500) {
      childAspectRatio = 20/3;
    }else if (screenWidth > 1000) {
      childAspectRatio = 16/4;
    } else {
      childAspectRatio = 8;
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:  Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent,Colors.purple, Colors.pinkAccent],
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
              )
          ),
        ),
        title: Text(
          'About',
          style: TextStyle(
              fontSize: 40, // Adjust the size as needed
              fontWeight: FontWeight.bold,
              color: Colors.white// Adjust the weight as needed
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: double.infinity,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/my-pic.jpg'),
                            radius: MediaQuery.of(context).size.width > 1000
                                ? 120
                                : 80,
                          ),
                        ],
                      ),
                    )
                ),
              ),
              GridView.count(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  AboutDisplayField(text1: 'Name', text2: 'Harneet Singh Channa'),
                  AboutDisplayField(text1: 'Designation', text2: 'Software Developer'),
                  AboutDisplayField(text1: 'Age', text2: '22 years'),
                  AboutDisplayField(text1: 'Mobile', text2: '+91 9654287797'),
                  AboutDisplayField(text1: 'Email', text2: 'harneetsinghch110@gmail.com'),
                  AboutDisplayField(text1: 'Experience', text2: 'One year'),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
