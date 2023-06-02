import 'dart:async';

import 'package:flutter/material.dart';

import 'barrier.dart';
import 'bird.dart';

class FlappyBird extends StatefulWidget {
  const FlappyBird({super.key});

  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

class _FlappyBirdState extends State<FlappyBird> {
  //bird variables
  static double birdY = 0;
  double birdX = 0;
  int score = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5; //speed of bird
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  //game settings
  bool gameHasStarted = false;

  //barrier variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = gravity * time * time + velocity * time;
      //print(height);

      setState(() {
        birdY = initialPos - height;
      });
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
      moveMap();

      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
      barrierX = [2, 2 + 1.5];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            title: Center(
              child: Text(
                "GAME OVER \nScore: $score",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.all(7),
                        color: Colors.white,
                        child: Text(
                          "PLAY AGAIN",
                          style: TextStyle(color: Colors.red),
                        ),
                      )))
            ],
          );
        });
  }

  bool birdIsDead() {
    //bird has hit walls
    if (birdY > 1 || birdY < -1 || birdX > 1 || birdX < -1) {
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] < birdWidth && barrierX[i] > -birdWidth) {
        if (birdY < barrierHeight[i][0] - birdHeight ||
            birdY > barrierHeight[i][1] - birdHeight) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdX: birdX,
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      //Top Barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      //Bottom Barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[0][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                      //Top Barrier 1
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[1][0],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: false,
                      ),
                      //Bottom Barrier 1
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierHeight: barrierHeight[1][1],
                        barrierWidth: barrierWidth,
                        isThisBottomBarrier: true,
                      ),
                      Container(
                        alignment: Alignment(0, -0.3),
                        child: gameHasStarted
                            ? const Text("")
                            : const Text(
                                "T A P  T O  P L A Y",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
