import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mobilegame/components/player.dart';
import 'package:mobilegame/pixel_game.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<PixelGame>, CollisionCallbacks{
  Checkpoint({position, size}) : super(position: position, size: size);


  @override
  FutureOr<void> onLoad() {
    debugMode = false;

    add(RectangleHitbox(
      position: Vector2(18, 56),
      size: Vector2(12,8),
      collisionType: CollisionType.passive,
    ));

    animation = SpriteAnimation.fromFrameData(game.images.fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
    SpriteAnimationData.sequenced(amount: 1, stepTime: 1, textureSize: Vector2.all(64)),
    );
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player) _reachCheckpoint();
    super.onCollisionStart(intersectionPoints, other);
  }

  void _reachCheckpoint() async{
    if(game.playSounds){
      await FlameAudio.play('after_finish.wav',volume: game.soundVolume);
    }
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
    SpriteAnimationData.sequenced(amount: 26, stepTime: 0.05, textureSize: Vector2.all(64),
    loop: false)
    );

    await animationTicker?.completed;
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
    SpriteAnimationData.sequenced(amount: 10, stepTime: 0.05, textureSize: Vector2.all(64),)
    );
  }
     
}