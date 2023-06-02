import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;
  final birdX;

  final double birdWidth;
  final double birdHeight;

  MyBird(
      {this.birdX,
      this.birdY,
      required this.birdWidth,
      required this.birdHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(birdX, birdY),
      //color: Colors.red,
      child: Image.asset(
        'assets/flappybird/bird.png',
        width: 50,
      ),
    );
  }
}
