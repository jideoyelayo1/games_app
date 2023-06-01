import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class HangMan extends StatefulWidget {
  HangMan({super.key});

  @override
  State<HangMan> createState() => _HangManState();
}

class _HangManState extends State<HangMan> {
  String DisplayWord = "Hello World";

  List<String> guessList = [];
  int lives = 14;

  int currentScore = 0, topScore = 0;
  String wordToGuess = "";

  final TextEditingController _controller = TextEditingController();

  getNewWord() async {
    // call when to get new word
    String tmp = await rootBundle.loadString('assets/words.txt');
    List<String> data = tmp.split("\n");
    int len = data.length;
    int random = new DateTime.now().millisecondsSinceEpoch % len;
    String rndWord = data[random];

    print(rndWord);

    setState(() {
      //DisplayWord = wordToGuess;
      currentScore++;
      wordToGuess = rndWord;
      guessList.clear();
    });
    sortDisplay();
  }

  sortDisplay() async {
    String tmpL = await rootBundle.loadString('assets/words.txt');
    List<String> data = tmpL.split("\n");
    int len = data.length;
    int random = new DateTime.now().millisecond % len;
    String rndWord = data[random].toLowerCase();

    String tmp = "";
    for (int i = 0; i < wordToGuess.length; i++) {
      if (guessList.contains(wordToGuess[i])) {
        tmp += wordToGuess[i];
      } else {
        tmp += "_";
      }
    }

    setState(() {
      DisplayWord = tmp;

      if (currentScore > topScore) {
        topScore = currentScore;
      }

      if (lives == 0) {
        DisplayWord = "You lost the word was $wordToGuess";

        currentScore = -1;
        lives = 14;
        wordToGuess = rndWord;
        guessList.clear();
      } else if (!DisplayWord.contains("_")) {
        DisplayWord = "You gussed it right the word was $wordToGuess";
        currentScore++;
        wordToGuess = rndWord;
        guessList.clear();
      } else if (DisplayWord.contains("You gussed it right the word was")) {
        currentScore++;
        wordToGuess = rndWord;
        guessList.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // do something
      print("Build Completed");
      getNewWord();
      sortDisplay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HangMan')),
      body: Center(
          child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          //can use Column for vertical and Row for horizontal
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text("Top Score: $topScore ")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: Text("Lives Left: $lives ")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      getNewWord();
                    },
                    child: Text(
                        "Current Score: ${currentScore > 0 ? currentScore : 0} ")),
              ],
            ),
            //Image.asset("assets/guess$lives.png"),
            //Image.asset("assets/guess6.png"), // not working
            Text("Guesses: $guessList"),
            Container(
                color: Colors.white,
                width: 225,
                height: 225,
                child: Image.asset(
                  "assets/hangman/guess${14 - lives}.png",
                  height: 255,
                  width: 255,
                )),
            //Image.network("https://picsum.photos/225"),

            Container(color: Colors.white, child: Text(DisplayWord)),
            Container(
              color: Colors.white,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Guess a letter',
                ),
                onChanged: (text) {
                  //print("First text field: $text");
                  setState(() {
                    if (!guessList.contains(text)) {
                      guessList.add(text);
                      print(text);
                      sortDisplay();
                      if (!wordToGuess.contains(text)) {
                        lives -= 1;
                      }
                    }

                    _controller.clear();
                  });
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  lives = 0;
                  sortDisplay();
                },
                child: const Text("Quit")),
          ],
        ),
      )),
    );
  }
}
