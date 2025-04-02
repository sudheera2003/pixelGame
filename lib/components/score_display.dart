import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/pixel_game.dart';

class ScoreDisplay extends Component with HasGameRef<PixelGame> {
  late TextComponent scoreText;

  @override
  Future<void> onLoad() async {
    scoreText = TextComponent(
      text: 'Score: ${gameRef.score}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontFamily: 'Arial',
          shadows: [
            Shadow(
              blurRadius: 2,
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
      position: Vector2(425, 30),
    );
    
    add(scoreText);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    scoreText.text = 'Score: ${gameRef.score}';
    super.update(dt);
  }
  
}