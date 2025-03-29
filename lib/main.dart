import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:mobilegame/mainmenu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel Ninja',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to main menu after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF1A1A2E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 225, 140, 247)],
                ).createShader(bounds),
                child: const Text(
                  'PIXEL NINJA',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PixelifySans',
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 100,
                height: 24,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: 100 * _loadingProgress,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'LOADING...',
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'PixelifySans',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _loadingProgress = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Animate loading progress from 0 to 1
    Future.doWhile(() async {
      if (_loadingProgress >= 1.0) return false;
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() => _loadingProgress += 0.05);
      return true;
    });
  }
}