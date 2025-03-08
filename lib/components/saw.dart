import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mobilegame/pixel_game.dart';

class Saw extends SpriteAnimationComponent with HasGameRef<PixelGame>{
  final bool isVertical;
  final double offneg;
  final double offpos;
  Saw({this.isVertical = false, this.offneg = 0, this.offpos = 0 ,position, size}) : super(position: position, size: size);

  static const double stepTime = 0.03;
  static const double moveSpeed = 50;
  static const tileSize = 16;
  double moveDirection = 1;
  double rangeNeg = 0;
  double rangePos = 0;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    add(CircleHitbox());
    debugMode = false;

    if(isVertical) {
      rangeNeg = position.y - offneg * tileSize;
      rangePos = position.y + offpos * tileSize;
    } else {
      rangeNeg = position.x - offneg * tileSize;
      rangePos = position.x + offpos * tileSize;
    }

    animation = SpriteAnimation.fromFrameData(game.images.fromCache('Traps/Saw/On (38x38).png'), 
    SpriteAnimationData.sequenced(amount: 8, stepTime: stepTime, textureSize: Vector2.all(38)));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(isVertical) {
      _moveVerfically(dt);
    }else {
      _moveHorizontally(dt);
    }
    super.update(dt);
  }
  
  void _moveVerfically(double dt) {
    if(position.y >= rangePos){
      moveDirection = -1;
    } else if (position.y <= rangeNeg){
      moveDirection = 1;
    }
    position.y += moveDirection * moveSpeed * dt;
  }
  
  void _moveHorizontally(double dt) {
    if(position.x >= rangePos){
      moveDirection = -1;
    } else if (position.x <= rangeNeg){
      moveDirection = 1;
    }
    position.x += moveDirection * moveSpeed * dt;
  }
}