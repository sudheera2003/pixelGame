import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mobilegame/components/custom_hitbox.dart';
import 'package:mobilegame/pixel_game.dart';

class Fruit extends SpriteAnimationComponent
    with HasGameRef<PixelGame>, CollisionCallbacks {
  final String fruit;
  Fruit({this.fruit = 'Apple', position, size})
      : super(position: position, size: size);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final double stepTime = 0.05;
  final hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 10,
    width: 12,
    height: 12,
  );

  bool collected = false;
  late final int _points;

  @override
  FutureOr<void> onLoad() async {
    debugMode = false;
    priority = -1;
    
    // Initialize points based on fruit type
    _points = _getPointsForFruit(fruit);

    // Set up hitbox
    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
      collisionType: CollisionType.passive,
    ));

    // Load animation
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/$fruit.png'),
      SpriteAnimationData.sequenced(
        amount: 17, 
        stepTime: stepTime, 
        textureSize: Vector2.all(32),
    ));
    
    return super.onLoad();
  }

  int _getPointsForFruit(String fruitType) {
    switch (fruitType) {
      case 'Cherries': return 20;
      case 'Bananas': return 15;
      default: return 10;
    }
  }

  Future<void> _updateScores(int newScore) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final userRef = _firestore.collection('users').doc(user.uid);
      final batch = _firestore.batch();
      
      // Always update current score
      batch.update(userRef, {
        'currentScore': newScore,
      });

      // Check and update high score if needed
      final currentHigh = (await userRef.get()).data()?['highScore'] ?? 0;
      
      if (newScore > currentHigh) {
        batch.update(userRef, {
          'highScore': newScore,
        });
      }

      await batch.commit();
    } catch (e) {
      print('Error updating scores: $e');
      // Consider adding error handling/retry logic here
    }
  }

  void collidedWithPlayer() async {
    if (collected) return;
    
    collected = true;
    
    // Play sound if enabled
    if (game.playSounds) {
      try {
        FlameAudio.play('collect_fruit.wav', volume: game.soundVolume);
      } catch (e) {
        print('Error playing sound: $e');
      }
    }

    // Update game score
    gameRef.score += _points;
    
    // Update scores in Firestore (don't await to avoid frame drops)
    _updateScores(gameRef.score);

    // Change to collected animation
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Items/Fruits/Collected.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );

    // Wait for animation to complete before removing
    await animationTicker?.completed;
    if (isMounted) {
      removeFromParent();
    }
  }
}