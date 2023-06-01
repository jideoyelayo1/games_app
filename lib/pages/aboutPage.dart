import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Practice')),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
//can use Column for vertical and Row for horizontal
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Mobile Development Practice Repository"),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri url =
                        Uri.parse('https://github.com/jideoyelayo1');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: InkWell(
                    child: Image.network(
                      "https://avatars.githubusercontent.com/u/41443216?s=400&u=6a13f9c507a3f7c50dfa68aff7a4b61ff587a55f&v=4",
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Welcome to my mobile development practice app! \nThis app is a collection of various games and apps that I have built to practice and improve my skills in mobile development using Flutter and Dart."),
                    Text(
                      """Features
Hangman: Enjoy the classic word-guessing game, where you have to guess the secret word before the hangman is complete.

Snake: Challenge yourself with the timeless Snake game. Control the snake and try to eat as much food as possible without hitting the walls or yourself.

Flappy Bird: Test your reflexes with this addictive game. Navigate a bird through a series of pipes and see how far you can fly.

Cookie Clicker: Click, click, and click! Earn points by clicking on cookies and unlock various upgrades to increase your cookie production.

GPS-based App: Explore a location-based experience. Use the app to discover nearby points of interest, set reminders based on your location, or track your outdoor activities.

Camera-based App: Dive into the world of photography. Capture and edit images, apply filters, and unleash your creativity using the app's camera functionalities.

...and more exciting projects to come!""",
                    ),
                    Text(
                      """Purpose
This app serves as a platform for me to experiment, practice, and showcase my skills in mobile app development. Through this project, I aim to improve my proficiency in Dart, Flutter, Android Studio, and Git while delivering engaging and entertaining experiences for users.""",
                    ),
                    Text(
                      """Feedback and Contributions
I welcome your feedback and contributions to help me enhance my skills and the app itself. If you have any suggestions, feature requests, or bug reports, please feel free to reach out by opening an issue on the GitHub repository. I appreciate your input and value the opportunity to learn from others in the developer community.""",
                    ),
                  ],
                ),
                Image.asset('images/image0.jpg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
