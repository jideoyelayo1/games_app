import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Practice')),
      body: Center(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          //can use Column for vertical and Row for horizontal
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/image0.jpg'),
          ],
        ),
      )),
    );
  }
}
