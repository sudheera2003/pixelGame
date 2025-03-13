import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mobilegame/components/player.dart';
import 'package:mobilegame/pixel_game.dart';

class Spike extends SpriteComponent with HasGameRef<PixelGame>, CollisionCallbacks {
  Spike({position, size}) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    debugMode = false;
    
    final spikeHitbox = RectangleHitbox(
      position: Vector2(0, 10),
      size: Vector2(16, 10),
      collisionType: CollisionType.passive,
    );

    add(spikeHitbox);

    final spriteSheet = await game.images.load('Traps/Spikes/idle.png');
    sprite = Sprite(spriteSheet);

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Player) {
      other.collidedWithEnemy();
    }
  }
}
