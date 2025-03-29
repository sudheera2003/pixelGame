import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/complete.dart';
import 'package:mobilegame/mainmenu.dart';
import 'package:mobilegame/pixel_game.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late PixelGame game;

  @override
  void initState() {
    super.initState();
    game = PixelGame();
    game.onAllLevelsCompleted = () => _showCompletionScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainMenu()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Complete(
          score: game.score,
          levelName: game.lastCompletedLevel,
          onNextLevel: () {
            if (!game.persistScoreBetweenLevels) {
              game.score = 0;
            }
            game.loadLevel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GameScreen()),
            );
          },
        ),
      ),
    );
  }
}