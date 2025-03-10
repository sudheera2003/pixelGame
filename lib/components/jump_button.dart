import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:mobilegame/pixel_game.dart';

class JumpButton extends SpriteComponent with HasGameRef<PixelGame>, TapCallbacks{
  JumpButton();

  final double margin = -10;
  final double buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));
    size = Vector2(buttonSize, buttonSize);

    position = Vector2(
      gameRef.cam.viewport.virtualSize.x - margin - buttonSize,
      gameRef.cam.viewport.virtualSize.y - margin - buttonSize,
    );

    priority = 20; 
    anchor = Anchor.bottomRight; 
    gameRef.cam.viewport.add(this);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
