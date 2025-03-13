import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:mobilegame/components/jump_button.dart';
import 'package:mobilegame/components/player.dart';
import 'package:mobilegame/components/level.dart';

class PixelGame extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection, TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late CameraComponent cam;
  Player player = Player(character: 'Ninja Frog');
  late JoystickComponent joystick;
  late JumpButton jumpButton;
  bool showJoystick = false;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = ['Level-02'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    // Cache image load
    await images.loadAllImages();

    await _loadLevel();

    if (showJoystick) {
      addJoystick();
      addJumpButton();
    }

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

    // Add the joystick to the camera's viewport
    cam.viewport.add(joystick);
  }

  void addJumpButton() {
    jumpButton = JumpButton();
    cam.viewport.add(jumpButton);
  }
  

  void updateJoystick() {
    if (joystick.parent == null || !joystick.parent!.isMounted) {
      return; // Skip update if the joystick is not mounted
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
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
    } else {
      currentLevelIndex = 0;
    }
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    // Remove the old level and camera
    if (children.isNotEmpty) {
      removeAll(children);
    }

    // Load the new level
    Level world = Level(levelName: levelNames[currentLevelIndex], player: player);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    // Add the new level and camera
    addAll([cam, world]);

    // Re-add the joystick and JumpButton if enabled
    if (showJoystick) {
      addJoystick();
      addJumpButton();
    }
  }
}