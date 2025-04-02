import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:mobilegame/components/jump_button.dart';
import 'package:mobilegame/components/player.dart';
import 'package:mobilegame/components/level.dart';
import 'package:mobilegame/components/score_display.dart';
import 'package:mobilegame/complete.dart';
import 'package:flutter/material.dart';

class PixelGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  String get currentLevelName => levelNames[currentLevelIndex];

  late CameraComponent cam;
  Player player = Player(character: 'Ninja Frog');
  late JoystickComponent joystick;
  late JumpButton jumpButton;
  bool showJoystick = true;
  bool playSounds = true;
  double soundVolume = 1.0;

  List<String> levelNames = ['Level-01', 'Level-02', 'Level-03', 'Level-04', 'Level-05'];
  int currentLevelIndex = 0;
  String lastCompletedLevel = '';

  int score = 0;
  int highScore = 0;
  bool persistScoreBetweenLevels = false;

  // Callback management
  VoidCallback? _onAllLevelsCompleted;
  
  VoidCallback? get onAllLevelsCompleted => _onAllLevelsCompleted;
  set onAllLevelsCompleted(VoidCallback? callback) => _onAllLevelsCompleted = callback;

  PixelGame({VoidCallback? onAllLevelsCompleted}) {
    _onAllLevelsCompleted = onAllLevelsCompleted;
  }

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    await loadLevel();

    if (showJoystick) {
      addJoystick();
      addJumpButton();
    }
    cam.viewport.add(ScoreDisplay());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 20,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 50, bottom: 50),
    );
    cam.viewport.add(joystick);
  }

  void addJumpButton() {
    jumpButton = JumpButton();
    cam.viewport.add(jumpButton);
  }
  
  void updateJoystick() {
    if (joystick.parent == null || !joystick.parent!.isMounted) {
      return;
    }

    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    lastCompletedLevel = levelNames[currentLevelIndex]; 
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      loadLevel();
    } else {
      // All levels completed
      currentLevelIndex = 0;
      _onAllLevelsCompleted?.call();
    }
  }

  Future<void> loadLevel() async {
    if (children.isNotEmpty) {
      removeAll(children);
    }
    
    if (!persistScoreBetweenLevels && currentLevelIndex == 0) {
      score = 0;
    }

    Level world = Level(levelName: levelNames[currentLevelIndex], player: player);

    player.gotHit = false;
    player.reachedCheckpoint = false;
    player.velocity = Vector2.zero();

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    if (showJoystick) {
      addJoystick();
      addJumpButton();
    }
    cam.viewport.add(ScoreDisplay());
  }

  void showLevelCompleteScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Complete(
          score: score,
          levelName: currentLevelName,
          onNextLevel: () {
            Navigator.pop(context);
            loadNextLevel();
          },
        ),
      ),
    );
  }

  void updateHighScore() {
    if (score > highScore) {
      highScore = score;
    }
  }
}