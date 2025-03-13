import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/pixel_game.dart';

class GameScreen extends StatelessWidget {
  final PixelGame game = PixelGame();

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
                // Navigate back to Main Menu
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
