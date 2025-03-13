import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:mobilegame/main_menu.dart';
import 'package:mobilegame/pixel_game.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  // PixelGame game = PixelGame();
  // runApp(GameWidget(game: kDebugMode ? PixelGame() : game));
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel Game',
      home: MainMenu(),
    );
  }
}